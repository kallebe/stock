require "test_helper"

class MovimentacaosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get movimentacaos_index_url
    assert_response :success
  end

  test "should get create" do
    get movimentacaos_create_url
    assert_response :success
  end
end
