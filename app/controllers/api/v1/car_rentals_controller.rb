class CarRentalsController < ApplicationController
  before_action :set_car_rental, only: [:show, :update, :destroy]

  # GET /car_rentals
  def index
    @car_rentals = CarRental.all

    render json: @car_rentals
  end

  # GET /car_rentals/1
  def show
    render json: @car_rental
  end

  # POST /car_rentals
  def create
    @car_rental = CarRental.new(car_rental_params)

    if @car_rental.save
      render json: @car_rental, status: :created, location: @car_rental
    else
      render json: @car_rental.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /car_rentals/1
  def update
    if @car_rental.update(car_rental_params)
      render json: @car_rental
    else
      render json: @car_rental.errors, status: :unprocessable_entity
    end
  end

  # DELETE /car_rentals/1
  def destroy
    @car_rental.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_rental
      @car_rental = CarRental.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_rental_params
      params.require(:car_rental).permit(:company, :pickup_address, :pickup_at, :dropoff_address, :dropoff_at, :amount_in_cents, :amount_currency, :notes, :trip_id, :deleted_at)
    end
end
