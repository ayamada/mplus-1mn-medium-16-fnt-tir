#!/usr/bin/env gosh
;;; coding: utf-8
;;; -*- scheme -*-
;;; vim:set ft=scheme ts=8 sts=2 sw=2 et:

(define *tally* (make-hash-table 'eq?))

(define (reset-tally!)
  (hash-table-clear! *tally*))

(define (tally-charlist! score)
  (let1 char (read-char)
    (unless (eof-object? char)
      ;(write-char char)
      ;(newline)
      (hash-table-update! *tally* char (cut + score <>) 0)
      (tally-charlist! score))))

(define (display-result!)
  (for-each
    (lambda (k+v)
      (let ((key (car k+v))
            (val (cdr k+v)))
        ;; tab、改行、空白を含む制御文字はスキップする
        ;; (#x20以前をスキップする)
        (when (< 32 (char->integer key))
          (write-char key)
          (write-char #\tab)
          (print val))))
    (reverse (sort-by (hash-table->alist *tally*) cdr))))

(define (main args)
  (reset-tally!)
  (tally-charlist! 1)
  (when (find (cut equal? <> "+chado") args)
    (with-input-from-file
      "./chado.csv"
      (lambda ()
        (tally-charlist! 10000))))
  (display-result!))



