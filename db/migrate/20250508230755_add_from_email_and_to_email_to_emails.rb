class AddFromEmailAndToEmailToEmails < ActiveRecord::Migration[8.0]
  def change
    unless column_exists?(:emails, :from_email)
      add_column :emails, :from_email, :string
    end
    unless column_exists?(:emails, :to_email)
      add_column :emails, :to_email, :string
    end
  end
end
