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
    create(:user)
    create(:task)
    create(:is_finish_task)
    create(:is_finish_task, finish_type: 2)

    get api_v1_tasks_path
    res = JSON.parse(@response.body)
    info = res['info']
    first_task = info.first
    assert_equal("test_title_3", first_task['title'])
    assert_equal("test_content_3", first_task['content'])
    assert_equal(2, first_task['finish_type'])

    first_task = info.second
    assert_equal("test_title_2", first_task['title'])
    assert_equal("test_content_2", first_task['content'])
    assert_equal(1, first_task['finish_type'])

    first_task = info.third
    assert_equal("test_title_1", first_task['title'])
    assert_equal("test_content_1", first_task['content'])
    assert_nil(first_task['finish_type'])
  end
end
