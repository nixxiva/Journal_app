class Task < ApplicationRecord
  belongs_to :category

  validates :task_name, presence:true
  validates :definition, presence:true, length: {minimum: 5, maximum: 100}
  validates :due_date, presence: true
  validates :category, presence: true
end
