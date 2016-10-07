class AlbumsController < ApplicationController
  before_action :bounce_to_login
  before_action :set_band, only: [:new, :create]
  before_action :set_album, only: [:edit, :update, :destroy, :show]

  def create
    album = Album.new(album_params)
    album.user_id = current_user.id

    if album.save
      add_message("You successfully added the album #{album.name}!")
      redirect_to album_url(album)
    else
      add_errors(album.errors.full_messages)
      redirect_to new_band_album(@band)
    end
  end

  def update
    @album.update(album_params)
    add_message("You updated the album #{@album.name}.")
    redirect_to album_url(@album)
  end

  def destroy
    album_name = @album.name
    band = @album.band
    @album.destroy
    add_message("You deleted the album #{album_name}.")
    redirect_to band_url(band)
  end

  private

  def set_band
    @band = Band.find(params[:band_id])
  end

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    hash = params.require(:album).permit(:name, :featured_image, :album_type)
    hash[:band_id] = params[:band_id]
    hash
  end

  def check_if_admin
    set_album
    super unless @album.user == current_user
  end
end
