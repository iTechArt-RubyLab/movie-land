class MovieStaff < ApplicationRecord
  belongs_to :movie
  belongs_to :person
  belongs_to :staff_type
end
