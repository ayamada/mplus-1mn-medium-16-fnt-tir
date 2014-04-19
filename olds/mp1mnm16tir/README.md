これは旧版です。


# mplus-1mn-medium-16-fnt-tir

A Bitmap font contains japanese characters


## これは何？

- 一部のゲーム系ライブラリ/エンジンで採用されている、
  「fnt」形式のビットマップフォントです。
    - 「fnt」形式のフォントについては、ayamadaがまとめた文書が
      http://doc.tir.ne.jp/devel/clan/libgdx#bitmapfont にあります。


## どんなフォント？

- [M+ OUTLINE FONTS](http://mplus-fonts.sourceforge.jp/mplus-outline-fonts/index.html)の「M+ 1mn medium」をビットマップ化して生成しています。

- 半角8x16px、全角16x16px、行間2pxの等幅フォントです。
    - 文字領域としては間違いなく上記通りの等幅ですが、領域をはみ出して
      描画する文字が一部あります(罫線および一部のアルファベット等)。

- Distance field処理済の為、拡大した際も綺麗に表示されます。
    - Distance fieldの詳細についてはぐぐってください。
        - 「おっさんなのに、薄目で見ると女の人に見える画像」を知ってますか、それと同じ仕組みです。知らなくても「拡大時に文字が綺麗に表示されるもの」という理解でokです。
    - filterがNearestの場合は微妙です。Linear推奨です。

- いわゆるJIS第一水準の範囲の文字を含み、更にayamadaが必要に応じて取捨選択を行っています。
    - 詳細な範囲については後述します。
    - 半角カナは含めていません。

- 1024x1024のテクスチャになっています。

- http://doc.tir.ne.jp/devel/clan/libgdx#bitmapfont にある、
  各種のチューニングが行われている為、快適に日本語表示が可能です。

- 実際のフォントの見た目については、
  [mp1mnm16tir.png](https://raw.github.com/ayamada/mplus-1mn-medium-16-fnt-tir/master/olds/mp1mnm16tir/mp1mnm16tir.png)
  を普通に画像ビューアで開いて確認してください。
    - 背景透過で文字色が白なので、確認の際は背景を黒系にしてください。


## 使い方

- 同梱の `mp1mnm16tir.fnt` と `mp1mnm16tir.png` をリソースに含め、
  ロードするフォントに `mp1mnm16tir.fnt` を指定するだけです。
    - 詳細については利用しているライブラリやゲームエンジンのリファレンスを
      参照してください。


## 含まれている文字について

- [mp1mnm16tir_chars.txt](https://raw.github.com/ayamada/mplus-1mn-medium-16-fnt-tir/master/olds/mp1mnm16tir/mp1mnm16tir_chars.txt) に一覧があります。約3500文字。


## 既知の問題点

- Distance field加工部分が微妙に見切れている文字種が何個かある
    - よく見ないとまず気付かないレベル
    - 1024x1024に無理に全部詰め込もうとしたのが原因

- 半角の￥記号である165(`U+00A5`)が抜けている


## 更新履歴

- 0.0.2 : 2014/03/06
    - 「壺」の一番上の1ドット分の列が表示されていなかった問題を修正
    - utf-8ハート二種(9825と9829)、薔、薇、鬱、の五文字を追加
    - mp1mnm16tir_chars.txt (文字種一覧ファイル)を追加

- 0.0.1 : 2014/03/06
    - githubにて公開開始

- 0.0.0 : 2013/??/??
    - utf-8の「￣」(65507の`FULLWIDTH MACRON`)が不正だったのを修正
    - 罫線回りのサイズがおかしかったのを修正
    - 「壺」追加


## License

- ライセンスは元のM+フォントと同様とします。
    - http://mplus-fonts.sourceforge.jp/mplus-outline-fonts/index.html#license




