
require_relative './concerns/findable.rb'

class Artist

    extend Concerns::Findable

    attr_accessor :name
    @@all = []

    def initialize(name)
        @name = name
    end

    def self.create(name)
        new(name).tap{|artist| artist.save}
    end

    def add_song(song)
        song.artist = self unless song.artist == self
    end

    def songs
        songs = Song.all.select { |x| x.artist == self }
    end

    def genres
        genres = self.songs.collect do |song|
            song.genre 
        end
        genres.uniq
    end

    def save
        @@all << self
    end

    def self.destroy_all
        @@all.clear
    end

    def self.all
        @@all
    end


end