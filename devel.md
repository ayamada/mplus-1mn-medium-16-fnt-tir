このファイルには、自分用の生成手順を書きます。


# 同梱スクリプトについて

後述の各変換については、同じディレクトリ内にある `*.scm` を使う。要gosh。以下は概要。

- char-tally.scm
    - `cat hoge.txt | ./char-tally.scm > hoge.tsv` のように使う
    - これを実行する事により、 `hoge.txt` に含まれる全文字種について、出現数でカウント後ソートした結果をtsv形式で出力する。
    - 後述の `jawiki-chars.tsv` を生成する為のオプション(`+chado`)あり。

- jawiki-tally.scm
    - `cat kanji.chars | ./jawiki-tally.scm > kanji.tally` のように使う
    - これを実行する事により、 `kanji.chars` に含まれる全文字種について、後述の `jawiki-chars.tsv` に記載されているカウント値順でソートした結果をtally形式(=tsv形式)で出力する(つまりチャドー/jawiki頻度順に文字がソートされる)。

- tally2chars.scm
    - `cat kanji.tally | ./tally2chars.scm > kanji.chars` のように使う
    - これを実行する事により、tally形式(=tsv形式)のファイルから、文字種だけを取り出す。

- extra-unicode.scm
    - `./extra-unicode.scm > extra-utf8.chars` のように使う
    - extra-unicode.scm 内部で保持しているunicode固有文字をutf-8として書き出す


# jawiki-chars.tsvの生成

ここでは、各文字種の評価基準データとなるjawiki-char.tsvの生成方法を解説する。

`work/chars/` ディレクトリ内にて作業を行う事を想定している。

- jawiki-char.tsvファイルは「文字」「カウント値」の二値を持つtsvファイル。カウント値が高い程優先順位が高い。

まず事前に、チャドーおよびja-wikipediaのデータファイルを用意する。

- チャドーは、 https://twitter.com/njdict_Chado にて配布されている物に含まれている中から「忍殺語辞書」内の「chado.csv」を取得し、 **文字コードをUTF-8に変換しておく** (オリジナルはShift_JISの為)。この際に、ファイル名は「chado.csv」のままにしておく事。
- ja-wikipediaは http://dumps.wikimedia.org/jawiki/latest/ より「jawiki-latest-pages-articles.xml.bz2」を取得しておく(サイズが大きいので注意)。
    - ※サイズに要注意。

上記二つのファイルのあるディレクトリにて、 `bzcat jawiki-latest-pages-articles.xml.bz2 | ./char-tally.scm +chado > jawiki-chars.tsv` を実行する事で、 `jawiki-chars.tsv` が生成される。


# 文字一覧ファイルの生成

以下の手順で、 `work/chars/` 内にあるファイルを使い、
最終的に`page1.txt` `page2.txt` を生成する。

~~~
JIS第一水準の内、漢字以外の文字
↓
jis1-misc.chars (ソースファイル)
↓
↓ 追加のUnicode記号類のコード表現
↓ ↓
↓ extra-unicode.scm (ソースファイル)
↓ ↓
↓ utf-8実体に変換
↓ ./extra-unicode.scm > extra-utf8.chars
↓ ↓
↓ extra-utf8.chars
↓ ↓
二つのファイルを結合
cat jis1-misc.chars extra-utf8.chars > page1-misc.chars
↓
page1-misc.chars
↓
↓ JIS第一水準の内、漢字のみを集めたもの
↓ ↓
↓ jis1-kanji.chars (ソースファイル)
↓ ↓
↓ ↓ JIS第二水準の漢字全部
↓ ↓ ↓
↓ ↓ jis2.chars (ソースファイル)
↓ ↓ ↓
↓ ↓ 漢字優先順位順にソート
↓ ↓ cat jis2.chars | ./jawiki-tally.scm > jis2.tally
↓ ↓ ↓
↓ ↓ jis2.tally
↓ ↓ ↓
↓ ↓ ソート結果から、10カウント以上のもののみを残す
↓ ↓ (vim等のエディタを使い、手で編集)
↓ ↓ ↓
↓ ↓ jis2-over10.tally
↓ ↓ ↓
↓ ↓ カウント情報を削除し文字だけにする
↓ ↓ cat jis2-over10.tally | ./tally2chars.scm > jis2-over10.chars
↓ ↓ ↓
↓ ↓ jis2-over10.chars
↓ ↓ ↓
↓ 二つのファイルを結合する
↓ cat jis1-kanji.chars jis2-over10.chars > kanji.chars
↓ ↓
↓ kanji.chars
↓ ↓
↓ 漢字優先順位順にソート
↓ cat kanji.chars | ./jawiki-tally.scm > kanji.tally
↓ ↓
↓ kanji.tally
↓ ↓
↓ 上位2275文字と、その残りの、二つに分割する
↓ (ここが1024x1024に収まるギリギリのライン)
↓ (vim等のエディタを使い、手で分割)
↓ ↓                 ↓
↓ kanji-major.tally  kanji-minor.tally
↓ ↓                 ↓
↓ カウント情報を削除し文字だけにする
↓ cat kanji-major.tally | ./tally2chars.scm > kanji-major.chars
↓ cat kanji-minor.tally | ./tally2chars.scm > kanji-minor.chars
↓ ↓                 ↓
↓ kanji-major.chars  kanji-minor.chars
↓ ↓                 ↓
↓ ↓                 ページ2はこれで完成
↓ ↓                 cat kanji-minor.chars > page2.txt
↓ ↓                 ↓
↓ ↓                 page2.txt
↓ ↓
二つのファイルを結合して、ページ1も完成
cat page1-misc.chars kanji-major.chars > page1.txt
↓
page1.txt

(optional)page1とpage2に分割する必要がない場合は直にresult.txtを生成してもよい
cat page1.txt page2.txt > result.txt
もしくは
cat page1-misc.chars kanji.chars > result.txt
~~~

改善案:

- 上記ではjis2より9カウント以下を削除しているが、これを99カウントにする事を考慮する
    - 広大なwikipedia中に99文字しか使われていないなら、ゲームでもまず使わないと思われる為
        - 実際に99カウント以下の漢字全てを簡単に確認した結果、使う可能性があると思ったのは以下ぐらい
            - 蜊(あさり): カウント値48
            - 忸怩(じくじ): カウント値56,56
            - 鱚(キス): カウント値56
            - 馘(クビ): カウント値80
            - 鼾(いびき): カウント値84
            - 塒(ねぐら): カウント値86
            - 毟(むし(る)): カウント値88
            - 鮟鱇(アンコウ): カウント値100,91
    - 100カウント以上では、ぼちぼち「これ使いたい場合あるかもなあ」という漢字が出現し始める
        - しかしまず使わない漢字の方が圧倒的に多いので、また目視確認してホワイトリスト方式で分離するのがベストだと思う。問題は結構な量がある事…


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
    - 一致していない場合はheight, y, yoffsetをいじって合わせる事。
        - Mのheightを増やさなくてはならない場合、その変動量の半分ずつyとyoffsetを減らす(つまり元の状態から、Mの上下の空白領域を多めにコピーさせるようにして調整している)。変動量が奇数で割り切れない場合は小数切り捨てで両方合わせればよい。
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
    - 現状ではid=8800("≠")がこの問題を持っている。とりあえず現時点では、id=8800は、id=8225("‡")で代用するように修正を行う事。
    - またid=35569("諱")もこの問題を持つ。この文字は、現時点ではまだM+側で未対応の文字のようなので、「エントリを削除する」方向で対応する事。
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


