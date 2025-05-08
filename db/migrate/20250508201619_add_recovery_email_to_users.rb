class AddRecoveryEmailToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :recovery_email, :string
  end
end
