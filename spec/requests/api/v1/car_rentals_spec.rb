require 'rails_helper'

describe "Car Rentals API" do
  let!(:user) { Fabricate(:user, password: "Testing123", password_confirmation: "Testing123") }
  let!(:auth_token) { UserService.sign_in(user.email, user.password)[:auth_token] }
  let!(:trip) { Fabricate(:trip) }
  let!(:car_rental) { Fabricate(:car_rental, trip: trip) }

  let(:car_rental_params) {
    {
      car_rental: {
        company: [ "Budget", "Alamo", "Hertz", "Enterprise"].sample,
        reservation_number: SecureRandom.hex(10).upcase,
        pick_up_address: Faker::Address.full_address,
        pick_up_at: rand_time(start_time: Time.now + 1.week, end_time: Time.now + 3.months),
        drop_off_address: Faker::Address.full_address,
        drop_off_at: rand_time(start_time: Time.now + 3.months, end_time: Time.now + 4.months),
        amount_in_cents: rand_integer,
        amount_currency: 'USD',
        notes: Faker::Lorem.sentence
      }
    }
  }

  context "with valid auth token" do
    let(:headers) { { "Authorization" => auth_token } }

    describe "GET /api/v1/trips/:trip_id/car_rentals" do
      it "returns a list of the user's car_rentals for the trip" do
        get api_v1_trip_car_rentals_url(trip), headers: headers

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)

        expect(json).to eq [ car_rental.as_json ]
      end
    end

    describe "POST /api/v1/trips/:trip_id/car_rentals" do
      context "with valid params" do
        it "creates a trip" do
          expect(trip.car_rentals.count).to eq 1

          post api_v1_trip_car_rentals_url(trip), params: car_rental_params, headers: headers

          expect(response).to have_http_status(:created)

          expect(trip.car_rentals.count).to eq 2
        end
      end

      context "with invalid params" do
        it "does not create a car_rental" do
          expect(user.trips.count).to eq 1

          car_rental_params[:car_rental][:company] = nil

          post api_v1_trip_car_rentals_url(trip), params: car_rental_params, headers: headers

          expect(response).to have_http_status(:unprocessable_entity)

          expect(trip.car_rentals.count).to eq 1
        end
      end
    end

    describe "PUT /api/v1/trips/:trip_id/car_rentals/:id" do
      context "with valid params" do
        it "updates the specified car_rental" do
          expect(user.trips.count).to eq 1

          put api_v1_trip_car_rental_url(trip, car_rental), params: car_rental_params, headers: headers

          expect(response).to have_http_status(:ok)

          expect(trip.car_rentals.count).to eq 1

          expect(trip.car_rentals.first.amount_in_cents).to eq car_rental_params[:car_rental][:amount_in_cents]
        end
      end

      context "with invalid params" do
        it "does not update the specified car_rental" do
          expect(user.trips.count).to eq 1

          car_rental_params[:car_rental][:company] = nil

          put api_v1_trip_car_rental_url(trip, car_rental), params: car_rental_params, headers: headers

          expect(response).to have_http_status(:unprocessable_entity)

          expect(trip.car_rentals.count).to eq 1

          expect(trip.car_rentals.first.amount_in_cents).to_not eq car_rental_params[:car_rental][:amount_in_cents]
        end
      end
    end

    describe "DELETE /api/v1/trips/:trip_id/car_rentals/:id" do
      it "deletes the specified car_rental" do
        expect(trip.car_rentals.count).to eq 1

        delete api_v1_trip_car_rental_url(trip, car_rental), headers: headers

        expect(response).to have_http_status(:ok)

        expect(trip.car_rentals.count).to eq 0
      end
    end
  end

  context "without valid auth token" do
    let(:headers) { {} }

    describe "GET /api/v1/trips/:trip_id/car_rentals" do
      it "returns http unauthorized" do
        get api_v1_trip_car_rentals_url(trip), headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "POST /api/v1/trips/:trip_id/car_rentals" do
      it "returns http unauthorized" do
        post api_v1_trip_car_rentals_url(trip), params: car_rental_params, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "PUT /api/v1/trips/:trip_id/car_rentals/:id" do
      it "returns http unauthorized" do
        put api_v1_trip_car_rental_url(trip, car_rental), params: car_rental_params, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "DELETE /api/v1/trips/:trip_id/car_rentals/:id" do
      it "returns http unauthorized" do
        delete api_v1_trip_car_rental_url(trip, car_rental), headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
