class TracksController < ApplicationController
  before_action :bounce_to_login
  before_action :set_album, only: [:new, :create]
  before_action :set_track, only: [:show, :edit, :update, :destroy]

  def create
    track = Track.new(track_params)
    track.album_id = @album.id

    if track.save
      add_message("You added the track #{track.name}")
      redirect_to track_url(track)
    else
      add_errors(track.errors.full_messages)
      redirect_to new_album_track_url(@album)
    end
  end

  def update
    @track.update(track_params)
    add_message("Updated track #{@track.name}.")
    redirect_to track_url(@track)
  end

  def destroy
    track_name = @track.name
    album = @track.album
    @track.destroy
    add_message("Deleted the track #{track_name}.")
    redirect_to album_url(album)
  end

  private
  def set_album
    @album = Album.find(params[:album_id])
  end

  def set_track
    @track = Track.find(params[:id])
  end

  def track_params
    hash = params.require(:track).permit(:name, :lyrics, :track_type)
    hash[:album_id] = params[:album_id]
    hash
  end
end
