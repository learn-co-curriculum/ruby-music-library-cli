
class MusicLibraryController

    attr_accessor :path

    def initialize(path = "./db/mp3s")
        @path = path
        MusicImporter.new(@path).import
    end

    def call
        puts "Welcome to your music library!"
        puts "What would you like to do?"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        input = gets.strip
        case input
            when 'list songs'
                list_songs
            when 'list artists'
                list_artists
            when 'list genres'
                list_genres
            when 'list artist'
                list_songs_by_artist
            when 'list genre'
                list_songs_by_genre
            when 'play song'
                play_song
            else 
                call unless input == "exit" 
        end
    end

    def list_songs
        songs = Song.all.sort {|a, b| a.name <=> b.name}
        songs.each_with_index { |song, i| puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end

    def list_artists
        artists = Artist.all.sort {|a, b| a.name <=> b.name}
        artists_name = artists.collect {|artist| artist.name}
        artists_name.uniq.each_with_index { |artist, i| puts "#{i + 1}. #{artist}" }        
    end

    def list_genres
        genres = Genre.all.sort {|a, b| a.name <=> b.name}
        genres_name = genres.collect {|genre| genre.name}
        genres_name.uniq.each_with_index {|genre, i| puts "#{i + 1}. #{genre}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        artist_songs = Song.all.select {|song| song.artist.name == input}
        artist_songs_sort = artist_songs.sort {|a, b| a.name <=> b.name}
        artist_songs_sort.each_with_index {|song, i| puts "#{i + 1}. #{song.name} - #{song.genre.name}"}
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        genre_songs = Song.all.select {|song| song.genre.name == input}
        genre_songs_sort = genre_songs.sort {|a, b| a.name <=> b.name}
        genre_songs_sort.each_with_index {|song, i| puts "#{i + 1}. #{song.artist.name} - #{song.name}"}
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        songs = Song.all.sort {|a, b| a.name <=> b.name}
        if input > 0 && input <= songs.length
            puts "Playing #{songs[input - 1].name} by #{songs[input - 1].artist.name}"
        end    
        
    end

end