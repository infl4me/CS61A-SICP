#lang racket

(define (identity x) x)
(define (square x) (* x x))
(define (inc x) (+ x 1))

(define (accumulate combiner null-value term a inc b)
  (define (accumulate-rec a)
    (if (> a b)
      null-value
      (combiner (term a) (accumulate-rec (inc a)))))

  (accumulate-rec a))

(define (product term a b)
  (accumulate (lambda (x y) (* x y)) 1 term a inc b))

(product identity 1 5) ; 120
(product identity 3 8) ; 20160

(define (sum term a b)
  (accumulate (lambda (x y) (+ x y)) 0 term a inc b))

(sum identity 1 5) ; 15
(sum identity 3 8) ; 33

(sum square 1 5) ; 55
(sum square 3 8) ; 199
