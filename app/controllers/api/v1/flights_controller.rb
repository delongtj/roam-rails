module Api
  module V1
    class FlightsController < Api::V1::ApiController
      expose(:flight_params) {
        params.require(:flight).permit(:airline, :flight_number, :depart_airport, :depart_at, :arrive_airport, :arrive_at, :amount_in_cents, :notes)
      }
      expose(:trips) { current_user.trips }
      expose(:trip, scope: -> { trips })
      expose(:flights) { trip.flights }
      expose(:flight, scope: -> { flights })

      def index
        render json: flights
      end

      def show
        render json: flight
      end

      def create
        if flight.save
          render json: trip, status: :created
        else
          render json: trip.errors, status: :unprocessable_entity
        end
      end

      def update
        if flight.update(flight_params)
          render json: flight
        else
          render json: flight.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if flight.destroy
          render json: flight
        else
          render json: flight.errors, status: :unprocessable_entity
        end
      end
    end
  end
end
