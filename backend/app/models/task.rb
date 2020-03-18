class Task < ApplicationRecord
  has_one :is_finish_task
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  class << self
    def get
      Task.left_outer_joins(:is_finish_task, :user)
        .select("tasks.id AS task_id",
                "tasks.title",
                "tasks.content",
                "is_finish_tasks.finish_type",
                "users.name AS user_name")
        .order("tasks.created_at DESC")
    end
  end
end
