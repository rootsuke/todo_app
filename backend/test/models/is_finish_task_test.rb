require 'test_helper'

class IsFinishTaskTest < ActiveSupport::TestCase
  setup do
    @is_finish_task = create(:is_finish_task)
  end

  test 'should be valid' do
    @is_finish_task.save
    assert(@is_finish_task.valid?)
  end

  test 'should not be valid without task' do
    @is_finish_task.task_id = nil
    @is_finish_task.save
    assert_not(@is_finish_task.valid?)
  end

  test 'should not be valid without finish_type' do
    @is_finish_task.finish_type = nil
    @is_finish_task.save
    assert_not(@is_finish_task.valid?)
  end
end
