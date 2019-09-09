module Api
  module V1
    class SightsController < Api::V1::ApiController
      expose(:sight_params) {
        params.require(:sight).permit(:name, :visit_date, :address, :amount_in_cents, :amount_currency,
          :notes, :order)
      }
      expose(:trips) { current_user.trips }
      expose(:trip, scope: -> { trips })
      expose(:sights) { trip.sights }
      expose(:sight, scope: -> { sights })

      def index
        render json: sights
      end

      def show
        render json: sight
      end

      def create
        if sight.save
          render json: trip, status: :created
        else
          render json: trip.errors, status: :unprocessable_entity
        end
      end

      def update
        if sight.update(sight_params)
          render json: sight
        else
          render json: sight.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if sight.destroy
          render json: sight
        else
          render json: sight.errors, status: :unprocessable_entity
        end
      end
    end
  end
end
