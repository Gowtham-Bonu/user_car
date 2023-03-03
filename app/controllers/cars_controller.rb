require "prawn"
class CarsController < ApplicationController
  before_action :get_car, only: [:edit, :update, :destroy]

  def get_car
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new(brand: cookies[:car_brand])
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      cookies[:car_brand] = @car.brand if @car.remember_brand
      redirect_to root_path, notice: "you have successfully created a car!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @car.update(car_params)
      redirect_to root_path, notice: "you have successfully updated a car!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @car.destroy
    redirect_to root_path, notice: "you have successfully deleted a car!"
  end

  def index  
    @cars = if params[:name].present?          
              Car.where('name LIKE ?', "%#{params[:name]}%")
            else            
              Car.all          
            end
  end

  def download_pdf
    car = Car.first
    send_data generate_pdf(car),
    filename: "#{car.name}.pdf",
    type: "application/pdf"
  end

  private

  def generate_pdf(car)
    Prawn::Document.new do
      text car.name, align: :center
      text "Color: #{car.color}"
      text "Price: #{car.price}"
    end.render
  end

  def car_params
    params.require(:car).permit(:name, :price, :brand, :color, :remember_brand)
  end
end
    