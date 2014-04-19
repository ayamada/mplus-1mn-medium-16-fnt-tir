<div align="center"><img src="https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir/raw/master/ss.png" /></div>


# mp1mm16tir

A bitmap font contains japanese characters


## これは何？

- 一部のゲーム系ライブラリ/エンジンで採用されている、
  「fnt」形式のビットマップフォントです。
    - 「fnt」形式のフォントについては、ayamadaがまとめた文書が
      http://doc.tir.ne.jp/devel/clan/libgdx#bitmapfont にあります。


## どんなフォント？

- [M+ OUTLINE FONTS](http://mplus-fonts.sourceforge.jp/mplus-outline-fonts/index.html)の「M+ 1m medium」(TESTFLIGHT 058)をビットマップ化して生成しています。
    - 当フォントも「M+ 1m medium」フォントの[ライセンス](http://mplus-fonts.sourceforge.jp/mplus-outline-fonts/index.html#license)をそのまま適用しているので、
      極めて自由に利用する事ができます。

- 半角8x16px、全角16x16px、行間2pxの等幅フォントです。
    - 文字領域としては間違いなく上記通りの等幅ですが、領域をはみ出して描画する文字が一部あります(罫線および一部のアルファベット等)。

- http://doc.tir.ne.jp/devel/clan/libgdx#bitmapfont にある、
  各種のチューニングが行われている為、快適に日本語表示が可能です。

- いわゆるJIS第一水準の範囲の文字全て、JIS第二水準の範囲の文字の大部分、
  一部のUnicode記号文字を含んでいます。
    - 詳細な範囲については後述します。
    - 半角カナは含んでいません。

- Distance field処理済の為、拡大した際も綺麗に表示されます。
    - Distance fieldの詳細についてはぐぐってください。
        - とりあえず「拡大時に文字が綺麗に表示されるもの」という理解でokです。
    - filterはLinear推奨です。Nearestだとそれなりです。

- 1024x1024のテクスチャ二枚構成になっています。
    - Wikipedia本文データファイルより漢字別に出現カウントを行い、
      出現頻度の高いものをテクスチャ一枚目に集める事で、
      描画コストの軽減をしています。

- 実際のフォントの見た目については、
  [fnt/](https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir/tree/master/fnt)
  ディレクトリ内にある`*.png`を、普通に画像ビューアで開いて確認してください。
    - 背景透過で文字色が白なので、確認の際は背景を黒系にしてください。
      背景が白系だと見えません。


## 使い方

- 通常版
    - [fnt/](https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir/tree/master/fnt) ディレクトリより、
      `mp1mm16tir.fnt` `mp1mm16tir-page1.png` `mp1mm16tir-page2.png`
      の三つのファイルをリソースに含め、
      ロードするフォントとして `mp1mm16tir.fnt` を指定してください。
      また、このフォントのテクスチャにはLinearフィルタを指定してください。
    - 指定方法の詳細については、
      利用しているライブラリやゲームエンジンのリファレンスを参照してください。

- page1版
    - [fnt/](https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir/tree/master/fnt) ディレクトリより、
      `mp1mm16tir-page1.fnt` `mp1mm16tir-page1.png`
      の二つのファイルをリソースに含め、
      ロードするフォントとして `mp1mm16tir-page1.fnt` を指定してください。
      また、このフォントのテクスチャにはLinearフィルタを指定してください。
    - 通常版とは違い、page2に含まれている文字を描画する事はできませんが、
      使用リソース量を減らす事ができます。


## 含まれている文字について

現在のところ、通常版で約5200文字、page1版で約2900文字が含まれています。

- 以下の基準で文字を選抜しています。
    - JIS第一水準の全て
    - JIS第二水準の内、Wikipedia本文データファイルより漢字別に出現カウントを行い、出現数が10カウント以上のもので、かつ「M+ 1m medium」に文字のあるもの
    - 一部のUnicode記号
        - 現在のところはハート二種と「&#165;」(半角の￥)のみ

- 以下の基準で、page1とpage2に分割しています。
    - page1
        - Unicode記号類
        - JIS第一水準の内の、漢字を除外した残り全て
        - 上記の選抜での全漢字の内、Wikipedia出現頻度8500カウント以上の2275文字
    - page2
        - page1に含まれなかった、残り漢字全部

- 実際に登録されている文字の詳細な一覧については、
  [work/chars/](https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir/tree/master/work/chars)
  内の `page1.txt` および `page2.txt` にあります。
    - ただし、 `page2.txt` ファイルの方には、
      「M+ 1m medium」にまだ登録されていないJIS第二水準漢字も含まれています。
      それらについては当然、実際のフォントにも含まれていません。
      この点にだけ注意してください。


## おねがい

- ayamadaは
  [libgdx](http://libgdx.badlogicgames.com/)
  にて表示の動作確認を行っており、
  libgdx以外のゲームエンジン等では動作の確認が取れていません。
  もし問題があれば、
  [Issues](https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir/issues)
  にてフィードバックをいただけるとありがたいです。


## FAQ

- 不具合、ミス等を発見した
    - [Issues](https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir/issues)
      より連絡ください。日本語でokです。

- 各文字の優先度がWikipediaデータ内出現頻度って微妙じゃない？
    - 自分もそう思います。
      しかし手軽にスクレイピングできる、
      ゲーム向きのまとまったテキストデータは他にはなさそうだったので、
      現状はWikipediaデータを利用しています。
      おすすめのデータソースがあれば教えてください。

- あの漢字はpage2じゃなくpage1に入れてほしい
    - 文字数が膨大で一個ずつは管理しきれない為、個別対応は諦めてください。
      どうしても対応してほしい場合は、前述の、Wikipediaに代わる、
      適切なデータソースを探してきてください。
      それによっては対応します。

- なんでフォントを1mnから1mに変更したの？
    - 1mnは「&#165;」(半角￥記号)の横棒が一本足りないのが気に入らなかったからです。
      それ以外の字形については1mよりも1mnの方が良かったんですが。

- フォントを1mnから1mに変更したんだから、リポジトリ名も変えた方がいいんじゃ？
    - 今後、更にまた別のフォントに変更したり、
      複数のフォントを扱う事にする可能性があるので、当分はこのままにします。
    - なお、リポジトリ名を変更する時も、
      forkによって別のリポジトリを作成する形にして、
      元のリポジトリのURLは残しておくつもりです(リンク切れにならないように)。

- [migu](http://mix-mplus-ipa.sourceforge.jp/migu/)フォントはどう？
    - フォントとしては非常に良好ですが、
      IPAフォントライセンスが付いてるので駄目です。
        - IPAフォントライセンスはライセンス文の表示義務があるので、
          ゲームへの組み込み用途には色々と面倒です。

- 実際の生成手順を教えてほしい
    - 自分用の生成手順メモが
      [devel.md](https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir/tree/master/devel.md)
      にあります。


## 既知の問題点

- 「≠」が「‡」になっている
    - フォント生成に利用している
      [Hiero](https://github.com/libgdx/libgdx/wiki/Hiero)
      にて、M+の等幅系フォントはどれも、
      「≠」の所属するUnicodeのmathematical operators系文字が、
      正しくレンダリングされないのが根本の原因です。
        - M+でもプロポーショナル系フォントでは正しくレンダリングされる。
          またM+の等幅系フォントでも、
          Hieroのテキスト入力欄に入力した内容はきちんとそのフォントで
          「≠」が表示されている。レンダリングだけがおかしい。
          M+側の持つパラメータの何かが原因になっていそうな雰囲気だが…。
    - とりあえずの代わりとして、「≠」と幅が同じ文字の内、
      一番形が似ている「‡」を表示させておく事にしました。
      これが、「≠」が「‡」になっている事の理由です。


## TODO

- ゲームでよく使う、utf-8記号文字をもっと追加する予定
    - どれを入れるべきか検討中


## 更新履歴

- 1.0.0 : 2014/04/20
    - ベースフォントを「M+ 1mn medium」から
      「M+ 1m medium」(TESTFLIGHT 058)に変更
    - テクスチャを1024x1024二枚に増量
    - Distance field効果のSpread値を1.1から1.2に増量
    - テクスチャ内での文字間隔を以前よりも大きく取るようにする
    - テクスチャに含める文字の選択を、
      Wikipediaデータ内での出現頻度によって決定するようにする
    - Unicode記号枠に「&#165;」165(`U+00A5`) を追加
    - 一時的に、「≠」の代わりに「‡」を表示させる

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


## 旧版

- [mp1mnm16tir](https://github.com/ayamada/mplus-1mn-medium-16-fnt-tir/tree/master/olds/mp1mnm16tir)
    - 「M+ 1mn medium」ベースの旧版フォント。1024x1024一枚のテクスチャにJIS第一水準全部を無理矢理詰め込んでいる。
    - サイズ制約により、`mp1mm16tir`のpage1版はJIS第一水準全部が含まれている訳ではない為、あえて旧版を選ぶケースがあるかもしれないので、残しておく事にした。


## License

- このフォントのライセンスは、元のM+フォントと同様とします。
    - http://mplus-fonts.sourceforge.jp/mplus-outline-fonts/index.html#license




