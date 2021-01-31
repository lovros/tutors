class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :text
      t.datetime :sentDateTime

      t.timestamps
    end
  end
end
