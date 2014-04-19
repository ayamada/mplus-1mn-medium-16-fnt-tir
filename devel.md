このファイルには、自分用の生成手順を書きます。


# 文字一覧ファイルの生成

以下の手順で、 `work/chars/` 内にあるファイルを使い、
最終的に`page1.txt` `page2.txt` を生成する。

それぞれの変換については、同じディレクトリ内にある `*.scm` を使う。要gosh。

(どれも `cat src.file | ./hoge.scm > new.file` みたいに使う)

~~~
JIS第一水準の内、漢字以外の文字 ＋ 追加のUnicode記号類
↓
page1-misc.chars (ソースファイル)
↓
↓ JIS第一水準の内、漢字のみを集めたもの
↓ ↓
↓ jis1-kanji.chars (ソースファイル)
↓ ↓
↓ ↓ JIS第二水準の漢字全部
↓ ↓ ↓
↓ ↓ jis2.chars (ソースファイル)
↓ ↓ ↓
↓ ↓ Wikipediaカウント順にソート
↓ ↓ ↓
↓ ↓ jis2.tally
↓ ↓ ↓
↓ ↓ ソート結果から、10カウント以上のもののみを残す
↓ ↓ ↓
↓ ↓ jis2-over10.tally
↓ ↓ ↓
↓ ↓ カウント情報を削除し文字だけにする
↓ ↓ ↓
↓ ↓ jis2-over10.chars
↓ ↓ ↓
↓ 二つのファイルを結合する
↓ ↓
↓ kanji.chars
↓ ↓
↓ Wikipediaカウント順にソート
↓ ↓
↓ kanji.tally
↓ ↓
↓ 8500カウント以上とそれ以外で、二つに分割する
↓ (ここが1024x1024に収まるギリギリのライン)
↓ ↓                 ↓
↓ kanji-major.tally  kanji-minor.tally
↓ ↓                 ↓
↓ カウント情報を削除し文字だけにする
↓ ↓                 ↓
↓ kanji-major.chars  kanji-minor.chars
↓ ↓                 ↓
↓ ↓                 ページ2はこれで完成
↓ ↓                 ↓
↓ ↓                 page2.txt
↓ ↓
二つのファイルを結合して、ページ1も完成
↓
page1.txt
~~~


# 加工前fntファイルとテクスチャの作成

