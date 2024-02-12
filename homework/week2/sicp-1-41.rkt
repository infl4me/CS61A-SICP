#lang racket

(define (identity x) x)
(define (square x) (* x x))
(define (inc x) (+ x 1))

(define (double proc) (lambda (x) (proc (proc x))))

((double inc) 3) ; 5
(((double (double double)) inc) 5) ; 21
