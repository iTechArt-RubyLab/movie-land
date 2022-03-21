# == Schema Information
#
# Table name: movies_tags
#
#  movie_id :bigint           not null
#  tag_id   :bigint           not null
#
# Indexes
#
#  index_movies_tags_on_movie_id_and_tag_id  (movie_id,tag_id) UNIQUE
#  index_movies_tags_on_tag_id_and_movie_id  (tag_id,movie_id) UNIQUE
#
class MoviesTag < ApplicationRecord
  belongs_to :movie
  belongs_to :tag
  accepts_nested_attributes_for :tag

  validates :movie_id, uniqueness: { scope: :tag_id, message: 'This tag already appointed' }
end
