require 'spec_helper'

describe "Genre Basics" do
  describe '#initialize with #name' do
    it 'accepts a name for the genre' do
      genre = Genre.new("indie rock")
      expect(genre.name).to eq("indie rock")
    end
  end

  describe '#name=' do
    it "sets the genre name" do
      genre = Genre.new("indie rock")
      genre.name = "classics"

      expect(genre.name).to eq("classics")
    end
  end

  describe '@@all' do
    it 'is set to an empty array' do
      all = Genre.class_variable_get(:@@all)
      expect(all).to match_array([])
    end
  end

  describe ".all" do
    it "returns the class variable @@all" do
      expect(Genre.all).to match_array([])

      Genre.class_variable_set(:@@all, ["shoegaze"])
      expect(Genre.all).to match_array(["shoegaze"])
    end
  end

  describe ".destroy_all" do
    it "resets the @@all class variable to an empty array" do
      Genre.destroy_all
      expect(Genre.all).to match_array([])
    end
  end

  describe '#save' do
    it 'adds the genre instance to the @@all class variable' do
      genre = Genre.new("indie rock")

      genre.save

      expect(Genre.all).to include(genre)
    end
  end

  describe '.create' do
    it 'initializes and saves the genre' do
      genre = Genre.create("indie rock")

      expect(Genre.all).to include(genre)
    end
  end
end
