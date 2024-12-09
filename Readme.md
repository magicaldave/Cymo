# Cymo - Umo, but Rust

Cymo is a simple Pyoxidizer build system custom-made for Modding-OpenMW's Umo mod downloader. It's short, sweet, and to the point. It's not necessarily meant to be built locally, but it is possible to do it.

Note that the Umo builds Cymo provides are *explicitly* not meant to be used by end-users. Period. Don't download this and try to run it and ask me why it doesn't work. Go download [Umo](https://modding-openmw.gitlab.io/umo/) proper if you want that.

However, if you are me, and you have forgotten how to use Cymo properly, do read on.

Cymo executables are distributed for Windows and Linux, built on Windows Server 2019 and Ubuntu 20.04 - being the oldest operating systems available in GitHub Actions. Both archives contain the umo executable and associated python dependencies. On both platforms, the `lib` folder must be adjacent to the umo executable at all times in order for it to work. If you get errors about detecting the filesystem encoding accompanied by a bunch of information about the python environment, you have probably screwed this part up in some way.

However, handling of the native libraries provided is platform-specific:

Linux:
    The `.so` files adjacent to the umo binary must be pointed to by setting the environment variable `LD_LIBRARY_PATH="$(pwd)"` at minimum. Feel free to move these elsewhere, as long as it loads them successfully. If you get errors about ssl libraries when running umo, you have probably screwed this step up.

Windows:
    Keep them where they're at. On Windows, `.dll` files will load from the same directory as the executable they're stored in. Just, don't screw with it, okay?

Caveats which apply to all platforms:

1. Umo *will not run* if you don't set the environment variable `UMO_NO_NOTIFICATIONS`. It will blow up and explode in your face and not work and you will be sad and confused. This may be fixable.
2. Umo *must* be used with `--threads 1` when performing operations which may be multithreaded (I think this is just `install` but I'm uncertain)

Virustotal results for both [Windows](https://www.virustotal.com/gui/file/6c634b4e52a937c0cf1b017a61d237613f5e9fe8b5b1dd78243d2d3b7823b905/details) and [Linux](https://www.virustotal.com/gui/file/3c74cb3934d5351a216af6c7cbfee668dff4dceea0ff571631dfa4b3c7d8919a/details) builds of Cymo are available.

All of the above are why Cymo is not meant to be distributed to end users and I have to say again:

# DO NOT DOWNLOAD THIS AND ASK ME FOR HELP
