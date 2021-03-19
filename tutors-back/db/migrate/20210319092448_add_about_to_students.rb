class AddAboutToStudents < ActiveRecord::Migration[5.1]
  def change
        add_column :students, :about, :text
  end
end
