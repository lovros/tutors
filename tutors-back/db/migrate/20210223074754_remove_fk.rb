class RemoveFk < ActiveRecord::Migration[5.1]
  def change
    remove_column :accounts, :teachers_id
  end
end
