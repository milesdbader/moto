require 'test_helper'

class ChallengesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get challenges_new_url
    assert_response :success
  end

  test "should get show" do
    get challenges_show_url
    assert_response :success
  end

  test "should get create" do
    get challenges_create_url
    assert_response :success
  end

  test "should get accepted" do
    get challenges_accepted_url
    assert_response :success
  end

  test "should get destroy" do
    get challenges_destroy_url
    assert_response :success
  end

end
