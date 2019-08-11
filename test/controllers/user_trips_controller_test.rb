require 'test_helper'

class UserTripsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_trip = user_trips(:one)
  end

  test "should get index" do
    get user_trips_url, as: :json
    assert_response :success
  end

  test "should create user_trip" do
    assert_difference('UserTrip.count') do
      post user_trips_url, params: { user_trip: { deleted_at: @user_trip.deleted_at, role: @user_trip.role, trip: @user_trip.trip, user: @user_trip.user } }, as: :json
    end

    assert_response 201
  end

  test "should show user_trip" do
    get user_trip_url(@user_trip), as: :json
    assert_response :success
  end

  test "should update user_trip" do
    patch user_trip_url(@user_trip), params: { user_trip: { deleted_at: @user_trip.deleted_at, role: @user_trip.role, trip: @user_trip.trip, user: @user_trip.user } }, as: :json
    assert_response 200
  end

  test "should destroy user_trip" do
    assert_difference('UserTrip.count', -1) do
      delete user_trip_url(@user_trip), as: :json
    end

    assert_response 204
  end
end
