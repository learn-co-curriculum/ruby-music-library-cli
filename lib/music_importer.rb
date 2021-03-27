
class MusicImporter

    attr_accessor :path

    def initialize(path)
        @path = path    
    end

    def files

        @path2 = @path + "/**/*"
        @path3 = Dir[@path2].map{|f| File.basename(f)}

    end

    def import
        all_songs = self.files
        all_songs.each do |song|
            Song.create_from_filename(song)
        end
    end
    
end