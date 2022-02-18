class Season < ApplicationRecord
  belongs_to :poster, class_name: 'Image'
  belongs_to :series
end
