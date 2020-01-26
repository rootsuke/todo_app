class IsFinishTask < ApplicationRecord
  belongs_to :task

  validates :task_id, presence: true
  validates :finish_type, presence: true
end
