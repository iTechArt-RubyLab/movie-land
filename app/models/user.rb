class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: { minimum: 2, maximum: 25 }
  validates :surname, length: { minimum: 2, maximum: 25 }
  validates :username, presence: true, length: { minimum: 4, maximum: 20 }, uniqueness: true
  validates :birthday, presence: true
end
