class UsersController < ApplicationController
    def new
        render :new
    end

    def index
        @users = User.all
        render :index
    end

    def create
        @user = User.new(user_params)

        # debugger
        if @user.save
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        @user = User.find_by(id: params[:id])

        if @user
            render :show
        else
            render json: "No user found", status: 404
        end
    end


    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end
