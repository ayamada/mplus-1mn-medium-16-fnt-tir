# mplus-1mn-medium-16-fnt-tir

Bitmap font contains japanese characters


## これは何？

- 多くのゲーム系ライブラリ/エンジンで採用されている、
  「fnt」形式のビットマップフォントです。
    - 「fnt」形式のフォントについては、ayamadaがまとめた文書が
      http://doc.tir.ne.jp/devel/clan/libgdx#bitmapfont にあります。


## どんなフォント？

- [M+ OUTLINE FONTS](http://mplus-fonts.sourceforge.jp/mplus-outline-fonts/index.html)の「M+ 1mn medium」をベースにしています。

- 半角8x16、全角16x16の等幅フォントです。
    - Distance field処理済の為、拡大縮小しても綺麗に表示されます。
        - Distance fieldの詳細についてはぐぐってください。
          「とりあえず文字が綺麗に表示されるもの」という理解でokです。
    - 文字領域としては間違いなく上記通りの等幅ですが、領域をはみ出して
      描画する文字が一部あります(罫線および一部のアルファベット等)。

- jis1の範囲の文字を含み、更にayamadaが必要に応じて取捨選択を行っています。
    - 詳細な範囲については後述します。

- 1024x1024のテクスチャになっています。

- http://doc.tir.ne.jp/devel/clan/libgdx#bitmapfont にある、
  各種のチューニングが行われている為、快適に日本語表示が可能です。

- ライセンスは元のM+フォントと同様とします。
    - http://mplus-fonts.sourceforge.jp/mplus-outline-fonts/index.html#license


## 使い方

- 同梱の `mp1mnm16tir.fnt` と `mp1mnm16tir.png` をリソースに含め、
  ロードするフォントに `mp1mnm16tir.fnt` を指定するだけです。
    - 詳細については利用しているライブラリやゲームエンジンのリファレンスを
      参照してください。


## 含まれている文字について

- http://legacy.e.tir.jp/fnt_japanese_chars.txt に一覧があります。約3500文字。
    - jis1の範囲＋「壺」となっています。
        - jis1の方にある壺は「壷」で、こちらも残してある(将来は統合するかも)


## 文字の抜け、ミス等を発見したら

- githubのissueより連絡ください。日本語でokです。
    - ただし、文字の追加要望については、テクスチャの空き領域の残りが少ない為、
      ayamadaによる利用頻度判断によっては追加を断る場合があります。


## おねがい

- このフォントを利用して何かを作った場合、
  [vnctstサイト内の紹介ページ](http://vnctst.tir.jp/ja/materials/mplus-1mn-medium-16-fnt-tir.html)
  もしくは
  [githubのプロジェクトページ](https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir)
  にリンクを貼るか、「利用フォント」として「mplus-1mn-medium-16-fnt-tir」を
  明記してもらえるとうれしいです。明記する場所はスタッフロール等で構いません。
    - これはあくまで「おねがい」であり、無視しても別にペナルティ等はありません
      (ayamadaからの心証は悪くなるかも知れませんが)。


## TODO

- ゲームでよく使う、ハート等のutf-8記号文字の一部を追加する予定


## 更新履歴

- 0.0.1 : 2014/03/06
    - githubにて公開開始

- 0.0.0 : 2013/??/??
    - utf-8の「￣」(全角トップバー)が正しく割り当てられていない問題を修正
    - 罫線回りのサイズがおかしかったのを修正
    - 「壺」追加




