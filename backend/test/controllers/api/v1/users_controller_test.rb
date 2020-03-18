require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  # 概要: ユーザー一覧を取得し、件数が合っていることを検証
  # 期待値: ステータス200、20件取得
  test "should get show" do
    create_list(:user, 10)

    get api_v1_users_path
    res = JSON.parse(@response.body)
    info = res['info']
    assert_response(200)
    assert_equal(10, info.size)
  end
end
