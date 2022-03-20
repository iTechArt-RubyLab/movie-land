# == Schema Information
#
# Table name: view_lists
#
#  id              :bigint           not null, primary key
#  watching_status :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  movie_id        :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_view_lists_on_movie_id              (movie_id)
#  index_view_lists_on_user_id               (user_id)
#  index_view_lists_on_user_id_and_movie_id  (user_id,movie_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe ViewList, type: :model do
  subject(:view_list) { create :view_list }

  include_context 'with unique cleaner'

  context 'with valid attributes' do
    it { expect(view_list).to be_valid }
  end

  describe '#watching_status' do
    context 'when watching_status is will_watch' do
      it { expect(view_list).to transition_from(:watching, :viewed).to(:will_watch).on_event(:will_watching) }
    end

    context 'when watching status is watching' do
      it { expect(view_list).to transition_from(:will_watch, :viewed).to(:watching).on_event(:now_watching) }
    end

    context 'when watching status is viewed' do
      it { expect(view_list).to transition_from(:will_watch, :watching).to(:viewed).on_event(:already_viewed) }
    end

    context 'when watching status is invalid' do
      it { expect(view_list).not_to transition_from(:will_watch).to(:viewed).on_event(:will_watching) }
    end
  end
end
