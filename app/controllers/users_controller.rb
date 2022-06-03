class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]
    before_action :set_user, only: [:show, :destroy]

    #GET /users
    def index
        @users = User.all
        render json: @users, status: :ok
    end

    # GET users/{username}
    def show
        render json: @user, status: :ok
    end

    #POST users
    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user, status: :created
        else
            render json: {errors: @user.errors.full_messages},
            status: :unprocessable_entity
        end
    end

    #PUT users/{username}
    def update
        unless @user.update(user_params)
            render json: {errors: @user.errors.full_messages},
            status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
    end

    def profile
        render json: {user: @current_user, message: "tu perfil!"}, status: :ok
    end

    private
        def user_params
            params.permit(:username, :email, :password)
        end

        def set_user
            @user = User.find(params[:id])
        end
end
