require 'rails_helper'

RSpec.describe Api::V1::TripsController do
  let!(:user) { Fabricate(:user, password: "Testing123", password_confirmation: "Testing123") }
  let!(:auth_token) { UserService.sign_in(user.email, user.password)[:auth_token] }
  let!(:trip) { Fabricate(:trip) }

  context "with valid auth token" do
    before do
      request.headers.merge!({ "Authorization" => auth_token })
    end

    describe "GET #index" do
      before do
        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "contains current user's trips" do
        json_response = JSON.parse(response.body)

        expect(json_response).to eq [ trip.as_json ]
      end
    end
  end

  context "without valid auth token" do
    describe "GET #index" do
      before do
        get :index
      end

      it "returns http unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
