# == Schema Information
#
# Table name: movie_staffs
#
#  id         :bigint           not null, primary key
#  staff_type :integer          default("director"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :bigint           not null
#  staff_id   :bigint           not null
#
# Indexes
#
#  index_movie_staffs_on_movie_id                              (movie_id)
#  index_movie_staffs_on_movie_id_and_staff_id_and_staff_type  (movie_id,staff_id,staff_type) UNIQUE
#  index_movie_staffs_on_staff_id                              (staff_id)
#  index_movie_staffs_on_staff_type                            (staff_type) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (staff_id => people.id)
#
class MovieStaff < ApplicationRecord
  belongs_to :movie
  belongs_to :staff, class_name: 'Person'
  validates :staff_type, uniqueness: { scope: %i[movie_id staff_id], message: 'This movie staff already appointed' }
  enum staff_type: {
    director: 0,
    editor: 1,
    compositor: 2,
    artist: 3,
    producer: 4,
    screencaster: 5
  }
end
