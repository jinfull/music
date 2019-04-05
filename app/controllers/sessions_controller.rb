class SessionsController < ApplicationController

    def new
        render :new
    end
    
    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

        if @user
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ['Invalid Credentials']
            render :new
        end

    end

    def destroy
        logout!
        redirect_to users_url
    end
end
