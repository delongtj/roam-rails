module Api
  module V1
    class TripsController < Api::V1::ApiController

      expose(:trip_params) {
        params.require(:trip).permit(:name, :description)
      }
      expose(:trips) { current_user.trips }
      expose(:trip, scope: -> { trips })

      def index
        render json: trips
      end

      def show
        render json: trip
      end

      def create
        if Trip.create_for_user(trip_params, current_user.id)
          render json: trip, status: :created
        else
          render json: trip.errors, status: :unprocessable_entity
        end
      end

      def update
        if trip.update(trip_params)
          render json: trip
        else
          render json: trip.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if trip.destroy
          render json: trip
        else
          render json: trip.errors, status: :unprocessable_entity
        end
      end
    end
  end
end

