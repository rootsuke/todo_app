require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup do
    @task = build(:task)
  end

  test 'should be valid' do
    @task.save
    assert(@task.valid?)
  end

  test 'should not be valid without title' do
    @task.title = nil
    @task.save
    assert_not(@task.valid?)
  end

  test 'should not be valid without content' do
    @task.content = nil
    @task.save
    assert_not(@task.valid?)
  end
end
