class AddAccountIdToTeachers < ActiveRecord::Migration[5.1]
  def change
    add_reference :accounts, :teachers, index:true, foreign_key:true
  end
end
