module Api
  module V1
    class PointOfInterestsController < Api::V1::ApiController
      before_action :set_point_of_interest, only: [:show, :update, :destroy]

      # GET /point_of_interests
      def index
        @point_of_interests = PointOfInterest.all

        render json: @point_of_interests
      end

      # GET /point_of_interests/1
      def show
        render json: @point_of_interest
      end

      # POST /point_of_interests
      def create
        @point_of_interest = PointOfInterest.new(point_of_interest_params)

        if @point_of_interest.save
          render json: @point_of_interest, status: :created, location: @point_of_interest
        else
          render json: @point_of_interest.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /point_of_interests/1
      def update
        if @point_of_interest.update(point_of_interest_params)
          render json: @point_of_interest
        else
          render json: @point_of_interest.errors, status: :unprocessable_entity
        end
      end

      # DELETE /point_of_interests/1
      def destroy
        @point_of_interest.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_point_of_interest
          @point_of_interest = PointOfInterest.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def point_of_interest_params
          params.require(:point_of_interest).permit(:name, :visit_date, :address, :amount_in_cents, :amount_currency, :notes, :order, :trip_id, :deleted_at)
        end
    end
  end
end
