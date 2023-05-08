#!/usr/bin/env bash
#wget -O wallpaper.jpg "http://www.bing.com/$(wget -q -O- https://binged.it/2ZButYc | sed -e 's/<[^>]*>//g' | cut -d / -f2 | cut -d \& -f1)"  
wget https://source.unsplash.com/featured/3840×2160/?wallpaper -O ~/Pictures/wallpaper.jpg &&
feh --bg-scale ~/Pictures/wallpaper.jpg
