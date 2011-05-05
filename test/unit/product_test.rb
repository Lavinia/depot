require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  
 
  test "product is not valid without a unique title" do
     product = Product.new(:title  => products(:ruby).title,  # test assumes thar the title already exists in db- 
                            :description => "yyy",
                            :price => 1,
                            :image_url => "zzz.jpg")
    assert !product.save
    assert_equal "has already been taken", product.errors[:title].join('; ')
  end
  
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be positive" do
    product = Product.new(:title  => "my book Title",
                          :description => "yyy",
                          :image_url => "zzz.jpg")
    product.price = -1  #if price is below 0
    assert product.invalid? #make sure it is not valid
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')  #make sure u get the right error-message.
    
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
      
    product.price = 1
    assert product.valid?
  end
  
  #test if image_url is ok. First create new product, then use it to test with.
  def new_product(image_url)
    Product.new(:title  => "my book Title",
                          :description => "yyy",
                          :price => 1,
                          :image_url => image_url)
  end
  
  #loop thru several testcases in the same time to see if they work.
  test "image_url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end
    
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end
  
end
