#lang racket

(define (identity x) x)

(define (product term a b)
  (if (> a b)
    1
    (* (term a) (product term (+ a 1) b))))

(define (factorial n)
  (product identity 1 n))

(factorial 1) ; 1
(factorial 3) ; 6
(factorial 5) ; 120
(factorial 8) ; 40320
