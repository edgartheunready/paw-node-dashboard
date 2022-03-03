require "test_helper"

class TribesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tribe = tribes(:one)
  end

  test "should get index" do
    get tribes_url
    assert_response :success
  end

  test "should get new" do
    get new_tribe_url
    assert_response :success
  end

  test "should create tribe" do
    assert_difference("Tribe.count") do
      post tribes_url, params: { tribe: { name: @tribe.name, uuid: @tribe.uuid } }
    end

    assert_redirected_to tribe_url(Tribe.last)
  end

  test "should show tribe" do
    get tribe_url(@tribe)
    assert_response :success
  end

  test "should get edit" do
    get edit_tribe_url(@tribe)
    assert_response :success
  end

  test "should update tribe" do
    patch tribe_url(@tribe), params: { tribe: { name: @tribe.name, uuid: @tribe.uuid } }
    assert_redirected_to tribe_url(@tribe)
  end

  test "should destroy tribe" do
    assert_difference("Tribe.count", -1) do
      delete tribe_url(@tribe)
    end

    assert_redirected_to tribes_url
  end
end
