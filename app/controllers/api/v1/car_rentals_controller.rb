module Api
  module V1
    class CarRentalsController < Api::V1::ApiController
      expose(:car_rental_params) {
        params.require(:car_rental).permit(:company, :reservation_number, :pick_up_address, :pick_up_at,
          :drop_off_address, :drop_off_at, :amount_in_cents, :notes)
      }
      expose(:trips) { current_user.trips }
      expose(:trip, scope: -> { trips })
      expose(:car_rentals) { trip.car_rentals }
      expose(:car_rental, scope: -> { car_rentals })

      def index
        render json: car_rentals
      end

      def show
        render json: car_rental
      end

      def create
        if car_rental.save
          render json: trip, status: :created
        else
          render json: trip.errors, status: :unprocessable_entity
        end
      end

      def update
        if car_rental.update(car_rental_params)
          render json: car_rental
        else
          render json: car_rental.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if car_rental.destroy
          render json: car_rental
        else
          render json: car_rental.errors, status: :unprocessable_entity
        end
      end
    end
  end
end