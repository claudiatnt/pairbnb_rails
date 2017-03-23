class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :address
      t.integer :pax
      t.references :user, index: true, foreign_key: true
      # t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
