class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :hashed_password
      t.string :photo
      t.references :appointments, foreign_key: true

      t.timestamps
    end
  end
end
