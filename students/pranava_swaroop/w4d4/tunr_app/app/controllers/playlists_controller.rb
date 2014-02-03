class PlaylistsController < ApplicationController
	before_action :set_playlist, only: [:show, :edit, :update, :destroy]
  

  def index
  	@playlists = Playlist.all
  end

  def new
  	@playlist = Playlist.new
  end

  def create
  	params[:playlist][:song_ids] ||= []

  	@playlist = Playlist.new(playlist_params)
  	@playlist.song_ids = params[:playlist][:song_ids]

  	if @playlist.save
  		flash.now[:notice]="playlist created successfully"
  		@playlists = Playlist.all
  		redirect_to playlists_path
  	else
  		render 'new'
  	end
  end

  def show
  	@songs = @playlist.songs
  end

  def edit
  end

  def update
  	params[:playlist][:song_ids] ||= []
  	@playlist.song_ids = params[:playlist][:song_ids]

  	if @playlist.update(playlist_params)
  		flash.now[:notice]="playlist updated successfully"
  		@playlists = Playlist.all
  		redirect_to playlists_path
  	else
  		render 'edit'
  	end
  end

  def destroy
  	@playlist.destroy
  	@playlists = Playlist.all
  	render 'index'
  end

   def add_song
	  @playlist = Playlist.find(params[:id]) # find the foo
	  @song = @playlist.songs.build(params[:song]) # build new bar through foo
	  if @song.save
	    redirect_to @playlist
	  else
	    render add_song_to_playlist_path(@playlist)
	  end
	end 


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find_by(id:params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      params.require(:playlist).permit(:name)
    end
end
