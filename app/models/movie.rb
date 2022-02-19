class Movie < ApplicationRecord
  validates :name, length: { in: 2..300 }
  validates :description, length: { in: 2..500 }
  validates :tagline, length: { in: 2..300 }
  validates :trailer, url: true
  validates :age_limit, numericality: { only_integer: true }, inclusion: { in: 1..100 }
  validates :budget, numericality: { only_integer: true, greater_than: 0 }
  validates :duration, numericality: { only_integer: true, greater_than: 1 }
end