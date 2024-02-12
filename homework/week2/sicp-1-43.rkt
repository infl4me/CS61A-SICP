#lang racket

(define (identity x) x)
(define (square x) (* x x))
(define (inc x) (+ x 1))

(define (compose f g) (lambda (x) (f (g x))))

(define (repeated fn n)
  (if (= n 1)
    fn
    (compose (repeated fn (- n 1)) fn)))

((repeated square 1) 5) ; 25
((repeated square 2) 5) ; 625
((repeated inc 10) 15) ; 25
