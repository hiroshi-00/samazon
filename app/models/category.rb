class Category < ApplicationRecord
  has_many :products
  
  scope :major_categories, -> { pluck(:major_category_name).uniq }
  
  # def self.major_categories
  #   pluck(:major_category_name).uniq
  # end
  
  # scope :request_category, -> (category) {
  #   if category != "none"
  #     find(category.to_i)
  #   else
  #     ""
  #   end
  # }
  
  # scope :request_category, -> (category) { find(category.to_i) }
  
  def self.request_category(category)
    find(category.to_i)
  end
end
