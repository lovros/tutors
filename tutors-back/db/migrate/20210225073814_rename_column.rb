class RenameColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :accounts, :user_type, :account_user_type
  end
end
