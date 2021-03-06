json.array!(@songs) do |song|
  json.extract! song, :id, :name, :length, :description, :artist, :album
  json.url song_url(song, format: :json)
end
