require 'test_helper'

class PointOfInterestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @point_of_interest = point_of_interests(:one)
  end

  test "should get index" do
    get point_of_interests_url, as: :json
    assert_response :success
  end

  test "should create point_of_interest" do
    assert_difference('PointOfInterest.count') do
      post point_of_interests_url, params: { point_of_interest: { address: @point_of_interest.address, amount_currency: @point_of_interest.amount_currency, amount_in_cents: @point_of_interest.amount_in_cents, deleted_at: @point_of_interest.deleted_at, name: @point_of_interest.name, notes: @point_of_interest.notes, order: @point_of_interest.order, trip_id: @point_of_interest.trip_id, visit_date: @point_of_interest.visit_date } }, as: :json
    end

    assert_response 201
  end

  test "should show point_of_interest" do
    get point_of_interest_url(@point_of_interest), as: :json
    assert_response :success
  end

  test "should update point_of_interest" do
    patch point_of_interest_url(@point_of_interest), params: { point_of_interest: { address: @point_of_interest.address, amount_currency: @point_of_interest.amount_currency, amount_in_cents: @point_of_interest.amount_in_cents, deleted_at: @point_of_interest.deleted_at, name: @point_of_interest.name, notes: @point_of_interest.notes, order: @point_of_interest.order, trip_id: @point_of_interest.trip_id, visit_date: @point_of_interest.visit_date } }, as: :json
    assert_response 200
  end

  test "should destroy point_of_interest" do
    assert_difference('PointOfInterest.count', -1) do
      delete point_of_interest_url(@point_of_interest), as: :json
    end

    assert_response 204
  end
end
