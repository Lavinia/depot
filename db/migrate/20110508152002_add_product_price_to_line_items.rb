class AddProductPriceToLineItems < ActiveRecord::Migration
  def self.up
    add_column :line_items, :product_price, :integer
  end

  def self.down
    remove_column :line_items, :product_price
  end
end
