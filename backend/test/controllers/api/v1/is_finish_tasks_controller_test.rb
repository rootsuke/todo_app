require 'test_helper'

class Api::V1::IsFinishTasksControllerTest < ActionDispatch::IntegrationTest
  # 概要: finish_typeを更新する
  # 期待値: ステータス200, finish_typeが5に更新される
  test "should update" do
    create(:user)
    create(:task)
    create(:is_finish_task)

    task_id = IsFinishTask.first.task_id
    params = { task_id: task_id, finish_type: 5 }

    put api_v1_is_finish_tasks_path, params: params
    res = JSON.parse(@response.body)
    info = res['info']

    assert_response(200)
    assert_equal(5, info['finish_type'])
  end
end
