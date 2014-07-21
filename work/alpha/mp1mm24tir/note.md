# mp1mm24tir

これは試作品です。


## 概要

元のmp1mm16tirから、以下の点が変更されています。

- フォントサイズを24px、行間を4pxとしました。
- テクスチャサイズを2048x2048としました。
- wikipediaカウント値が100以上の漢字のみを含むようにしました(これまでは10以上だった)。
- Distance field部の色を黒に変更し、アウトラインを兼ねさせる事で可読性を向上させました。

上記の変更点のいくつかは、mp1mm16tirにもback portする予定です。


## スクリーンショット

<img src="https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir/raw/master/work/alpha/mp1mm24tir/ss.png" />

(確認の為だけに無理矢理差し換えたので表示がずれている部分がありますが、そこは気にしないでください)


## 使う

- [/work/alpha/mp1mm24tir/](https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir/tree/master/work/alpha/mp1mm24tir/) ディレクトリより、`mp1mm24tir.fnt`と`mp1mm24tir.png`の二つのファイルを使ってください。


## 生成手順

これは自分用メモです。

1. 文字種ファイルとして、`result.txt`を生成しておく
2. Hieroを起動し、fntを生成する。これまでのパラメータとは以下が違う。
    - Sample Text: `result.txt`より、chromeあたり経由でコピペ
    - Size: 24
    - Page width: 2048
    - Page height: 2048
    - Effects:
        - Distance field:
            - Color: 黒
            - Spread: 1.5
        - Color: 白
            - ※「Distance field」の方が「Color」よりも上に来るようにする事。この順序が逆だと真っ黒になってしまう。
    - 上記で指示していないパラメータは、これまでと同様の値を設定する事
3. fnt編集
    - common行は、lineHeight=28 base=24
    - id=12288のxadvanceは27
    - id=77のheight, y, yoffsetの修正が必要
    - filter.plの適用値は3,0,6(つまりyoffset変動量が元の24/16倍に)
4. 既存ゲームのフォントを差し換えて動かし、目で見て検証




