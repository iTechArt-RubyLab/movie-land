class Role < ApplicationRecord
  def self.admin
    find_or_create_by(name: 'Admin',
                      can_give_role: true,
                      can_create_role: true,
                      can_read_entities: true,
                      can_edit_entities: true,
                      can_leave_rating: true,
                      can_read_rating: true,
                      can_read_movies: true,
                      can_edit_movies: true,
                      can_create_movie_without_approve: true,
                      can_approve_movies: true,
                      can_approve_redactor: true)
  end

  def self.redactor
    find_or_create_by(name: 'Redactor',
                      can_give_role: false,
                      can_create_role: false,
                      can_read_entities: true,
                      can_edit_entities: true,
                      can_leave_rating: true,
                      can_read_rating: true,
                      can_read_movies: true,
                      can_edit_movies: true,
                      can_create_movie_without_approve: true,
                      can_approve_movies: true,
                      can_approve_redactor: false)
  end

  def self.reviewer
    find_or_create_by(name: 'Reviewer',
                      can_give_role: false,
                      can_create_role: false,
                      can_read_entities: false,
                      can_edit_entities: false,
                      can_leave_rating: true,
                      can_read_rating: true,
                      can_read_movies: true,
                      can_edit_movies: false,
                      can_create_movie_without_approve: false,
                      can_approve_movies: false,
                      can_approve_redactor: false)
  end
end
