class BandsController < ApplicationController
    def new
        render :new
    end

    def show
        @band = Band.find_by(id: params[:id])

        if @band
            render :show
        else
            render json: "no band found homey"
        end
    end

    def index
        @bands = Band.all
        render :index
    end

    def create
        @band = Band.new(band_params)

        if @band.save
            redirect_to band_url(@band)
        else
            flash.now[:errors] = @users.errors.full_messages
            render :new
        end
    end

    def edit
        # debugger
        @band = Band.find_by(id: params[:id])

        render :edit
    end

    def update
        @band = Band.find_by(id: params[:id])

        if @band.update(band_params)
            redirect_to band_url(@band)
        else
            render json: @band.errors.full_messages, status: 422
        end
    end

    def destroy
        @band = Band.find_by(id: params[:id])
        @band.destroy
        redirect_to bands_url
    end


    private

    def band_params
        params.require(:band).permit(:name)
    end
end

