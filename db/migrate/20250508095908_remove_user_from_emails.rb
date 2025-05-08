class RemoveUserFromEmails < ActiveRecord::Migration[8.0]
  def change
    remove_reference :emails, :user, null: false, foreign_key: true
  end
end
