class AddSubjectToInquiries < ActiveRecord::Migration[7.1]
  def change
    add_column :inquiries, :subject, :string
  end
end
