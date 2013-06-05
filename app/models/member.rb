class Member < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :price, :caps
  
  scope :alphabetical, order('last_name, first_name')
  
  def name
      "#{last_name}, #{first_name}"
  end


end
