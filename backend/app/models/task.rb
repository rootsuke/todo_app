class Task < ApplicationRecord
  has_one :is_finish_task

  validates :title, presence: true
  validates :content, presence: true

  class << self
    def get
      Task.left_outer_joins(:is_finish_task)
        .select("tasks.id AS task_id",
                "tasks.title",
                "tasks.content",
                "is_finish_tasks.finish_type")
        .order("tasks.created_at DESC")
    end
  end
end
