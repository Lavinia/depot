class Product < ActiveRecord::Base
  default_scope :order => 'title' # show in alphabetic order.
  has_many :line_items    #each product may have many line-items referencing it.
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01} 
  validates :title, :uniqueness => true, :length => { :minimum => 10, :message => "Too short!"}
  validates :image_url, :format => {
    :with => %r{\.(gif|jpg|png)$}i,
    :message => "Must be a URL for GIF, JPG or PNG image."
  }
  
  private
  
    #ensure that there are no line items referencing this product. Hook-method = method thats being called at a given point in an object´s life. Here before we destroy a row in db.
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
