# An Objective-C/Foundation command line app to list missing Music files

(Basically the same as [this](https://github.com/charlierobin/list-missing-apple-music-files-swift), but implemented in Objective-C and not Swift.)

Because this one was the first one I wrote, it’s complete, whereas the Swift version is still not quite complete.

If you run this app in the Terminal with no arguments, it tries to connect to your Music library via `ITLibrary` `libraryWithAPIVersion`.

It then goes over all the tracks in the library and checks whether or not they have a `Location`.

If they don’t (which means they are displayed in the Music browser window with a grey warning exclamation mark, and the Music app asks you if you want to try to locate them when you try and play the,) then their details are printed to `stdout`.

If the track does have a `Location` then the path is checked to make sure that there is actually something there.

If the audio file is still missing, then the track details are output to `stdout`.

I originally wrote this utility because I was getting fed up with iTunes (and then the Music app that replaced it) saying that it had successfully imported my audio files, and then only finding out days (or weeks or months or even years) later that in fact it had not, and that the audio files were missing.

(An irritating stunt which seems to be something that even recent versions of Apple Music is prone to pulling off at the most inconvenient moments.)

The app can work both with the current “live” Music library (just call it with no arguments), ie:

`/path/to/list-missing-apple-music-files`

… or you can export your music library as XML from the Music app and then pass the path to that file as an argument, ie:

`/path/to/list-missing-apple-music-files /path/to/my/exported/Library.xml`

[More information on the iTunes Library framework …](https://developer.apple.com/documentation/ituneslibrary)

[More information on the FileManager class …](https://developer.apple.com/documentation/foundation/filemanager)
