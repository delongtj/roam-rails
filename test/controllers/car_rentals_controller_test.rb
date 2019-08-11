require 'test_helper'

class CarRentalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @car_rental = car_rentals(:one)
  end

  test "should get index" do
    get car_rentals_url, as: :json
    assert_response :success
  end

  test "should create car_rental" do
    assert_difference('CarRental.count') do
      post car_rentals_url, params: { car_rental: { amount_currency: @car_rental.amount_currency, amount_in_cents: @car_rental.amount_in_cents, company: @car_rental.company, deleted_at: @car_rental.deleted_at, dropoff_address: @car_rental.dropoff_address, dropoff_at: @car_rental.dropoff_at, notes: @car_rental.notes, pickup_address: @car_rental.pickup_address, pickup_at: @car_rental.pickup_at, trip_id: @car_rental.trip_id } }, as: :json
    end

    assert_response 201
  end

  test "should show car_rental" do
    get car_rental_url(@car_rental), as: :json
    assert_response :success
  end

  test "should update car_rental" do
    patch car_rental_url(@car_rental), params: { car_rental: { amount_currency: @car_rental.amount_currency, amount_in_cents: @car_rental.amount_in_cents, company: @car_rental.company, deleted_at: @car_rental.deleted_at, dropoff_address: @car_rental.dropoff_address, dropoff_at: @car_rental.dropoff_at, notes: @car_rental.notes, pickup_address: @car_rental.pickup_address, pickup_at: @car_rental.pickup_at, trip_id: @car_rental.trip_id } }, as: :json
    assert_response 200
  end

  test "should destroy car_rental" do
    assert_difference('CarRental.count', -1) do
      delete car_rental_url(@car_rental), as: :json
    end

    assert_response 204
  end
end
