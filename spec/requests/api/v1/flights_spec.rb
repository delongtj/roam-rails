require 'rails_helper'

describe "Trips API" do
  let!(:user) { Fabricate(:user, password: "Testing123", password_confirmation: "Testing123") }
  let!(:auth_token) { UserService.sign_in(user.email, user.password)[:auth_token] }
  let!(:trip) { Fabricate(:trip) }
  let!(:flight) { Fabricate(:flight, trip: trip) }

  let(:flight_params) {
    {
      flight: {
        airline: [ "United", "American", "Delta", "Southwest"].sample,
        flight_number: rand_integer(1000),
        depart_airport: 'BNA',
        depart_at: rand_time(start_time: Time.now + 1.week, end_time: Time.now + 3.months),
        arrive_airport: 'LAX',
        arrive_at: rand_time(start_time: Time.now + 3.months, end_time: Time.now + 4.months),
        amount_in_cents: rand_integer,
        amount_currency: 'USD',
        notes: Faker::Lorem.sentence
      }
    }
  }

  context "with valid auth token" do
    let(:headers) { { "Authorization" => auth_token } }

    describe "GET /api/v1/trips/:trip_id/flights" do
      it "returns a list of the user's flights for the trip" do
        get api_v1_trip_flights_url(trip), headers: headers

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)

        expect(json).to eq [ flight.as_json ]
      end
    end

    describe "POST /api/v1/trips/:trip_id/flights" do
      context "with valid params" do
        it "creates a trip" do
          expect(trip.flights.count).to eq 1

          post api_v1_trip_flights_url(trip), params: flight_params, headers: headers

          expect(response).to have_http_status(:created)

          expect(trip.flights.count).to eq 2
        end
      end

      context "with invalid params" do
        it "does not create a flight" do
          expect(user.trips.count).to eq 1

          flight_params[:flight][:airline] = nil

          post api_v1_trip_flights_url(trip), params: flight_params, headers: headers

          expect(response).to have_http_status(:unprocessable_entity)

          expect(trip.flights.count).to eq 1
        end
      end
    end

    describe "PUT /api/v1/trips/:trip_id/flights/:id" do
      context "with valid params" do
        it "updates the specified flight" do
          expect(user.trips.count).to eq 1

          put api_v1_trip_flight_url(trip, flight), params: flight_params, headers: headers

          expect(response).to have_http_status(:ok)

          expect(trip.flights.count).to eq 1

          expect(trip.flights.first.amount_in_cents).to eq flight_params[:flight][:amount_in_cents]
        end
      end

      context "with invalid params" do
        it "does not update the specified flight" do
          expect(user.trips.count).to eq 1

          flight_params[:flight][:airline] = nil

          put api_v1_trip_flight_url(trip, flight), params: flight_params, headers: headers

          expect(response).to have_http_status(:unprocessable_entity)

          expect(trip.flights.count).to eq 1

          expect(trip.flights.first.amount_in_cents).to_not eq flight_params[:flight][:amount_in_cents]
        end
      end
    end

    describe "DELETE /api/v1/trips/:trip_id/flights/:id" do
      it "deletes the specified flight" do
        expect(trip.flights.count).to eq 1

        delete api_v1_trip_flight_url(trip, flight), headers: headers

        expect(response).to have_http_status(:ok)

        expect(trip.flights.count).to eq 0
      end
    end
  end

  context "without valid auth token" do
    let(:headers) { {} }

    describe "GET /api/v1/trips/:trip_id/flights" do
      it "returns http unauthorized" do
        get api_v1_trip_flights_url(trip), headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "POST /api/v1/trips/:trip_id/flights" do
      it "returns http unauthorized" do
        post api_v1_trip_flights_url(trip), params: flight_params, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "PUT /api/v1/trips/:trip_id/flights/:id" do
      it "returns http unauthorized" do
        put api_v1_trip_flight_url(trip, flight), params: flight_params, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "DELETE /api/v1/trips/:trip_id/flights/:id" do
      it "returns http unauthorized" do
        delete api_v1_trip_flight_url(trip, flight), headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
