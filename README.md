# Asus Rog Phone Rgb User Animations

Download the asus_rgb_animations.sh to your phone and run the script in termux as root.

The plan for this is that you guys can add your own custom animations by forking the repo and if there is a good number of custom animations that get added by the community I might integrate it into the Asus Rog Phone RGB app by parsing the different animation functions from the script on github and converting it into native UI, so that the custom animations can be run from the app itself. When there is an update to this repo the app will also immediately get access to the new animations, that way I won't need to update the app just for new animations.

## Video Guide
[![guide](https://img.youtube.com/vi/jeHSxXXRA1g/0.jpg)](https://www.youtube.com/watch?v=jeHSxXXRA1g)

## Driver Animation list
Use these with the animation_mode function. These are explained in the video. This is just for reference.
- 0 -> off
- 1 -> solid one colour
- 2 -> breathing one colour
- 3 -> blink
- 4 -> rainbow
- 5 -> another rainbow?
- 6 -> rainbow breathe
- 7 -> somekind of thunder
- 8 -> thunder rainbow
- 9 -> quick two flashes
- 10 -> quick two flashes rainbow
- 11 -> breathe rainbow
- 12 -> some strange breathe rainbow
- 13 -> slow glitchy rainbow

## Making your own animations
For now the script is quite simple so just create a function and add it to the menu as shown in the video.

The script comes with some util functions that you can use so that you don't need to interact with the driver directly. And its easier to use and read.

- turn_on_logo_led
- turn_off_logo_led
- turn_on_second_led
- turn_off_second_led
- animation_mode
- set_rgb_color

## What is upload_to_phone.sh ?
This is just a handy developer script that I use to copy the asus_rgb_animations.sh to the phone. It will copy it to your `/sdcard/temp` folder. And then you can adb shell into your phone and run the script by typing 
```
su
``` 
to get root access and then 
```
sh /sdcard/temp/asus_rgb_animations.sh
``` 
to run the script.
