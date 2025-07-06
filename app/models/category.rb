class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks
  # <!-- accepts_nested_attributes_for :tasks, allow_destroy: true -->

  validates :title, presence: true
  validates :body, presence: true, length: {minimum: 5, maximum: 100}
end
