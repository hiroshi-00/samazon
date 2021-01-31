class User < ApplicationRecord
  has_many :reviews
  extend DisplayList
  extend SwitchFlg
  has_many :likes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
  def already_liked?(product)
    self.likes.exists?(product_id: product.id)
  end
  
  scope :search_information, -> (keyword) { 
    where("name like ?","%#{keyword}%").
    or(where("email like ?","%#{keyword}%")).
    or(where("address like ?","%#{keyword}%")).
    or(where("postal_code like ?","%#{keyword}%")).
    or(where("phone like ?","%#{keyword}%")).
    or(where("id ?","%#{keyword}%"))
  }
  
  def update_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
 
    result = update(params, *options)
    clean_up_passwords
    result
  end
end
