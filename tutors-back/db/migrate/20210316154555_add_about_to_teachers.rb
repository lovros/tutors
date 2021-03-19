class AddAboutToTeachers < ActiveRecord::Migration[5.1]
  def change
      add_column :teachers, :about, :text
  end
end
