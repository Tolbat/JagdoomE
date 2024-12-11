# Doom for the Atari Jaguar - Extended Edition JagdoomE

This project allows you to build Doom for the Jaguar under linux. It uses the latest toolchain released by Atari which was put into the Public Domain. You can read about the Jaguar saga elsewhere - we're just concerned with Doom. We can thank Carl Forhan from Songbird Productions for that. He talked Carmack into releasing the Jaguar source, then played with it enough to get it to work on real hardware, then released the source for others to play with.

Having never worked on Doom for any platform, I always wanted to work on the Jaguar, and have it available to anyone and everyone.  Using the work Saturn posted back in 2015, and with the assistance of ChillyWillyGuru I have returned the old Windows DOS build back to service.  While it is easier and takes less steps in linux. We are going to use Windows 10 64 bit.

## Additional Tools Required for Windows
1:  DosBox 74-3
2:  Python for windows
1:  GetTheWad.py - provided
2:  PadTempBin1.py - provided

## Setting up the Enviroment:
In this example we will use the root windows directory C:\  You may use any drive you wish but you will need to update all the different filepaths yourself.

Place the Jaguar folder in the root of C:\
Place setpath.bat in the root of C:\
open DosBox 74-3 and type 
```
mount C: C:\ 
```

- a warning will appear, ignore it.
then type setpath and hit enter.
You should now see the prompt change to C:\Jaguar\Source




