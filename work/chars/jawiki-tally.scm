#!/usr/bin/env gosh
;;; coding: utf-8
;;; -*- scheme -*-
;;; vim:set ft=scheme ts=8 sts=2 sw=2 et:

(use file.util)


(define *dict-path* "./jawiki-chars.tsv")

(define *dict* (make-hash-table 'eq?))

(define (load-dict!)
  (for-each
    (lambda (line)
      (let1 m (#/^(.)\t(\d+)/ line)
        (when m
          (hash-table-put! *dict*
                           (string-ref (m 1) 0)
                           (x->integer (m 2))))))
    (file->string-list *dict-path*)))




(define *tally* (make-hash-table 'eq?))

(define (reset-tally!)
  (hash-table-clear! *tally*))

(define (tally-charlist!)
  (let1 char (read-char)
    (unless (eof-object? char)
      ;(write-char char)
      ;(newline)
      (let ((count (or (hash-table-get *dict* char 0))))
        (hash-table-put! *tally* char count))
      (tally-charlist!))))

(define (display-result!)
  (for-each
    (lambda (k+v)
      (let ((key (car k+v))
            (val (cdr k+v)))
        ;; tab、改行、空白を含む制御文字はスキップする
        ;; (#x20以前をスキップする)
        (when (< 32 (char->integer key))
          (write-char key)
          ;(newline)
          (write-char #\tab)
          (print val)
          )))
    (reverse (sort-by (hash-table->alist *tally*) cdr))))

(define (main args)
  (load-dict!)
  (reset-tally!)
  (tally-charlist!)
  (display-result!))



