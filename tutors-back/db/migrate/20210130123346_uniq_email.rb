class UniqEmail < ActiveRecord::Migration[5.1]
  def change
      change_column :students, :email, :string, null: false, unique: true
	  change_column :teachers, :email, :string, null: false, unique: true
  end
end
