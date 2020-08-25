require 'test_helper'

class Api::V1::TasksControllerTest < ActionDispatch::IntegrationTest
  # 概要: タスク一覧を取得し、件数が合っていることを検証
  # 期待値: ステータス200、20件取得
  test "should get show" do
    create_list(:user, 10)
    create_list(:task, 10)
    create_list(:is_finish_task, 10)

    get api_v1_tasks_path
    res = JSON.parse(@response.body)
    info = res['info']
    assert_response(200)
    assert_equal(20, info.size)
  end

  # 概要: タスク一覧を取得し、内容を検証
  # 期待値: 3件取得し、予測する内容であること
  test "should match task attributes" do
    create(:task)
    create(:is_finish_task)
    create(:is_finish_task, finish_type: 2)

    get api_v1_tasks_path
    res = JSON.parse(@response.body)
    info = res['info']
    assert_equal(3, info.length)
    assert_equal(2, info.first['finish_type'])
    assert_equal(1, info.second['finish_type'])
    assert_nil(info.third['finish_type'])
  end
end
