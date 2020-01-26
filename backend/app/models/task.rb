class Task < ApplicationRecord
  has_one :is_finish_task

  validates :title, presence: true
  validates :content, presence: true
end
