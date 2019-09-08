require 'rails_helper'

describe "Trips API" do
  let!(:user) { Fabricate(:user, password: "Testing123", password_confirmation: "Testing123") }
  let!(:auth_token) { UserService.sign_in(user.email, user.password)[:auth_token] }
  let!(:trip) { Fabricate(:trip) }

  let(:trip_params) {
    {
      trip: {
        name: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
        budget_in_cents: 100000
      }
    }
  }

  context "with valid auth token" do
    let(:headers) { { "Authorization" => auth_token } }

    describe "GET /api/v1/trips" do
      it "returns a list of the user's trips" do
        get api_v1_trips_url, headers: headers

        json = JSON.parse(response.body)

        expect(response).to be_successful

        expect(json).to eq [ trip.as_json ]
      end
    end

    describe "POST /api/v1/trips" do
      it "creates a trip" do
        expect(user.trips.count).to eq 1

        post api_v1_trips_url, params: trip_params, headers: headers

        expect(response).to be_successful

        expect(user.trips.count).to eq 2
      end
    end

    describe "PUT /api/v1/trips/:id" do
      it "updates the specified trip" do
        expect(user.trips.count).to eq 1

        put api_v1_trip_url(trip), params: trip_params, headers: headers

        expect(response).to be_successful

        expect(user.trips.count).to eq 1

        expect(user.trips.first.name).to eq trip_params[:trip][:name]
      end
    end

    describe "DELETE /api/v1/trips/:id" do
      it "deletes the specified trip" do
        expect(user.trips.count).to eq 1

        delete api_v1_trip_url(trip), headers: headers

        expect(response).to be_successful

        expect(user.trips.count).to eq 0
      end
    end
  end

  context "without valid auth token" do
    let(:headers) { {} }

    describe "GET /api/v1/trips" do
      it "returns http unauthorized" do
        get api_v1_trips_url, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "POST /api/v1/trips" do
      it "returns http unauthorized" do
        post api_v1_trips_url, params: trip_params, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "PUT /api/v1/trips/:id" do
      it "returns http unauthorized" do
        put api_v1_trip_url(trip), params: trip_params, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "DELETE /api/v1/trips/:id" do
      it "returns http unauthorized" do
        delete api_v1_trip_url(trip), headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
