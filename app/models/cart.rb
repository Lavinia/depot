class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy   #lineiten kan bara finnas i en cart. Ta bort cart så försvinner line-item.
end
