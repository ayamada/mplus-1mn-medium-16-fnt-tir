#!/usr/bin/env gosh
;;; coding: utf-8
;;; -*- scheme -*-
;;; vim:set ft=scheme ts=8 sts=2 sw=2 et:


(define *chars*
  '(
    ;; 0.0.2 2014/03/06
    #\u2661 ; アウトラインハート
    #\u2665 ; ぬりつぶしハート
    ;; 1.0.0 2014/04/20
    #\u00a5 ; 半角\記号
    ;; 1.1.0 2014/06/18
    ;; came from http://d.hatena.ne.jp/y-kawaz/20101112/1289554290
    #\u002D ; HYPHEN-MINUS
    #\u00AD ; SOFT HYPHEN
    #\u2011 ; NON-BREAKING HYPHEN
    #\u2012 ; FIGURE DASH
    #\u2013 ; EN DASH
    #\u2043 ; HYPHEN BULLET
    #\uFE63 ; SMALL HYPHEN-MINUS
    #\u2212 ; MINUS SIGN
    #\u207B ; SUPERSCRIPT MINUS
    #\u208B ; SUBSCRIPT MINUS
    #\uFF0D ; FULLWIDTH HYPHEN-MINUS
    #\u2500 ; BOX DRAWINGS LIGHT HORIZONTAL
    #\u2501 ; BOX DRAWINGS HEAVY HORIZONTAL
    #\u005F ; LOW LINE
    #\uFF3F ; FULLWIDTH LOW LINE
    #\u00AF ; MACRON
    #\u203E ; OVERLINE
    #\uFFE3 ; FULLWIDTH MACRON
    #\u2014 ; EM DASH
    #\u2015 ; HORIZONTAL BAR
    #\u30FC ; KATAKANA-HIRAGANA PROLONGED SOUND MARK
    #\u007E ; TILDE
    #\u223C ; TILDE OPERATOR
    #\u223E ; INVERTED LAZY S
    #\u301C ; WAVE DASH
    #\u3030 ; WAVY DASH
    #\uFF5E ; FULLWIDTH TILDE
    #\u2026 ; HORIZONTAL ELLIPSIS
    #\u22EF ; MIDLINE HORIZONTAL ELLIPSIS
    #\u00B7 ; MIDDLE DOT
    #\u2022 ; BULLET
    #\u2219 ; BULLET OPERATOR
    #\u22C5 ; DOT OPERATOR
    #\u30FB ; KATAKANA MIDDLE DOT
    #\uFF65 ; HALFWIDTH KATAKANA MIDDLE DOT
    ))

(define (main args)
  (for-each
    (lambda (char)
      (write-char char)
      (newline))
    *chars*))



