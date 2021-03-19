class RemoveAuthenticationFromTeachersAndStudents < ActiveRecord::Migration[5.1]
  def change
    remove_column :students, :password_digest, :string
	remove_column :students, :email, :string
	remove_column :teachers, :password_digest, :string
	remove_column :teachers, :email, :string
	
  end
end
