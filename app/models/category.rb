# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  award_id   :bigint           not null
#
# Indexes
#
#  index_categories_on_award_id  (award_id)
#
# Foreign Keys
#
#  fk_rails_...  (award_id => awards.id)
#
class Category < ApplicationRecord
  belongs_to :award
end
