MusicHUD
========

A HUD for your currently playing music  

##What it's for
So say you have a Raspberry Pi or some device of equal significance lying around (like the amazing BeagleBone Black),
and some sort of display 4 - 9 inches diagonal. Well, now you can use it to show the world what you're listening to right now.

##How it works
The system works by creating a webserver on a simplistic device, and then allowing POST requests to it. The UI then gets updated
based on the new data. QT is used for the GUI, and CherryPy for the server.

##Programs
Currently, MusicHUD supports iTunes, Sonora, and Spotify with more to come.

##Running
Simply call `python2 musichud.py` on your display system. You can then POST information to it using anything, for example cURL.
Currently, there is a Cocoa application that interfaces with the music players using ScriptingBridge, and send the proper request
on song change. Feel free to fork and write your own push program.

##Licensing
This code is hereby released under the MIT License. Copyright 2013 Katherine Whitlock.
