# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :confirmable, :trackable

  belongs_to :role, optional: true
end
