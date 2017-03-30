class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.date :date_start
      t.date :date_end
      t.integer :guest
      t.references :user, index: true, foreign_key: true
      t.references :listing, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
