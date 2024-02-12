#lang racket

(define (identity x) x)
(define (square x) (* x x))
(define (inc x) (+ x 1))

(define (filtered-accumulate combiner null-value term predicate a inc b)
  (define (accumulate-rec a)
    (cond ((> a b) null-value)
      ((predicate a) (combiner (term a) (accumulate-rec (inc a))))
      (else (accumulate-rec (inc a)))))

  (accumulate-rec a))

(define (sum term predicate a b)
  (filtered-accumulate (lambda (x y) (+ x y)) 0 term predicate a inc b))

(define (even? x) (equal? (modulo x 2) 0))
(sum identity even? 1 10) ; 30
(sum square even? 1 10) ; 220

(define (product term predicate a b)
  (filtered-accumulate (lambda (x y) (* x y)) 1 term predicate a inc b))
(product identity even? 1 10) ; 3840
