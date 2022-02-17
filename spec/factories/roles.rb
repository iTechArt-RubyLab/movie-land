FactoryBot.define do
  factory :role do
    name { 'MyString' }
    can_give_role { false }
    can_create_role { false }
    can_read_entities { false }
    can_edit_entities { false }
    can_leave_rating { false }
    can_read_rating { false }
    can_read_movies { false }
    can_edit_movies { false }
    can_create_movie_without_approve { false }
    can_approve_movies { false }
    can_approve_redactor { false }
  end
end
