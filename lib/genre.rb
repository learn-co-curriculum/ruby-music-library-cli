
require_relative './concerns/findable.rb'

class Genre

    extend Concerns::Findable

    attr_accessor :name
    @@all = []

    def initialize(name)
        self.name = name
    end

    def self.create(name)
        new_artist = Genre.new(name)
        new_artist.save
        return new_artist
    end

    def songs
        songs = Song.all.select do |x|
            x.genre == self
        end
        songs
    end

    def artists
        artists = self.songs.collect do |song|
            song.artist
        end
        artists.uniq
    end

    def save
        self.class.all << self
    end

    def self.destroy_all
        @@all.clear
    end

    def self.all
        @@all
    end

end