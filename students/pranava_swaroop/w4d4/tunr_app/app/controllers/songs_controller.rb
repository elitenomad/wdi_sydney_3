class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  

  # GET /songs
  # GET /songs.json
  def index
    #@songs = Song.all
    if params[:artist_id].nil? && params[:album_id].nil?
      @songs = Song.paginate(page: params[:page])
    else
      if (params[:album_id].nil? && params[:album_id].empty?)
        @songs = Song.where("artist_id=#{params[:artist_id]}").paginate(page: params[:page])
      else
        @songs = Song.where("album_id=#{params[:album_id]}").paginate(page: params[:page])
      end
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show

    if @song.nil?
       flashnotice("Song",params[:id])
       @songs = Song.all
       render 'index'
    else
      @album = @song.album
      @artist = @song.artist
    end
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render action: 'show', status: :created, location: @song }
      else
        format.html { render action: 'new' }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end


  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find_by(id:params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:name, :length, :description, :artist_id, :album_id,:urlpath)
    end
end
