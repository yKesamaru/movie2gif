#!/bin/bash

# 初期設定 ###########
FPS=5
WIDTH=600
QUALITY=0-60
# POSTERIZE=4
# ####################

SECONDS=0
CWD=$(pwd)
(
    # FILE=$(zenity --file-selection --file-filter="MOVIE files | *.mp4 | *.avi | *.oga | *.webm" --title="Select a MOVIE file" --filename="${CWD}/")
    FILE="input.mp4"
    # original -----------------------
    # ffmpeg -threads 0 -t 5 -i "${FILE}" -an -r ${FPS} %04d.png
    # scaling ffmpeg -----------------
    # ffmpeg -threads 0 -t 5 -i "${FILE}" -vf "fps=${FPS},scale=${WIDTH}:(ow/a/2)*2" %04d.png 
    ffmpeg -threads 0 -i "${FILE}" -vf "fps=${FPS},scale=${WIDTH}:(ow/a/2)*2" %04d.png 
    # scaling & paletteuse -----------
    # ffmpeg -threads 0 -t 5 -i "${FILE}" -vf "fps=${FPS},scale=${WIDTH}:(ow/a/2)*2:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" %04d.png
    # ffmpeg -threads 0 -i "${FILE}" -vf "fps=${FPS},scale=${WIDTH}:(ow/a/2)*2:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" %04d.png
    # watermark ----------------------
    # ffmpeg -threads 0 -t 5 -i "${FILE}" -vf "movie=other/watermark.png [watermark];[in][watermark] overlay=10:10 [out]" %04d.png
    echo "30"
    # mogrify -resize ${WIDTH}x *.png
    echo "50"
    find . -maxdepth 1 -type f -name '*.png' -not -name '*fs8.png' -print0 | parallel -0 pngquant --quality=$QUALITY {}
    # find . -maxdepth 1 -type f -name '*.png' -not -name '*fs8.png' -exec echo pngquant --quality=$QUALITY {} \;
    # pngquant --force 64 *.png
    echo "70"
    convert *fs8.png ANIMATION.gif
    # convert *.png ANIMATION.gif
    echo "90"
    rm *.png
    echo "100"
) | 
zenity --progress \
    --title="Make animation gif" \
    --text="処理中..." \
    --percentage=10 \
    --auto-close \
    --no-cancel

if [ "$?" = -1 ] ; then
    notify-send --error --text="中断されました"
    # zenity --error --text="中断されました"
    rm *.png
fi

echo $SECONDS
paplay "other/Positive.ogg"
notify-send -i "${CWD}/other/man_55.png" "アニメーションGIF" "課長、さっきのできましたよ"
# zenity --notification --text "終了しました" --title="アニメーションGIF" --window-icon "${CWD}/other/man_55.png"