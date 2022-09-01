#/bin/bash

wallpaper=$(cat /home/ghost/.cache/wal/wal)
wallpaper_path="/home/ghost/.cache/wal/wal"
theme_path="/home/ghost/.cache/wal/colors"

# get input flags
while getopts i:w:ldt: flag
do
    case "${flag}" in
		# set wallpaper and theme
        i) wal -i ${OPTARG}; > /dev/null ; theme=true ;;
		
		# set wallpaper only
        w) > $wallpaper_path && echo ${OPTARG} >> $wallpaper_path ; theme=false ;;
        # w) > $wallpaper_path && echo "$(pwd)/${OPTARG}" >> $wallpaper_path ; theme=false ;;
		
		# set theme to light
		l) wal -l -n -i $wallpaper > /dev/null ; theme=true;;

		# set theme to dark
		d) wal -n -i $wallpaper > /dev/null ; theme=true ;;
 	
		# set theme only
		t) wal --theme ${OPTARG} > /dev/null ; theme=true ;;
		
    esac
done

if [ $theme == true ]; then
	# sets gtk theme colors
	oomox-cli /opt/oomox/scripted_colors/xresources/xresources-reverse > /dev/null
	# reloads gtk theme
	killall xsettingsd > /dev/null 2>&1
	timeout 1 xsettingsd -c .config/xsettingsd/xsettingsd.conf > /dev/null 2>&1
fi
