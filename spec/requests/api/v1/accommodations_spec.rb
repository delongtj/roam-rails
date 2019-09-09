require 'rails_helper'

describe "Accommodations API" do
  let!(:user) { Fabricate(:user, password: "Testing123", password_confirmation: "Testing123") }
  let!(:auth_token) { UserService.sign_in(user.email, user.password)[:auth_token] }
  let!(:trip) { Fabricate(:trip) }
  let!(:accommodation) { Fabricate(:accommodation, trip: trip) }

  let(:accommodation_params) {
    {
      accommodation: Fabricate.build(:accommodation).attributes.symbolize_keys
    }
  }

  context "with valid auth token" do
    let(:headers) { { "Authorization" => auth_token } }

    describe "GET /api/v1/trips/:trip_id/accommodations" do
      it "returns a list of the user's accommodations for the trip" do
        get api_v1_trip_accommodations_url(trip), headers: headers

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)

        expect(json).to eq [ accommodation.as_json ]
      end
    end

    describe "POST /api/v1/trips/:trip_id/accommodations" do
      context "with valid params" do
        it "creates a trip" do
          expect(trip.accommodations.count).to eq 1

          post api_v1_trip_accommodations_url(trip), params: accommodation_params, headers: headers

          expect(response).to have_http_status(:created)

          expect(trip.accommodations.count).to eq 2
        end
      end

      context "with invalid params" do
        it "does not create a accommodation" do
          expect(user.trips.count).to eq 1

          accommodation_params[:accommodation][:name] = nil

          post api_v1_trip_accommodations_url(trip), params: accommodation_params, headers: headers

          expect(response).to have_http_status(:unprocessable_entity)

          expect(trip.accommodations.count).to eq 1
        end
      end
    end

    describe "PUT /api/v1/trips/:trip_id/accommodations/:id" do
      context "with valid params" do
        it "updates the specified accommodation" do
          expect(user.trips.count).to eq 1

          put api_v1_trip_accommodation_url(trip, accommodation), params: accommodation_params, headers: headers

          expect(response).to have_http_status(:ok)

          expect(trip.accommodations.count).to eq 1

          expect(trip.accommodations.first.amount_in_cents).to eq accommodation_params[:accommodation][:amount_in_cents]
        end
      end

      context "with invalid params" do
        it "does not update the specified accommodation" do
          expect(user.trips.count).to eq 1

          accommodation_params[:accommodation][:name] = nil

          put api_v1_trip_accommodation_url(trip, accommodation), params: accommodation_params, headers: headers

          expect(response).to have_http_status(:unprocessable_entity)

          expect(trip.accommodations.count).to eq 1

          expect(trip.accommodations.first.amount_in_cents).to_not eq accommodation_params[:accommodation][:amount_in_cents]
        end
      end
    end

    describe "DELETE /api/v1/trips/:trip_id/accommodations/:id" do
      it "deletes the specified accommodation" do
        expect(trip.accommodations.count).to eq 1

        delete api_v1_trip_accommodation_url(trip, accommodation), headers: headers

        expect(response).to have_http_status(:ok)

        expect(trip.accommodations.count).to eq 0
      end
    end
  end

  context "without valid auth token" do
    let(:headers) { {} }

    describe "GET /api/v1/trips/:trip_id/accommodations" do
      it "returns http unauthorized" do
        get api_v1_trip_accommodations_url(trip), headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "POST /api/v1/trips/:trip_id/accommodations" do
      it "returns http unauthorized" do
        post api_v1_trip_accommodations_url(trip), params: accommodation_params, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "PUT /api/v1/trips/:trip_id/accommodations/:id" do
      it "returns http unauthorized" do
        put api_v1_trip_accommodation_url(trip, accommodation), params: accommodation_params, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "DELETE /api/v1/trips/:trip_id/accommodations/:id" do
      it "returns http unauthorized" do
        delete api_v1_trip_accommodation_url(trip, accommodation), headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
