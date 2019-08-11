require 'test_helper'

class FlightsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flight = flights(:one)
  end

  test "should get index" do
    get flights_url, as: :json
    assert_response :success
  end

  test "should create flight" do
    assert_difference('Flight.count') do
      post flights_url, params: { flight: { airline: @flight.airline, amount_currency: @flight.amount_currency, amount_in_cents: @flight.amount_in_cents, arrive_airport: @flight.arrive_airport, arrive_at: @flight.arrive_at, deleted_at: @flight.deleted_at, depart_airport: @flight.depart_airport, depart_at: @flight.depart_at, flight_number: @flight.flight_number, notes: @flight.notes, trip_id: @flight.trip_id } }, as: :json
    end

    assert_response 201
  end

  test "should show flight" do
    get flight_url(@flight), as: :json
    assert_response :success
  end

  test "should update flight" do
    patch flight_url(@flight), params: { flight: { airline: @flight.airline, amount_currency: @flight.amount_currency, amount_in_cents: @flight.amount_in_cents, arrive_airport: @flight.arrive_airport, arrive_at: @flight.arrive_at, deleted_at: @flight.deleted_at, depart_airport: @flight.depart_airport, depart_at: @flight.depart_at, flight_number: @flight.flight_number, notes: @flight.notes, trip_id: @flight.trip_id } }, as: :json
    assert_response 200
  end

  test "should destroy flight" do
    assert_difference('Flight.count', -1) do
      delete flight_url(@flight), as: :json
    end

    assert_response 204
  end
end
