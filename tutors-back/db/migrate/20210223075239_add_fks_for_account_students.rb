class AddFksForAccountStudents < ActiveRecord::Migration[5.1]
  def change
    add_reference :students, :accounts, index:true, foreign_key:true

  end
end
