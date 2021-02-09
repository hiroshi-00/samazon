class ShoppingCartItem < ApplicationRecord
  acts_as_shopping_cart_item
  
  scope :keep_item_ids, -> (cart_id) { where(owner_id: cart_id).pluck(:id) }
  scope :user_cart_items, -> (user_shoppingcart) { where(owner_id: user_shoppingcart) }
  scope :bought_items, -> (item_ids) { where(item_id: item_ids) }
  scope :order_updated_at_desc, -> { order(updated_at: :desc) }
  scope :user_cart_item_ids, -> (user_shoppingcart) { where(owner_id: user_shoppingcart).pluck(:item_id) }
end
