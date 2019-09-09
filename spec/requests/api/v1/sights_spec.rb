require 'rails_helper'

describe "Points of Interest API" do
  let!(:user) { Fabricate(:user, password: "Testing123", password_confirmation: "Testing123") }
  let!(:auth_token) { UserService.sign_in(user.email, user.password)[:auth_token] }
  let!(:trip) { Fabricate(:trip) }
  let!(:sight) { Fabricate(:sight, trip: trip) }

  let(:sight_params) {
    {
      sight: Fabricate.build(:sight).attributes.symbolize_keys
    }
  }

  context "with valid auth token" do
    let(:headers) { { "Authorization" => auth_token } }

    describe "GET /api/v1/trips/:trip_id/sights" do
      it "returns a list of the user's sights for the trip" do
        get api_v1_trip_sights_url(trip), headers: headers

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)

        expect(json).to eq [ sight.as_json ]
      end
    end

    describe "POST /api/v1/trips/:trip_id/sights" do
      context "with valid params" do
        it "creates a trip" do
          expect(trip.sights.count).to eq 1

          post api_v1_trip_sights_url(trip), params: sight_params, headers: headers

          expect(response).to have_http_status(:created)

          expect(trip.sights.count).to eq 2
        end
      end

      context "with invalid params" do
        it "does not create a sight" do
          expect(user.trips.count).to eq 1

          sight_params[:sight][:name] = nil

          post api_v1_trip_sights_url(trip), params: sight_params, headers: headers

          expect(response).to have_http_status(:unprocessable_entity)

          expect(trip.sights.count).to eq 1
        end
      end
    end

    describe "PUT /api/v1/trips/:trip_id/sights/:id" do
      context "with valid params" do
        it "updates the specified sight" do
          expect(user.trips.count).to eq 1

          put api_v1_trip_sight_url(trip, sight), params: sight_params, headers: headers

          expect(response).to have_http_status(:ok)

          expect(trip.sights.count).to eq 1

          expect(trip.sights.first.amount_in_cents).to eq sight_params[:sight][:amount_in_cents]
        end
      end

      context "with invalid params" do
        it "does not update the specified sight" do
          expect(user.trips.count).to eq 1

          sight_params[:sight][:name] = nil

          put api_v1_trip_sight_url(trip, sight), params: sight_params, headers: headers

          expect(response).to have_http_status(:unprocessable_entity)

          expect(trip.sights.count).to eq 1

          expect(trip.sights.first.amount_in_cents).to_not eq sight_params[:sight][:amount_in_cents]
        end
      end
    end

    describe "DELETE /api/v1/trips/:trip_id/sights/:id" do
      it "deletes the specified sight" do
        expect(trip.sights.count).to eq 1

        delete api_v1_trip_sight_url(trip, sight), headers: headers

        expect(response).to have_http_status(:ok)

        expect(trip.sights.count).to eq 0
      end
    end
  end

  context "without valid auth token" do
    let(:headers) { {} }

    describe "GET /api/v1/trips/:trip_id/sights" do
      it "returns http unauthorized" do
        get api_v1_trip_sights_url(trip), headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "POST /api/v1/trips/:trip_id/sights" do
      it "returns http unauthorized" do
        post api_v1_trip_sights_url(trip), params: sight_params, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "PUT /api/v1/trips/:trip_id/sights/:id" do
      it "returns http unauthorized" do
        put api_v1_trip_sight_url(trip, sight), params: sight_params, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "DELETE /api/v1/trips/:trip_id/sights/:id" do
      it "returns http unauthorized" do
        delete api_v1_trip_sight_url(trip, sight), headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
