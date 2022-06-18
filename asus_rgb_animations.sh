#!/usr/bin/env bash

# util functions

function turn_on_logo_led(){
    echo 1 > /sys/class/leds/aura_sync/led_on
}

function turn_off_logo_led(){
    echo 0 > /sys/class/leds/aura_sync/led_on
}

function turn_on_second_led(){
    echo 1 > /sys/class/leds/aura_sync/CSCmode 
    echo 1 > /sys/class/leds/aura_sync/bumper_enable
}

function turn_off_second_led(){
    echo 0 > /sys/class/leds/aura_sync/CSCmode 
    echo 0 > /sys/class/leds/aura_sync/bumper_enable
}

function animation_mode(){
    echo $1 > /sys/class/leds/aura_sync/mode
    echo 1 > /sys/class/leds/aura_sync/apply
}

function set_rgb_color(){
    echo $1 > /sys/class/leds/aura_sync/red_pwm
    echo $2 > /sys/class/leds/aura_sync/green_pwm
    echo $3 > /sys/class/leds/aura_sync/blue_pwm
    echo 1 > /sys/class/leds/aura_sync/apply
}

# end of util functions

# our custom animations

function police_animation(){
    if [ "$1" == "second_led" ]; then
        turn_on_second_led
    elif [ "$1" == "both_leds" ]; then
        turn_on_second_led
        turn_on_logo_led
    else
        turn_on_logo_led
    fi    
    animation_mode 9
    while true; do
        set_rgb_color 255 0 0
        sleep 1
        set_rgb_color 0 0 255
        sleep 1
    done    
}

function police_animation_alternate_between_leds(){
    while true; do
        turn_on_logo_led
        animation_mode 9
        set_rgb_color 255 0 0
        sleep 1
        turn_off_logo_led
        turn_on_second_led
        set_rgb_color 0 0 255
        sleep 1
        turn_off_second_led
    done
}

function going_through_all_animations_animation(){
    turn_on_logo_led
    turn_on_second_led
    set_rgb_color 242 88 21
    while true; do
        for i in $(seq 1 1 13); do
            animation_mode "$i"
            sleep 2
        done
    done 
}

# end of our custom animations

# Make sure leds are off when the script exists
# You can ignore these :)
trap "turn_off_logo_led; turn_off_second_led; exit" SIGINT
trap "turn_off_logo_led; turn_off_second_led; exit" SIGTERM
trap "turn_off_logo_led; turn_off_second_led; exit" SIGKILL
trap "turn_off_logo_led; turn_off_second_led; exit" SIGQUIT
trap "turn_off_logo_led; turn_off_second_led; exit" SIGHUP

# Menu Code Bellow
# colors for menu
BASH_COLOR_NC='\033[0m'
BASH_COLOR_Green='\033[0;32m'         
BASH_COLOR_LightBlue='\033[1;34m'    
BASH_COLOR_White='\033[1;37m'
BASH_COLOR_LightGreen='\033[1;32m'
BASH_COLOR_BOLD='\033[0;1m'

function print_menu(){
	echo -en "$BASH_COLOR_Green \n"
	echo "ASUS Rog Phone RGB Animations"
    echo ""
    echo "By Terminal_Heat_Sink"
	echo -en "$BASH_COLOR_LightGreen\n"
	echo -en "\nPress ${BASH_COLOR_White}1$BASH_COLOR_LightGreen to run police animation on logo led"
	echo -en "\nPress ${BASH_COLOR_White}2$BASH_COLOR_LightGreen to run police animation on second led"
	echo -en "\nPress ${BASH_COLOR_White}3$BASH_COLOR_LightGreen to run police animation on both leds"
	echo -en "\nPress ${BASH_COLOR_White}4$BASH_COLOR_LightGreen to run police animation on alternating leds"
	echo -en "\nPress ${BASH_COLOR_White}5$BASH_COLOR_LightGreen to run all driver animations animation"
	echo -en "\n\nPress ${BASH_COLOR_White}e$BASH_COLOR_LightGreen to Exit this script"
	echo -en "$BASH_COLOR_NC \n"
}

print_menu

choice="0"
while [[ $choice != "e" ]]; do
	read -n1 choice
    if [[ $choice == "e" ]]; then
        exit 0
    fi

	echo ""
    echo "Press Control + C to stop animations"

	if [[ $choice == "1" ]]; then
        police_animation
	elif [[ $choice == "2" ]]; then
        police_animation second_led
	elif [[ $choice == "3" ]]; then
        police_animation both_leds
	elif [[ $choice == "4" ]]; then
        police_animation_alternate_between_leds
	elif [[ $choice == "5" ]]; then
        going_through_all_animations_animation
	fi
done


