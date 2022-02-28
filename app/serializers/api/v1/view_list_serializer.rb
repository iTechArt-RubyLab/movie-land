# == Schema Information
#
# Table name: view_lists
#
#  id         :bigint           not null, primary key
#  watching_status :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_view_lists_on_movie_id  (movie_id)
#  index_view_lists_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (user_id => users.id)
#
module Api
  module V1
    class ViewListSerializer < ActiveModel::Serializer
      attributes :id, :watching_status
      belongs_to :user, serializer: UserSerializer
      belongs_to :movie, serializer: MovieSerializer
    end
  end
end
