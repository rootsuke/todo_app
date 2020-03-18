# create User
users = []
50.times do |i|
  users << User.new(name: Faker::Games::Pokemon.name)
end
User.import(users)

# create Tasks
tasks = []
user_ids = User.pluck(:id)
user_ids.each_with_index do |user_id, i|
  tasks << Task.new(title: "task_#{i}", content: "content_#{i}", user_id: user_id)
end
Task.import(tasks)

# create IsFinishTask
is_finish_tasks = []
task_ids = Task.pluck(:id)
types = [1, 2]
50.times do
  is_finish_tasks << IsFinishTask.new(task_id: task_ids.shift, finish_type: types.sample)
end
IsFinishTask.import(is_finish_tasks)
