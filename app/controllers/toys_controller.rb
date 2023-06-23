class ToysController < ApplicationController
  wrap_parameters format: []

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    begin
      toy = Toy.create(toy_params)
      render json: toy, status: :created
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def update
    begin
      toy = Toy.find_by(id: params[:id])
      toy.update(likes: toy_params[:likes])
      head :no_content
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      toy = Toy.find_by(id: params[:id])
      toy.destroy
      head :no_content
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

end