class NotNull < ActiveRecord::Migration[5.1]
  def change
    change_column :students, :firstName, :string, null: false
    change_column :students, :lastName, :string, null: false
    change_column :students, :email, :string, null: false
    change_column :students, :password_digest, :string, null: false

    change_column :teachers, :firstName, :string, null: false
    change_column :teachers, :lastName, :string, null: false
    change_column :teachers, :email, :string, null: false
    change_column :teachers, :password_digest, :string, null: false

  end
end
