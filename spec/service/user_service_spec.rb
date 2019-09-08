require 'rails_helper'

RSpec.describe UserService do
  describe ".create" do
    let(:email)     { Faker::Internet.email }
    let(:password)  { "Testing123" }

    it "creates a user if all validation passes" do
      response = UserService.create(email, password, password)

      expect(response[:user]).to_not be nil
      expect(response[:error]).to be nil

      user = response[:user]

      expect(user.email).to eq email
    end

    it "returns an error if the email is already taken" do
      existing_user = Fabricate(:user)

      response = UserService.create(existing_user.email, password, password)

      expect(response[:user]).to be nil
      expect(response[:error]).to eq 'account already exists'
    end

    it "returns an error if password and password_confirmation don't match" do
      response = UserService.create(email, password, password.first(3))

      expect(response[:user]).to be nil
      expect(response[:error]).to eq 'password and password confirmation do not match'
    end
  end

  describe ".sign_in" do
    let(:password) { "Testing123" }
    let(:user) { Fabricate(:user, email: Faker::Internet.email, password: password) }

    it "returns a JWT if email and password are correct" do
      response = UserService.sign_in(user.email, password)

      expect(response[:auth_token]).to_not be nil
      expect(response[:error]).to be nil
    end

    it "returns an error when email does not belong to a user" do
      response = UserService.sign_in(Faker::Internet.email, password)

      expect(response[:auth_token]).to be nil
      expect(response[:error]).to eq 'invalid credentials'
    end

    it "returns an error when password is not correct for an invalid email" do
      response = UserService.sign_in(user.email, password.first(3))

      expect(response[:auth_token]).to be nil
      expect(response[:error]).to eq 'invalid credentials'
    end
  end

  describe ".sign_out" do
    let(:user) { Fabricate(:user) }

    it "does not error if nil is passed in" do
      response = UserService.sign_out(nil)

      expect(response[:auth_token]).to be nil
      expect(response[:error]).to be nil
    end

    it "returns an expired auth_token for a valid user" do
      response = UserService.sign_out(user)

      expect(response[:auth_token]).to_not be nil
      expect(response[:error]).to be nil
    end
  end

  describe '.authenticate' do
    let(:password) { "Testing123" }
    let(:user) { Fabricate(:user, email: Faker::Internet.email, password: password) }

    it "returns the user for a valid auth token in request_headers" do
      sign_in_response = UserService.sign_in(user.email, password)

      response = UserService.authenticate({ "Authorization" => sign_in_response[:auth_token] })

      expect(response[:user]).to eq user
      expect(response[:error]).to be nil
    end

    it "returns an error if auth token is not in request_headers" do
      response = UserService.authenticate({})

      expect(response[:user]).to be nil
      expect(response[:error]).to eq 'missing token'
    end

    it "returns an error if auth token is not valid" do
      response = UserService.authenticate({ 'Authorization' => "invalidtoken" })

      expect(response[:user]).to be nil
      expect(response[:error]).to eq 'invalid token'
    end
  end
end
