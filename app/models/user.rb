class User < ApplicationRecord
  has_many :reviews
  has_many :likes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
  def already_liked?(product)
    self.likes.exists?(product_id: product.id)
  end
  
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
