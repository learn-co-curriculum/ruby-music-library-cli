require 'spec_helper'

describe "Song Basics" do
  describe '#initialize with #name' do
    it 'accepts a name for the song' do
      song = Song.new("In the Aeroplane Over the Sea")
      expect(song.name).to eq("In the Aeroplane Over the Sea")
    end
  end

  describe '#name=' do
    it "sets the song name" do
      song = Song.new("In the Aeroplane Over the Sea")
      song.name = "Jump Around"

      expect(song.name).to eq("Jump Around")
    end
  end

  describe '@@all' do
    it 'is set to an empty array' do
      all = Song.class_variable_get(:@@all)
      expect(all).to match_array([])
    end
  end

  describe '.all' do
    it 'returns the class variable @@all' do
      expect(Song.all).to match_array([])

      Song.class_variable_set(:@@all, ["Kaohsiung Christmas"])
      expect(Song.all).to match_array(["Kaohsiung Christmas"])
    end
  end

  describe '.destroy_all' do
    it 'resets the @@all class variable to an empty array' do
      Song.class_variable_set(:@@all, ["Song"])

      Song.destroy_all
      expect(Song.all).to match_array([])
    end
  end

  describe '#save' do
    it 'adds the song instance to the @@all class variable' do
      song = Song.new("In the Aeroplane Over the Sea")

      song.save

      expect(Song.all).to include(song)
    end
  end

  describe '.create' do
    it 'initializes and saves the song' do
      song = Song.create("In the Aeroplane Over the Sea")

      expect(Song.all).to include(song)
    end
  end
end
