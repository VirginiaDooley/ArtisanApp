class PinsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

	def index
		@pins = Pin.all.order("created_at DESC")
	end

	def show
	end

	def new
		@pin = Pin.new
		@pin = current_user.pins.build
	end

	def create
		@pin = current_user.pins.build(pin_params)

		if @pin.save
			redirect_to @pin, notice: "Successfully created a new pin!"
		else 
			render 'new'
		end
	end	

	def edit
	end

	def update
		if @pin.update(pin_params)
			redirect_to @pin, notice:"Pin was successfully updated!"
		else 
			render 'edit'
		end
	end

	def destroy
		@pin.destroy
		redirect_to root_path
	end


	private

	def pin_params
		params.require(:pin).permit(:title, :description)
	end

	def find_pin
		@pin = Pin.find (params[:id]) 
	end
end