require "spec_helper"

describe "Associations — Artist and Genre" do
  before(:each) do
    @genre1 = Genre.new("indie rock")
    @genre2 = Genre.new("electro pop")
    @artist1 = Artist.new("The Magnetic Fields")
    @artist2 = Artist.new("Neutral Milk Hotel")
  end

  context "Artist" do
    describe "#genres" do
      it "returns a collection of the genres of all of the artist's songs" do
        Song.new("The Luckiest Guy on the Lower East Side", @artist1, @genre1)
        Song.new("Long-Forgotten Fairytale", @artist1, @genre2)

        expect(@artist1.genres).to include(@genre1)
        expect(@artist1.genres).to include(@genre2)
        expect(artist.genres.size).to be(2)
      end

      it "returns only unique genres for an artist if more than one song has the same genre" do
        Song.new("In the Aeroplane Over the Sea", @artist2, @genre1)
        Song.new("Two-Headed Boy", @artist2, @genre1)

        expect(@artist2.genres).to include(@genre1)
        expect(@artist2.genres.size).to eq(1)
      end

      it "does not use an instance variable @genres and collects genres from songs everytime" do
        song = Song.new("Long-Forgotten Fairytale", @artist2, @genre2)

        expect(@artist2.genres).to match_array([@genre2])
        expect(@artist2.instance_variable_defined?(:@genres)).to be_falsey

        song = Song.new("The Book of Love", @artist2, @genre1)
        expect(@artist2.genres).to match_array([@genre1, @genre2])
      end
    end
  end

  describe "Genres have many artists through songs" do
    describe "#artists" do
      it "returns only unique artists for a genre when artists have multiple songs" do
        Song.new("In the Aeroplane Over the Sea", @artist1, @genre1)
        Song.new("The Book of Love", @artist2, @genre1)
        Song.new("Papa was a Rodeo", @artist2, @genre1)

        expect(@genre1.artists).to match_array([@artist1, @artist2])
        expect(@genre1.artists.size).to eq(2)
      end

      it "does not use an instance variable @artists and collects artists from songs everytime" do
        Song.new("The Book of Love", @artist2, @genre1)
        Song.new("Papa was a Rodeo", @artist2, @genre1)

        expect(@genre1.artists).to match_array([@artist2])
        expect(@genre1.instance_variable_defined?(:@artists)).to be_falsey

        Song.new("In the Aeroplane Over the Sea", @artist1, @genre1)

        expect(@genre1.artists).to match_array([@artist1, @artist2])
      end
    end
  end
