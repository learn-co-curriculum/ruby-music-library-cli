require "spec_helper"

describe "Associations — Song and Genre:" do
  before(:each) do
    @song = Song.new("In the Aeroplane Over the Sea")
    @genre = Genre.new("indie rock")
  end

  context "Genre" do
    describe "#initialize" do
      it "creates a 'songs' property set to an empty array (genre has many songs)" do
        expect(@genre.instance_variable_defined?(:@songs)).to be(true)
        expect(@genre.instance_variable_get(:@songs)).to eq([])
      end
    end

    describe "#songs" do
      it "returns the genre's 'songs' collection (genre has many songs)" do
        expect(@genre.songs).to eq([])
        @genre.songs << @song
        expect(@genre.songs).to eq([@song])
      end
    end
  end

  context "Songs belong to a genre" do
    describe "#genre=" do
      it "accepts an genre for the song" do
        @song.genre = @genre

        expect(@song.genre).to eq(@genre)
      end

      it "adds the song to the genre's songs" do
        @song.genre = @genre

        expect(@genre.songs).to include(@song)
      end

      it "does not add the song to the genre's songs if it already exists" do
        @song.genre = @genre
        @song.genre = @genre

        expect(@genre.songs).to include(@song)
        expect(@genre.songs.size).to eq(1)
      end
    end
  end

  context "initializing a song with a genre" do
    it "songs accept an optional argument for the genre" do
      artist = Artist.new("Neutral Milk Hotel")
      song = Song.new("In the Aeroplane Over the Sea", artist, @genre)

      expect(@genre.songs).to include(song)
      expect(song.genre).to eq(@genre)
    end
  end
end
