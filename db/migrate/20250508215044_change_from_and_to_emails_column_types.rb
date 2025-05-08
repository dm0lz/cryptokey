class ChangeFromAndToEmailsColumnTypes < ActiveRecord::Migration[8.0]
  def change
    add_column :emails, :from_emails, :string, array: true, default: []
    add_column :emails, :to_emails, :string, array: true, default: []
  end
end
