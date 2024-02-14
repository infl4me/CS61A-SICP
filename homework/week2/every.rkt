#lang racket

; Last week you wrote procedures squares, that squared each number in its argument
; sentence, and saw pigl-sent, that pigled each word in its argument sentence. Generalize
; this pattern to create a higher-order procedure called every that applies an arbitrary
; procedure, given as an argument, to each word of an argument sentence. This procedure
; is used as follows:
; (every square ’(1 2 3 4))
; (1 4 9 16)

(define (square x) (* x x))

(define (every fn coll)
  (if (null? coll)
    '()
    (cons (fn (car coll))
          (every fn (cdr coll)))))

(every square '(2 3 4 6)) ; (4 9 16 36)
(every (lambda (x) (* x 3)) '(2 3 4 6)) ; (6 9 12 18)
