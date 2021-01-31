class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :students, :hashed_password, :password_digest
	rename_column :teachers, :hashed_password, :password_digest
  end
end
