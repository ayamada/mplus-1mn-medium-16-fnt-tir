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

(define (args-has? args key)
  (find (cut equal? <> "+chado") args))

(define (get-chado-chars)
  (with-input-from-file
    "./chado.csv"
    (lambda ()
      ;; TODO: flatten処理の外出し
      (let1 table (make-hash-table 'equal?)
        (let loop ()
          (let1 c (read-char)
            (if (eof-object? c)
              (list->string (hash-table-keys table))
              (begin
                (hash-table-put! table c #t)
                (loop)))))))))

(define (get-whitelist-chars)
  ;; TODO
  "")

(define (get-blacklist-chars)
  ;; TODO
  "")

(define (main args)
  (reset-tally!)
  ;; wikipedia
  (tally-charlist! 1)
  ;; chado
  (when (args-has? args "+chado")
    (with-input-from-string
      (get-chado-chars)
      (lambda ()
        (tally-charlist! 10000))))
  ;; user's whitelist
  (when (args-has? args "+whitelist")
    (with-input-from-string
      (get-whitelist-chars)
      (lambda ()
        (tally-charlist! 20000))))
  ;; user's blacklist
  (when (args-has? args "+blacklist")
    (with-input-from-string
      (get-blacklist-chars)
      (lambda ()
        (tally-charlist! -1000000))))
  (display-result!))



