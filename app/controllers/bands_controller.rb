class BandsController < ApplicationController
  before_action :bounce_to_login
  before_action :set_band, only: [:show, :destroy, :edit, :update]

  def create
    band = Band.new(band_params)
    band.user_id = current_user.id

    band.featured_image = 'http://az616578.vo.msecnd.net/files/2016/07/11/6360384265838540902094315765_band.jpg' if band.featured_image.nil? || band.featured_image.length < 1

    if band.save
      add_message("You successfully added the band #{band.name}")
      redirect_to band_url(band)
    else
      add_errors(band.errors.full_messages)
      redirect_to new_band_url
    end
  end

  def update
    @band.update(band_params)
    add_message("You updated the band #{@band.name}.")
    redirect_to band_url(@band)
  end

  def index
    @bands = Band.all
  end

  def destroy
    band_name = @band.name
    @band.destroy
    add_message("You deleted the band #{band_name}.")
    redirect_to bands_url
  end

  private

  def set_band
    @band = Band.find(params[:id])
  end

  def band_params
    params.require(:band).permit(:name, :featured_image)
  end

  def check_if_admin
    set_band
    super unless @band.user == current_user
  end
end
