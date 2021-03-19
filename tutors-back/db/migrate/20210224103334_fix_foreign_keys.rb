class FixForeignKeys < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :teachers, :accounts
    remove_column :students, :accounts_id
    remove_column :teachers, :accounts_id
    add_column :accounts, :account_user_id, :integer
  end
end
