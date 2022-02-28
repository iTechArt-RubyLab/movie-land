# == Schema Information
#
# Table name: movie_staffs
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  movie_id      :bigint           not null
#  staff_id      :bigint           not null
#  staff_type_id :bigint           not null
#
# Indexes
#
#  index_movie_staffs_on_movie_id                                 (movie_id)
#  index_movie_staffs_on_staff_id                                 (staff_id)
#  index_movie_staffs_on_staff_type_id                            (staff_type_id)
#  index_movie_staffs_on_staff_type_id_and_movie_id_and_staff_id  (staff_type_id,movie_id,staff_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (staff_id => people.id)
#  fk_rails_...  (staff_type_id => staff_types.id)
#
class MovieStaff < ApplicationRecord
  belongs_to :movie
  belongs_to :staff, class_name: 'Person'
  validates :staff_id, uniqueness: { scope: :movie_id, message: 'This movie staff already appointed' }
end
