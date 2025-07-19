# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.8
# gemのコンパイルエラーを防ぐため、-slimではない標準イメージを使用
FROM registry.docker.com/library/ruby:$RUBY_VERSION as base

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test"


# ------------------------------------------------------------------------------------
# 1段階目: ビルドステージ (gemのインストールやアセットコンパイルを行う)
# ------------------------------------------------------------------------------------
FROM base as build

# Install build-time dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential git libvips curl && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Install application gems
COPY Gemfile Gemfile.lock ./

# Install latest bundler and force use of default gems
RUN gem update --system && \
    gem install bundler && \
    bundle config set --local use_default_gems true

# Run bundle install
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*.git

# Copy application code
COPY . .

RUN chmod +x bin/*

# Precompile assets
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile


# ------------------------------------------------------------------------------------
# 2段階目: 最終ステージ (実際にアプリケーションを動かす)
# ------------------------------------------------------------------------------------
FROM base

# Install run-time dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends libjemalloc2 libvips && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Copy built artifacts from build stage
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Create and switch to a non-root user
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails .

USER rails:rails

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default
EXPOSE 3000
CMD ["./bin/rails", "server"]