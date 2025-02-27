# Doom for the Atari Jaguar - Extended Edition JagdoomE

This project allows you to build Doom for the Atari Jaguar in Windows 10. It uses old toolchain released by Atari which was put into the Public Domain. 
You can read about the Jaguar saga elsewhere - we're just concerned with Doom. 
We can thank Carl Forhan from Songbird Productions for that. 
He talked Carmack into releasing the Jaguar source, then played with it enough to get it to work on real hardware, then released the source for others to play with.

Having never worked on Doom for any platform, I decided after waiting for an eternity, to give it a try.  
Began using the work Saturn posted back in 2015, and then luckily got the assistance of ChillyWillyGuru.
It fell on the Green Lizard to revive the old Windows DOS build.  It presented some limitations.  
While it is easier and takes less steps in Linux, Windows is quite capable of producing a rom.  The biggest issue is DoxBox and how it manages table memory.


## Additional Tools Required for Windows


1 - DosBox 74-3


2 - Python for windows


3 - GetTheWad.py - provided by Tolbat


4 - PadTempBin1.py - old method provided by Tolbat


5 - Cygwin - now required - use OldMakefile for old build

	Please download Cygwin for windows with the following ADD ONS:
	gcc-core → Select for installation (C Compiler)
	gcc-g++ → Select for installation (C++ Compiler)
	make → Select for installation
	git → (Optional, if you want to clone repositories)

	Once installed verify the version in Cygwin
	gcc --version
	g++ --version
	make --version
	git --version


6 - Open Jaggd.exe - optional

	Before beginning please download the Open Jaguar GD source and compile the jaggd.exe and ensure it is placed in C:/Jaguar/src
	https://github.com/cubanismo/open_jaggd
	Special thanks to James Jones aka cubanismo## Setting up the Enviroment:


## Creating your Doom IWAD file
Assuming you don't already have the wad file for the game, but you DO have the original
Jaguar Doom rom image (not provided!), copy the Jaguar Doom rom image into the
C:\jaguar\GetMyWad directory, and make sure it's named "Doom.j64". 
You can then create the wad file by running GetTheWad.py it will then be placed in C:\jaguar\src
Now you have your wad file!



In this example we will use the root windows directory C:\  
You may use any drive you wish but you will need to update all the different filepaths yourself.

Place the Jaguar folder in the root of C:\
Rename setpath.txt to setpath.bat and place setpath.bat in the root of C:\
open DosBox 74-3 and type 

```
mount C: C:\ 
```

A warning will appear, ignore it.

```
setpath 
```

You should now see the prompt change to C:\Jaguar\Src



## STEP 1


First we need to prep the build enviroment.  Lets clean it!

```
make clean
```



## STEP 2

TO BUILD THE DOOM GAME FOR JAGUAR # must start by creating doom.abs

```
make
```

```
Note: 
In WINDOWS ONLY DosBox runs out of table memory when moving the temp files around.
DosBox and DosBoxX will both crash with a warning that says "Not Enough Memory for Internal Tables".
Reopen DosBox and use make jagdoom command again, do this until it spits out #doom.abs
From the beginning of the process if you open DosBox and do make clean, then make it should only crash once, and does NOT effect the compile process.
Now that you have doom.abs we can continue.
```


## STEP 3

```
make boot 
```

creates needed bootfiles
boot.abs



## STEP 4  Open Cygwin Terminal 

set path

cd C:/Jaguar/src

```
make rom:
```

This merges the boot.abs and doom.abs, after it pads it to 256k.  No more extra steps to pad the files.

then merges the padded rom with the doom.wad file.

creates the rom JagDoomEX.j64 


```
#Now Test Directly on your Jaguar with Cygwin
No Emulator needed test directly on the Jaguar

Compile Doom.abs only using the original method and ensure it is in the src folder.
Ensure Doom.wad is in the src folder.

Power on your Jaguar
Connect the Gamedrive to a USB port on your computer (ensure the cable is a data cable)
Wait for the USB to be detected and installed

Load Cygwin
cd /cygdrive/c/Jaguar/src					this puts you in the correct directory if it matches mine

usb:
/cygdrive/c/Jaguar/src/JagGD.exe -rd						resets Jaguar / Gamedrive
/cygdrive/c/Jaguar/src/JagGD.exe -u DOOM.ABS,a:0x2000		loads ABS to address
/cygdrive/c/Jaguar/src/JagGD.exe -u doom.wad,a:0x840000		loads WAD to address
/cygdrive/c/Jaguar/src/JagGD.exe -x 0x2000					loads the game at the address

```


## New Features
You can select widescreen on/off in the Options menu. This makes Doom look the proper aspect ratio on 16:9 TVs. 
Off assumes a standard 4:3 TV. 
Defaults to off, and is saved in the e2prom.

