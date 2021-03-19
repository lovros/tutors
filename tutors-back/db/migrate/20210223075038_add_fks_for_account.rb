class AddFksForAccount < ActiveRecord::Migration[5.1]
  def change
    add_reference :teachers, :accounts, index:true, foreign_key:true

  end
end
