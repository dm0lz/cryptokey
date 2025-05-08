class RenameFromAndToInEmails < ActiveRecord::Migration[8.0]
  def change
    rename_column :emails, :from, :from_email
    rename_column :emails, :to, :to_email
  end
end
