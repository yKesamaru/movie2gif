#!/bin/bash

# 初期設定 ###########
FPS=5
WIDTH=600
POSTERIZE=4
QUALITY=0-5
# ####################

CWD=$(pwd)
(
FILE=$(zenity --file-selection --file-filter="MOVIE files | *.mp4 | *.avi | *.oga" --title="Select a MOVIE file" --filename="${CWD}/")
echo "0"
ffmpeg -i "${FILE}" -an -r ${FPS} %04d.png
echo "30"
mogrify -resize ${WIDTH}x *.png
echo "50"
pngquant --posterize=$POSTERIZE --quality=$QUALITY *.png
echo "70"
convert *fs8.png ANIMATION.gif
echo "90"
rm *.png
echo "100"
) | 
zenity --progress \
  --title="Make animation gif" \
  --text="処理中..." \
  --percentage=0 \
  --auto-close \
  --no-cancel

if [ "$?" = -1 ] ; then
    notify-send --error --text="中断されました"
    # zenity --error --text="中断されました"
    rm *.png
fi

paplay "other/Positive.ogg"
notify-send -i "${CWD}/other/man_55.png" "アニメーションGIF" "終了しました"
# zenity --notification --text "終了しました" --title="アニメーションGIF" --window-icon "${CWD}/other/man_55.png"