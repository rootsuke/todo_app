# create Tasks
tasks = []
100.times do |i|
  tasks << Task.new(title: "task_#{i}", content: "content_#{i}")
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
