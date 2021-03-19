class Remove < ActiveRecord::Migration[5.1]
  def change
      remove_foreign_key :teachers, :accounts
  end
end
