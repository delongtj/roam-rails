module Api
  module V1
    class AccommodationsController < ApiController
      expose(:accommodation_params) {
        params.require(:accommodation).permit(:name, :accommodation_type, :address, :check_in_at, :check_out_at, 
          :amount_in_cents, :amount_currency, :notes)
      }
      expose(:trips) { current_user.trips }
      expose(:trip, scope: -> { trips })
      expose(:accommodations) { trip.accommodations }
      expose(:accommodation, scope: -> { accommodations })

      def index
        render json: accommodations
      end

      def show
        render json: accommodation
      end

      def create
        if accommodation.save
          render json: trip, status: :created
        else
          render json: trip.errors, status: :unprocessable_entity
        end
      end

      def update
        if accommodation.update(accommodation_params)
          render json: accommodation
        else
          render json: accommodation.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if accommodation.destroy
          render json: accommodation
        else
          render json: accommodation.errors, status: :unprocessable_entity
        end
      end
    end
  end
end
