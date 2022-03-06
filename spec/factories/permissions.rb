# == Schema Information
#
# Table name: permissions
#
#  id                  :bigint           not null, primary key
#  can_edit_award      :boolean
#  can_edit_entities   :boolean
#  can_edit_movie      :boolean
#  can_edit_permission :boolean
#  can_edit_person     :boolean
#  can_edit_role       :boolean
#  can_give_rating     :boolean
#  can_give_view_list  :boolean
#  can_lock_user       :boolean
#  can_read_award      :boolean
#  can_read_entities   :boolean
#  can_read_movie      :boolean
#  can_read_person     :boolean
#  can_read_rating     :boolean
#  can_read_user       :boolean
#  can_read_view_list  :boolean
#  can_set_role        :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  role_id             :bigint           not null
#
# Indexes
#
#  index_permissions_on_role_id  (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
FactoryBot.define do
  factory :permission do
    can_lock_user { Faker::Boolean.boolean }
    can_edit_role { Faker::Boolean.boolean }
    can_set_role { Faker::Boolean.boolean }
    can_edit_permission { Faker::Boolean.boolean }
    can_give_rating { Faker::Boolean.boolean }
    can_give_view_list { Faker::Boolean.boolean }
    can_read_view_list { Faker::Boolean.boolean }
    can_edit_person { Faker::Boolean.boolean }
    can_read_movie { Faker::Boolean.boolean }
    can_read_person { Faker::Boolean.boolean }
    can_read_rating { Faker::Boolean.boolean }
    can_read_user { Faker::Boolean.boolean }
    can_edit_movie { Faker::Boolean.boolean }
    can_read_entities { Faker::Boolean.boolean }
    can_edit_entities { Faker::Boolean.boolean }
    can_read_award { Faker::Boolean.boolean }
    can_edit_award { Faker::Boolean.boolean }
    association :role

    trait :admin do
      can_lock_user { true }
      can_edit_role { true }
      can_set_role { true }
      can_edit_permission { true }
      can_give_rating { true }
      can_edit_person { true }
      can_read_movie { true }
      can_give_view_list { true }
      can_read_view_list { true }
      can_read_person { true }
      can_read_rating { true }
      can_read_user { true }
      can_edit_movie { true }
      can_read_entities { true }
      can_edit_entities { true }
      can_read_award { true }
      can_edit_award { true }
      role { create :role, :admin }
    end

    trait :redactor do
      can_lock_user { false }
      can_edit_role { false }
      can_set_role { false }
      can_edit_permission { false }
      can_give_rating { true }
      can_edit_person { true }
      can_read_movie { true }
      can_give_view_list { true }
      can_read_view_list { true }
      can_read_person { true }
      can_read_rating { true }
      can_read_user { true }
      can_edit_movie { true }
      can_read_entities { true }
      can_edit_entities { true }
      can_read_award { true }
      can_edit_award { true }
      role { create :role, :redactor }
    end

    trait :reviewer do
      can_lock_user { false }
      can_edit_role { false }
      can_set_role { false }
      can_edit_permission { false }
      can_give_rating { true }
      can_edit_person { false }
      can_give_view_list { true }
      can_read_view_list { true }
      can_read_movie { true }
      can_read_person { true }
      can_read_rating { true }
      can_read_user { true }
      can_edit_movie { false }
      can_read_entities { false }
      can_edit_entities { false }
      can_read_award { true }
      can_edit_award { false }
      role { create :role, :reviewer }
    end
  end
end
