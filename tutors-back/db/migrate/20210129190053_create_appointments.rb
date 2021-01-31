class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.datetime :startDateTime

      t.timestamps
    end
  end
end
