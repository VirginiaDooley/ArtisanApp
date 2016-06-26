
class PinsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :upvote]
  before_action :set_pin, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :correct_user, only: [:edit, :update, :destroy, :upvote]

	def index
		@pins = Pin.all.order("created_at DESC")
	end

	def show
		@pin = Pin.find(params[:id])
	end

	def new
		@pin = Pin.new
		@pin = current_user.pins.build
	end

	def create
	  # @pin = Pin.new(pin_params)
	  # @pin.user_id = current_user.id
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

	def upvote
		@pin.upvote_by current_user
		redirect_to :back
	end

	def correct_user
	 @pin = current_user.pins.find_by(id: params[:id])
  	redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
	end

	def set_callbacks(name, callbacks)
	  send "_#{name}_callbacks=", callbacks
	end

	def set_pin
	end

	private

	def pin_params
		params.require(:pin).permit(:title, :description, :image)
	end

	def find_pin
		@pin = Pin.find (params[:id]) 
	end
end