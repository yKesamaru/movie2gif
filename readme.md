# MOVIE2ANIMATION_GIF
同じディレクトリに存在するmp4ファイルからアニメーションgifファイルを作成します。  
5fps, 横幅600pxに調整します。  
# Requirements
- ffmpeg
- imagemagick
- pngquant
- paplay
- notify-send
# Setting
- FPS=5
  - ffmpeg
- WIDTH=600
  - mogrify
- POSTERIZE=4
  - pngquant, 削減ビット数最大値
- QUALITY=0-5
  - pngquant, 最低0-100
# Reference
- [pngquant](https://pngquant.org/)公式
- [Icon Naming Specification](https://specifications.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html)
- [【Zenn】github用のアニメーションgifまわりあれこれ](https://zenn.dev/ykesamaru/articles/52653d248e854d)
- [【じーろぐ】減色ツールPngquantの仕組みと最適パラメータを探る](https://zlog.hateblo.jp/entry/2019/05/05/pngquant)
# Author
yKesamaru
# License
MIT license  
  
以下それぞれのライセンス  
- mark_heart.png いらすとや様  
- Positive.ogg /usr/share/sounds/ubuntu/notifications/  