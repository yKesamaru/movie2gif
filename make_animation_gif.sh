#!/bin/bash

# 初期設定 ###########
FPS=5
WIDTH=600
POSTERIZE=4
QUALITY=0-5
# ####################

# ToDo
# zinity OR other GUI system

ffmpeg -i *.mp4 -an -r $FPS %04d.png 
mogrify -resize ${WIDTH}x *.png
pngquant --posterize=$POSTERIZE --quality=$QUALITY *.png
convert *fs8.png ANIMATION.gif
rm *.png
paplay "other/Positive.ogg"
notify-send -i "other/mark_heart.png" "アニメーションGIF" "終了しました"