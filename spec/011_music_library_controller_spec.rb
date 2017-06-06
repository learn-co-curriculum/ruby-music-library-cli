require "spec_helper"

describe "MusicLibraryController" do
  describe "#initialize" do
    it "accepts one argument, the path to the MP3 files to be imported" do
      expect{ MusicLibraryController.new("./spec/fixtures/mp3s") }.to_not raise_error
    end

    it "creates a new MusicImporter object, passing in the 'path' value" do
      expect(MusicImporter).to receive(:new).with("./spec/fixtures/mp3s").and_return(double(MusicImporter, import: true))
      MusicLibraryController.new("./spec/fixtures/mp3s")
    end

    it "the 'path' argument defaults to './db/mp3s'" do
      expect(MusicImporter).to receive(:new).with("./db/mp3s").and_return(double(MusicImporter, import: true))
      MusicLibraryController.new
    end

    it "invokes the #import method on the created MusicImporter object" do
      music_importer = MusicImporter.new("./spec/fixtures/mp3s")
      expect(MusicImporter).to receive(:new).and_return(music_importer)
      expect(music_importer).to receive(:import)
      MusicLibraryController.new
    end
  end

  describe "#call" do
    before(:each) do
      @music_library_controller = MusicLibraryController.new("./spec/fixtures/mp3s")
      allow(@music_library_controller).to receive(:gets).and_return("exit", "a", "b", "exit")
    end

    it "initiates the music library's CLI" do
      expect($stdout).to receive(:puts).with("Welcome to your music library!")
      @music_library_controller.call
    end

    it "asks the user for input" do
      expect(@music_library_controller).to receive(:gets).and_return("exit")
      @music_library_controller.call
    end

    it "loops and asks for user input until they type in exit" do
      expect(@music_library_controller).to receive(:gets).and_return("a", "b", "exit")
      @music_library_controller.call
    end
  end
end
