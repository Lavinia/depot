class Product < ActiveRecord::Base
  default_scope :order => 'title' # show in alphabetic order.
  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01} 
  validates :title, :uniqueness => true, :length => { :minimum => 10, :message => "Too short!"}
  validates :image_url, :format => {
    :with => %r{\.(gif|jpg|png)$}i,
    :message => "Must be a URL for GIF, JPG or PNG image."
  }
  
end
