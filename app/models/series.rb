class Series < ApplicationRecord
  belongs_to :poster, class_name: 'Image'
end
