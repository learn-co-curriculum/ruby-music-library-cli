require_relative './song'

class Artist
    extend Concerns::Findable
    extend Concerns::Sortable
    
    attr_accessor :name
    @@all = []

    def initialize(name)
        @name = name
    end

    def self.all
        @@all
    end

    def self.destroy_all
        all.clear
    end

    def save
        self.class.all << self
        self
    end

    def self.create(name)
        new(name).save
    end

    def songs
        Song.all.select do |song|
            song.artist == self
        end
    end

    def add_song(song)
        song.artist = self unless song.artist
    end

    def genres
        songs.collect {|s| s.genre}.uniq
    end

end