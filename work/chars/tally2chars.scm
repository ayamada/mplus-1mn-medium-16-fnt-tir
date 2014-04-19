#!/usr/bin/env gosh
;;; coding: utf-8
;;; -*- scheme -*-
;;; vim:set ft=scheme ts=8 sts=2 sw=2 et:

(define (main args)
  (for-each
    (lambda (line)
      (let1 m (#/^(.)\t(\d+)/ line)
        (when m
          (print (m 1)))))
    (port->string-list (current-input-port))))



