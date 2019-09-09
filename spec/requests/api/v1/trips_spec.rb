require 'rails_helper'

describe "Trips API" do
  let!(:user) { Fabricate(:user, password: "Testing123", password_confirmation: "Testing123") }
  let!(:auth_token) { UserService.sign_in(user.email, user.password)[:auth_token] }
  let!(:trip) { Fabricate(:trip) }

  let(:trip_params) {
    {
      trip: Fabricate.build(:trip).attributes.symbolize_keys
    }
  }

  context "with valid auth token" do
    let(:headers) { { "Authorization" => auth_token } }

    describe "GET /api/v1/trips" do
      it "returns a list of the user's trips" do
        get api_v1_trips_url, headers: headers

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)

        expect(json).to eq [ trip.as_json ]
      end
    end

    describe "POST /api/v1/trips" do
      context "with valid params" do
        it "creates a trip" do
          expect(user.trips.count).to eq 1

          post api_v1_trips_url, params: trip_params, headers: headers

          expect(response).to have_http_status(:created)

          expect(user.trips.count).to eq 2
        end
      end

      context "with invalid params" do
        it "does not create a trip" do
          expect(user.trips.count).to eq 1

          trip_params[:trip][:name] = nil

          post api_v1_trips_url, params: trip_params, headers: headers

          expect(response).to have_http_status(:unprocessable_entity)

          expect(user.trips.count).to eq 1
        end
      end
    end

    describe "PUT /api/v1/trips/:id" do
      context "with valid params" do
        it "updates the specified trip" do
          expect(user.trips.count).to eq 1

          put api_v1_trip_url(trip), params: trip_params, headers: headers

          expect(response).to have_http_status(:ok)

          expect(user.trips.count).to eq 1

          expect(user.trips.first.name).to eq trip_params[:trip][:name]
        end
      end

      context "with invalid params" do
        it "does not update the specified trip" do
          expect(user.trips.count).to eq 1

          trip_params[:trip][:name] = nil

          put api_v1_trip_url(trip), params: trip_params, headers: headers

          expect(response).to have_http_status(:unprocessable_entity)

          expect(user.trips.count).to eq 1

          expect(user.trips.first.description).to_not eq trip_params[:trip][:description]
        end
      end
    end

    describe "DELETE /api/v1/trips/:id" do
      it "deletes the specified trip" do
        expect(user.trips.count).to eq 1

        delete api_v1_trip_url(trip), headers: headers

        expect(response).to have_http_status(:ok)

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
