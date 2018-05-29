class User < ApplicationRecord
  devise :database_authenticatable, :lockable, :timeoutable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :links
end