[Hiero](https://github.com/libgdx/libgdx/wiki/Hiero)を使う。

- Hieroはwindows上で動かす事。
    - macで動かした場合、文字の位置が微妙に(0.5ドット分ぐらい)ガタガタになり、
      微妙に見栄えが悪くなってしまった。原因は分からない。

前準備として、 `M+ 1m medium` をシステムにインストールしておくとよい。

(直指定でも問題ないが、インストールしておけば毎回フォントを選択しなくてすむ)

1. 以下のパラメータを設定する。
    - Font: M+ 1m medium
        - Size: 16
        - Rendering: Java
    - Sample Text:
        - `page1.txt` を、utf-8完全なアプリで開いてコピペする。
            - windows版のvimは不可！
            - chromeあたりで開いてコピペするのが安全
    - Rendering:
        - Glyph cache: ●
        - Page width: 1024
        - Page height: 1024
    - Effects:
        - Color: 白
        - Distance field:
            - Color: 白
            - Scale: 16
            - Spread: 1.2
    - Padding:
        - 上: 2
        - 左: 2
        - 右: 1
        - 下: 1
        - X: 0
        - Y: 0
2. ※「Reset Cache」ボタンを必ず押す。
    - これを押し忘れると文字の並びが最適化されないので必ず押す事！
3. 「Rendering」項目内の「Pages」の値が1になっている事を確認する。
    - もしこれが2になっている場合、1024x1024に収まらなくなっている。
4. メニューの「File」→「Save BMFont files」で、
   `mp1mm16tir-page1.fnt` として保存する。
5. 一旦ここでHieroを再起動してもよい。
6.  「Sample Text」のところに `page2.txt` の内容をコピペする。
    - (5)にてHieroを再起動した場合は、他のパラメータも同様に設定し直す事。
7. ※「Reset Cache」ボタンを必ず押す。
8. 「Rendering」項目内の「Pages」の値が1になっている事を確認する。
9. メニューの「File」→「Save BMFont files」で、
   `mp1mm16tir-page2.fnt` として保存する。


# fntファイルの加工

特に断りがない場合は、 `mp1mm16tir-page1.fnt` と `mp1mm16tir-page2.fnt`
の両方に内容を適用する事。

1.  info行の修正。 unicode=1 にする
2.  common行の修正。 lineHeight=18 base=16 にする
    - lineHeightは文字高さ＋行間。baseは文字高さ(漢字基準)。
3.  (※page1のみ) char id=77 の「M」のエントリをチェック。height値が文字高さである16に完全一致している事を確認する
    - レンダリングエンジンにもよるが、「M」のheight値が一行だけの時の高さとして採用されるので、これが一致していないとbounds判定がおかしくなる。
4.  (※page1のみ) char id=12288の全角空白のエントリを追加し、chars countの値を1増やす。エントリ内容は以下をコピペ。
    - `char id=12288   x=0     y=0     width=0     height=0     xoffset=0     yoffset=0    xadvance=19     page=0  chnl=0 `
5.  (※page2のみ) char id=32を除去し、chars countの値を1減らす
6.  `cat *.fnt | perl -lne 'print $1 if $_ =~ /xadvance\=(\d+)/'|sort|uniq -c` を実行し、xadvanceの値を確認する。半角文字が全て11、全角文字が全て19になっていればok。11でも19でもない値がある場合は要修正。
    - おかしい値がある時の原因は、os(java)による変換ミス、フォント側の設定ミス、フォント側に対応文字がなくて代替文字になっている、等が考えられる。とりあえず `*.fnt` ファイルをエディタで開き、 `xadvance=??` で検索して問題のエントリを探す事。問題のエントリを発見したら以下の処理を行う。
        - id値をどこかにメモしておき、Unicode表を検索し、本来の文字がどれなのかを調べる
        - 「他の文字で代用する」か「エントリごと削除する」か「この文字のまま対応する」かを決める
            - 「他の文字で代用する」場合は、代用する文字のエントリをコピペして上書きし、id値だけ変更すればok
            - 「エントリごと削除する」場合は、該当行を普通に削除してから、chars countの値を1減らす
            - 「この文字のまま対応する」場合は、以下の修正を行う
                - 本来の文字の横幅に合わせて、xadvanceの値を11(半角)もしくは19(全角)に設定する
                - 上記のxadvanceの変動値の半分の量を、xoffsetにも適用する(これを忘れると文字がずれる)
7.  ここまでできたら、一旦 `*.fnt` のバックアップを取っておく
8.  `script/filter.pl` をエディタで開き、「xadvanceの値を3減らし、xoffsetの値を0減らし、yoffsetの値を4減らす」コメント部を有効にし、それぞれの `*.fnt` に適用する。
    - このxoffset値とyoffset値は調整の余地がある
9.  ここまで加工した `mp1mm16tir-page1.fnt` を、libgdxで実際に表示してみて、文字にずれ等がないかを確認する。チェックポイントは以下の通り。
    - 文字毎に位置がまちまちになってないか
        - macでHieroを動かした場合、何故かまちまちになっていた
    - 実際のbounds矩形に対して、文字の上下左右の間隔がきちんと均等になっているかどうか
        - 均等になっていない場合は、filter.pl内の値を調整して、再度バックアップからやり直す
10. (※page2のみ) filter.plを使い、page2内の全文字にpage=1を設定する。
11. `mp1mm16tir-page1.fnt` と `mp1mm16tir-page2.fnt` を結合し、 `mp1mm16tir.fnt` という新しいファイルを生成する。結合元のファイルはそのままの状態で残しておく事。結合した `mp1mm16tir.fnt` には以下の修正を行う。
    - info行、common行、chars行、kernings行は一つだけでよい
    - common行の`pages`を`2`に修正する事
    - page行は二行必要。この二つあるpage行の内、page2から来た方の行は`id=1`に修正する事
    - char行の数をカウントし、chars行に、行数から1減らした値を設定し直す
12. `mp1mm16tir.fnt` を実際に表示させ、確認を行う。チェックポイントは以下の通り。
    - ここまでに処理忘れがないかどうか
    - page2の文字もきちんと正しく表示されるかどうか
13. 問題がなければ、バックアップおよび `mp1mm16tir-page2.fnt` を削除し、以下のファイルだけを残して完成。
        - `mp1mm16tir.fnt`
        - `mp1mm16tir-page1.fnt`
        - `mp1mm16tir-page1.png`
        - `mp1mm16tir-page2.png`

