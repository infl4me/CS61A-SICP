#lang racket

; Write a procedure squares that takes a sentence of numbers as its argument and
; returns a sentence of the squares of the numbers

(define (square x) (* x x))

(define (squares numbers)
  (if (null? numbers)
    '()
    (cons (square (car numbers))
          (squares (cdr numbers)))))

(squares '(2 3 4 6)) ; (4 9 16 36)
