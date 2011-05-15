class ChangeLineItemProductPriceToDecimal < ActiveRecord::Migration
  def self.up
    change_table :line_items do |t|
      t.change :product_price, :decimal, :precision => 8, :scale => 2
    end
  end

  def self.down
    change_table :line_items do |t|
      t.change :product_price, :integer 
    end  
  end
end
