# == Schema Information
#
# Table name: movie_staffs
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  movie_id      :bigint           not null
#  person_id     :bigint           not null
#  staff_type_id :bigint           not null
#
# Indexes
#
#  index_movie_staffs_on_movie_id       (movie_id)
#  index_movie_staffs_on_person_id      (person_id)
#  index_movie_staffs_on_staff_type_id  (staff_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (person_id => people.id)
#  fk_rails_...  (staff_type_id => staff_types.id)
#
class MovieStaff < ApplicationRecord
  belongs_to :movie
  belongs_to :person
  belongs_to :staff_type
end
