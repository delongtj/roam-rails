require 'test_helper'

class AccommodationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @accommodation = accommodations(:one)
  end

  test "should get index" do
    get accommodations_url, as: :json
    assert_response :success
  end

  test "should create accommodation" do
    assert_difference('Accommodation.count') do
      post accommodations_url, params: { accommodation: { accommodation_type: @accommodation.accommodation_type, address: @accommodation.address, amount_currency: @accommodation.amount_currency, amount_in_cents: @accommodation.amount_in_cents, check_in_at: @accommodation.check_in_at, check_out_at: @accommodation.check_out_at, deleted_at: @accommodation.deleted_at, name: @accommodation.name, notes: @accommodation.notes, trip_id: @accommodation.trip_id } }, as: :json
    end

    assert_response 201
  end

  test "should show accommodation" do
    get accommodation_url(@accommodation), as: :json
    assert_response :success
  end

  test "should update accommodation" do
    patch accommodation_url(@accommodation), params: { accommodation: { accommodation_type: @accommodation.accommodation_type, address: @accommodation.address, amount_currency: @accommodation.amount_currency, amount_in_cents: @accommodation.amount_in_cents, check_in_at: @accommodation.check_in_at, check_out_at: @accommodation.check_out_at, deleted_at: @accommodation.deleted_at, name: @accommodation.name, notes: @accommodation.notes, trip_id: @accommodation.trip_id } }, as: :json
    assert_response 200
  end

  test "should destroy accommodation" do
    assert_difference('Accommodation.count', -1) do
      delete accommodation_url(@accommodation), as: :json
    end

    assert_response 204
  end
end
