<div align="center"><img src="https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir/raw/master/ss.png" /></div>


# mplus-1mn-medium-16-fnt-tir

Bitmap font contains japanese characters


## これは何？

- 一部のゲーム系ライブラリ/エンジンで採用されている、
  「fnt」形式のビットマップフォントです。
    - 「fnt」形式のフォントについては、ayamadaがまとめた文書が
      http://doc.tir.ne.jp/devel/clan/libgdx#bitmapfont にあります。


## どんなフォント？

- [M+ OUTLINE FONTS](http://mplus-fonts.sourceforge.jp/mplus-outline-fonts/index.html)の「M+ 1mn medium」をビットマップ化して生成しています。

- 半角8x16、全角16x16の等幅フォントです。
    - Distance field処理済の為、拡大しても綺麗に表示されます。
        - Distance fieldの詳細についてはぐぐってください。
          「とりあえず文字が綺麗に表示されるもの」という理解でokです。
    - 文字領域としては間違いなく上記通りの等幅ですが、領域をはみ出して
      描画する文字が一部あります(罫線および一部のアルファベット等)。

- いわゆるJIS第一水準の範囲の文字を含み、更にayamadaが必要に応じて取捨選択を行っています。
    - 詳細な範囲については後述します。
    - 半角カナは含めていません。

- 1024x1024のテクスチャになっています。

- http://doc.tir.ne.jp/devel/clan/libgdx#bitmapfont にある、
  各種のチューニングが行われている為、快適に日本語表示が可能です。

- 実際のフォントの見た目については、
  [mp1mnm16tir.png](https://raw.github.com/ayamada/mplus-1mn-medium-16-fnt-tir/master/mp1mnm16tir.png)
  を普通に画像ビューアで開いて確認してください。
    - 背景透過で文字色が白なので、確認の際は背景を黒系にしてください。


## 使い方

- 同梱の `mp1mnm16tir.fnt` と `mp1mnm16tir.png` をリソースに含め、
  ロードするフォントに `mp1mnm16tir.fnt` を指定するだけです。
    - 詳細については利用しているライブラリやゲームエンジンのリファレンスを
      参照してください。


## 含まれている文字について

- [mp1mnm16tir_chars.txt](https://raw.github.com/ayamada/mplus-1mn-medium-16-fnt-tir/master/mp1mnm16tir_chars.txt) に一覧があります。約3500文字。
    - いわゆるJIS第一水準の範囲に追加分を加えています。追加分は時系列順に、末尾に追加されていきます。


## License

- ライセンスは元のM+フォントと同様とします。
    - http://mplus-fonts.sourceforge.jp/mplus-outline-fonts/index.html#license


## おねがい

- このフォントを利用して何かを作った場合、
  [vnctstサイト内の紹介ページ](http://vnctst.tir.jp/ja/materials/mplus-1mn-medium-16-fnt-tir.html)
  もしくは
  [githubのプロジェクトページ](https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir)
  にリンクを貼るか、「利用フォント」として「mplus-1mn-medium-16-fnt-tir」を
  明記してもらえるとうれしいです。明記する場所はスタッフロール等に限らず、
  どこでも構いません(目立たない片隅で良いです)。
    - これはあくまで「おねがい」であり、無視しても別にペナルティ等はありません
      (ayamadaからの心証は悪くなるかも知れませんが)。


## 文字の抜け、ミス等を発見したら

- githubのissueより連絡ください。日本語でokです。
    - ただし、文字の追加要望については、テクスチャの空き領域の残りが少ない為、
      ayamadaによる利用頻度判断によっては追加を断る場合があります。
        - その場合は自分で勝手に追加して利用してもらって何も問題ありません。
          リポジトリからのfork等でもokです。


## TODO

- ゲームでよく使う、utf-8記号文字の一部を追加する予定
    - とりあえずハート系は追加した。あとどれを入れるべきか検討中
- 「壺」と「壷」を、「壺」に統一すべきか検討


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




