![bannar](https://raw.githubusercontent.com/yKesamaru/movie2gif/master/other/bannar.png)
# これは何？
動画ファイルからアニメーションgifファイルを作成します。  
デフォルトでは5fps, 横幅600pxに調整します。  
  
**…そこら辺に転がってるって？**  
  
- 進行状況をプログレスバーで表示  
![](https://raw.githubusercontent.com/yKesamaru/movie2gif/master/other/progress_bar.png)  
- 終了を音と通知ダイアログでお知らせ  
![](https://raw.githubusercontent.com/yKesamaru/movie2gif/master/other/dialog.png)  
  
可愛いおじさんが終了をお知らせしてくれます。  
再配布禁止なのでおじさんアイコンは個別にダウンロードして下さい…  
![](https://raw.githubusercontent.com/yKesamaru/movie2gif/master/other/yurusu.jpg)  
ありがとうございます。
# Zenityのprogress dialogってどう書く？
シェルスクリプトにGUIならZenityですが、プログレスバーの動かし方は知りませんでした。[GNOME HELP](https://help.gnome.org/users/zenity/stable/progress.html.en)を読んでみるとどうやら`echo`を使うと良さそうです。  

```bash
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
```
キャンセルボタンは必要ありませんので`--no-cancel`を指定します。  
# ファイルサイズをなるべく小さく！
アニメーションgifはサイズが大きいです。だいたい元の動画ファイルよりも大きくなります。貼り付けたい場合困ります。そこで以下の対策をして減量化しました。
- 5fps
- width 600pxリサイズ
- pngquantによる最適化  
pngquantによる最適化は[【じーろぐ】減色ツールPngquantの仕組みと最適パラメータを探る](https://zlog.hateblo.jp/entry/2019/05/05/pngquant)を参考にしました。  
```bash
  --quality min-max don't save below min, use fewer colors below max (0-100)
  --speed N         speed/quality trade-off. 1=slow, 3=default, 11=fast & rough
  --ordered         disable Floyd-Steinberg dithering
  --floyd           Controls level of dithering (0 = none, 1 = full).
  --posterize N     output lower-precision color (e.g. for ARGB4444 output)
  --strip           remove optional metadata (default on Mac)
```
pngquantは優秀でちょっとやそっとでは画質が荒くなりません。デフォルトの設定では最低値にしてその分サイズを小さくしています。荒いな、と思ったら設定を上げてみると良いと思います。  
# デスクトップ通知はzenityかnotify-sendか

# Installation
新しいフォルダを作り、そこにファイルを置いて下さい。  
![](https://raw.githubusercontent.com/yKesamaru/movie2gif/master/other/dir.png)  
`git clone`すれば初めからこの様になります。  
`make_animation_gif.sh`に実行権限を与えて下さい。
# Usage
`make_animation_gif.sh`をダブルクリックするか仮想端末から起動して下さい。
# Requirements
- ffmpeg
- imagemagick
- pngquant
- paplay
- notify-send
- zenity
# Setting
## Parameters
標準では以下の設定になっています。
- FPS=5
  - ffmpeg
- WIDTH=600
  - mogrify
- POSTERIZE=4
  - pngquant, 削減ビット数最大値
- QUALITY=0-5
  - pngquant, 最低0-100  
  
もし設定を変えたい場合はソースの以下の部分を変更して下さい。  
```bash
# 初期設定 ###########
FPS=5
WIDTH=600
POSTERIZE=4
QUALITY=0-5
# ####################
```
## Icon
man_55.pngは[いらすとや様該当ページ](https://3.bp.blogspot.com/-1LXBe86Lrs8/Vf-artgLU6I/AAAAAAAAyJE/i5zNuMDWXWo/s800/icon_business_man13.png)から個別にダウンロードして下さい。
# Reference
- [pngquant](https://pngquant.org/)公式
- [Icon Naming Specification](https://specifications.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html)
- [【Zenn】github用のアニメーションgifまわりあれこれ](https://zenn.dev/ykesamaru/articles/52653d248e854d)
- [【じーろぐ】減色ツールPngquantの仕組みと最適パラメータを探る](https://zlog.hateblo.jp/entry/2019/05/05/pngquant)
# Author
yKesamaru
# License
MIT license  
  
それ以外のライセンス  
- Positive.ogg: [Nathaniel McCallum](https://launchpad.net/ubuntu/bionic/+source/ubuntu-sounds/+copyright)
  - Creative Commons Attribution-ShareAlike License
  - /usr/share/sounds/ubuntu/notifications/  
# Github
[![yKesamaru/movie2gif - GitHub](https://gh-card.dev/repos/yKesamaru/movie2gif.svg?fullname=)](https://github.com/yKesamaru/movie2gif)