require "spec_helper"

describe "Associations — Song and Artist:" do
  before(:each) do
    @song = Song.new("In the Aeroplane Over the Sea")
    @artist = Artist.new("Neutral Milk Hotel")
  end

  context "Artist" do
    describe "#initialize" do
      it "creates a 'songs' property set to an empty array (artist has many songs)" do
        expect(@artist.instance_variable_defined?(:@songs)).to be(true)
        expect(@artist.instance_variable_get(:@songs)).to eq([])
      end
    end

    describe "#songs" do
      it "returns the artist's 'songs' collection (artist has many songs)" do
        expect(@artist.songs).to eq([])
        @artist.songs << @song
        expect(@artist.songs).to eq([@song])
      end
    end
  end

  context "Song" do
    describe "#initialize" do
      it "can be invoked with an optional second argument, an Artist object to be assigned to the song's 'artist' property (song belongs to artist)" do
        artist = Artist.new("Fear of Tigers")
        song = Song.new("Kaohsiung Christmas", artist)

        expect(artist.songs).to include(song)
        expect(song.artist).to eq(artist)
      end
    end

    describe "#artist" do
      it "returns the artist of the song (song belongs to artist)" do
        @song.instance_variable_set(:@artist, @artist)
        expect(@song.artist).to be(@artist)
      end
    end

    describe "#artist=" do
      it "assigns an artist to the song (song belongs to artist)" do
        @song.artist = @artist
        expect(@song.artist).to eq(@artist)
      end
    end
  end

  context "Artist" do
    describe "#add_song" do
      it "assigns the artist to the song's 'artist' property (song belongs to artist)" do
        @artist.add_song(@song)
        expect(@song.artist).to eq(@artist)
      end

      it "adds the song to the artist's collection of songs (artist has many songs)" do
        @artist.add_song(@song)
        expect(@artist.songs).to include(@song)
      end

      it "does not re-assign the artist to the song if the song already has an artist" do
        @song.artist = @artist
        expect(@song).to_not receive(:artist=)
        @artist.add_song(@song)
      end

      it "does not add the song to the artist's song collection if the artist already has the song" do
        2.times { @artist.add_song(@song) }
        expect(@artist.songs).to include(@song)
        expect(@artist.songs.size).to eq(1)
      end
    end
  end

  context "Song" do
    describe "#artist=" do
      it "invokes Artist#add_song to add itself to the artist's collection of songs (artist has many songs)" do
        expect(@artist).to receive(:add_song)
        @song.artist = @artist
      end
    end
  end
end
