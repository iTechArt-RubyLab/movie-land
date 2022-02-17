class Image < ApplicationRecord
  validates :link, presence: true, format: { with: /\.(gif|jpg|png)\z/i }
end
