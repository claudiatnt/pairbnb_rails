class AddAdditionalColumnToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :room_number, :integer
    add_column :listings, :bed_number, :integer
    add_column :listings, :price, :integer
    add_column :listings, :country, :string
    add_column :listings, :state, :string
    add_column :listings, :city, :string
    add_column :listings, :zipcode, :string
    add_column :listings, :description, :string
    add_column :listings, :property_type, :string
  end
end
