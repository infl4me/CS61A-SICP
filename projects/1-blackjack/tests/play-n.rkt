#lang racket

(require rackunit)
(require "../blackjack.rkt")

(define-simple-check (check-3 n)
    (and (>= n (- 3)) (<= n 3)))
(check-3 (play-n dealer-sensitive-strategy 3))

(define-simple-check (check-0 n)
    (and (>= n (- 0)) (<= n 0)))
(check-0 (play-n dealer-sensitive-strategy 0))

(define-simple-check (check-10 n)
    (and (>= n (- 10)) (<= n 10)))
(check-10 (play-n dealer-sensitive-strategy 10))

(define-simple-check (check-100 n)
    (and (>= n (- 100)) (<= n 100)))
(check-100 (play-n dealer-sensitive-strategy 100))