Arms indicators so that they show the proper keypad number. 
Added colors to indicate some status info. 
GREEN if the weapon is equipped, 
BLUE if the required ammo is more than half the max allowed count (with or without the backpack),
YELLOW if the required ammo is less than half the max allowed count,
and RED if the weapon is out of ammo. At a glance, you get vital information. 
This can be made an option if people prefer not having colored indicators. 

## New Controls

Subject to change:


C/B/A/PAUSE/OPTION remain as set in the game. The differences arise in the
number pad, which also affects the ProPad controller.
```
1 = select PISTOL
2 = FORWARD
3 = select SHOTGUN
4 = STRAFE LEFT
5 = BACKWARD
6 = STRAFE RIGHT
7 = select CHAINGUN
8 = select MISSILE LAUNCHER
9 = select PLASMA RIFLE
* = toggle between FIST/CHAINSAW
0 = select BFG9000
# = select AUTOMAP
* + # = reset game
```
4 and 6 are the same as the LEFT and RIGHT shoulder buttons on the ProPad, which
is why they are set for strafing. I set 2 and 5 to forward and backward because
I will be adding mouse support, and having those four buttons arranged as they
are will make it easier to play like using a keyboard and mouse on the PC. The
buttons 7, 8, and 9 map to the ProPad buttons Z, Y, and X, respectively. This
gives you quick access to the heavier weapons in Doom. I decided not to put the
BFG in there as it usually has limited ammo, so you really don't want to be 
accidentally selecting it. Likewise, selecting the fist or chainsaw is fairly
rare, so it could be one of the out-of-the-way buttons. When Doom 2 support gets
added, the SHOTGUN button will toggle between the shotgun and the super shotgun.
Note that you don't NEED a ProPad controller. It will work fine on a normal
Jaguar pad. You just don't have shoulder buttons, nor Z/Y/X.


The pad controller goes into port 1. When mouse support is done, it will plug
into port 2. You will need an Atari ST or Amiga mouse with appropriate adapter,
or a PS/2 mouse with appropriate adapter for upcoming mouse support.



## Acknowledgements
```
John Carmack for writing such an awesome game, and releasing it to the public.
Carl Forhan for providing and arranging the code release
Saturn for his work on the Windows build back in the days of Skunk.
ChillyWillyGuru for providing the cleaner Linux build, makefile, new controls, and his ongoing improvements.
A31Chris for organizing and planning
To the many silenced Jaguar owners!
```

## Known Bugs

The network code still has bugs

No in game music


## TIME SAVER for DOSBox or DosBoxX

Insert the following into the [autoexec] portion of the dosbox-0.74-3.conf file - this speeds 
things up.  or the DOSboxX config file.

```
MOUNT C C:\

C:

setpath

pause

```

## Alt src folder added  src - TolbatHUDandControls - may need fine tuning with newer code

---
Just my testing junk - use at own risk!
src - TolbatHUDandControls
not updated with current code

---

## Additional Tools for later
getthehex2v1  - finds the iwad offset and updates jagonly.c

getthehex3v1  - finds the iwad offset and updates jagonly.c and boot.s

Note - These may be useless but they can find the WAD file if for some reason its smaller, may need more work to logic.


## Changelog

If a known feature is missing please visit the Linux GitHub page: 
```
https://github.com/ChillyWillyGuru/JagDoomEX/

12-15-2024
241215 - Revert Init.s to use old init.o - not fixed per Chilly 
241215 - Fixed sprites sometimes visible thru walls bug.
241215 - Fixed transparent spectres on real hardware.
241214 - Fixed init.s to work with real hardware.
241210 - First commit to repo.
241209 - Fixed the spectre - now in Super Ghostly Phantasmagoric™ rendering.
241209 - Remapped the controls to allow for the ProPad.


250212 - CRT Widescreen, Improved HUD with ammo color states
250212 - Jaggd.exe Support for windows 10 via Cygwin
250213 - Cygwin now required, building the rom is now comparable to linux.  Still has memory crash issue.  Testing a fix - no promises.
			If you do not want to use Cygwin please use OldMakefile and rename to makefile it cannot be makefile.mak.  
			Please follow OldInst.txt
250226 - Corrected mistakes to setup

```


## Alt Tolbat

This is no longer being tested as of 2/1/2025 can be used to go back later
Tolbat Controls:
```
JP_1 - toggles pistol/fist
JP_2 - forward
JP_3 - toggles chaingun/shotgun
JP_4 - Strafe Left
JP_5 - backwards
JP_6 - Strafe Right
JP_7 - Rocket Launcher
JP_8 - Turn Player Around 180 degrees - 'about face'
JP_9 - toggles Plasma / BFG
JP_* - toggles all weapons >
JP_0 - MAP
JP_# - toggles weapons <
```
```
Tolbat HUD -  Now displays Equipped weapons only unless in melee mode - shows weapons owned - in case player is
stoned and cant remember what weapons they have :)

```

