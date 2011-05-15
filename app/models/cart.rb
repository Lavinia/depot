class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy   #lineiten kan bara finnas i en cart. Ta bort cart så försvinner line-item.
  
  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)  #dynamic method ActiveRecord creates.
    if current_item
      current_item.quantity += 1
    else
      product = Product.find(product_id)
      current_item = line_items.build(:product_id => product_id, :product_price => product.price)
    end
    current_item
  end
  
  def total_price
    line_items.to_a.sum {|item| item.total_price}
  end

end
