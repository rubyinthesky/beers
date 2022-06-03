require 'net/http'
require 'openssl'

class BeersController < ApplicationController
    #skip_before_action :authenticate_request, only: [:show]

    def index
        if @current_user.beers.empty?
            render json: {message: "you have no beers!"}
        else
            render json: {beers: @current_user.beers, user: @current_user}, status: :ok        
        end
    end

    def show
        @beer = Beer.where(id: params[:id], user_id: @current_user)
        
        if @beer.empty?
            render json: {message: "you don't own this beer!"}
        else
            render json: @beer, status: :ok
        end
    end
    
    def destroy
        @res = Beer.where(id: params[:id], user_id: @current_user).first
        @res.destroy if @res
        
    end

    def create
        @beer = @current_user.beers.create(:name => params[:name], :brand => params[:brand])
        if @beer.save
            render json: @beer, status: :created
        else
            render json: {errors: @beer.errors.full_messages},
            status: :unprocessable_entity
        end
    end
    
    def update
    end

end
