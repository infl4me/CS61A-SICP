#lang racket

(require rackunit)
(require "../blackjack.rkt")

(check-equal? (valentine-strategy '(10D 8S) '10D) #f)
(check-equal? (valentine-strategy '(10D 7S) '10D) #f)
(check-equal? (valentine-strategy '(10D 6S) '10D) #t)

(check-equal? (valentine-strategy '(10D 8H) '10D) #t)
(check-equal? (valentine-strategy '(10D 7H) '10D) #t)
(check-equal? (valentine-strategy '(10D 6H) '10D) #t)
(check-equal? (valentine-strategy '(10D 9H) '10D) #f)
(check-equal? (valentine-strategy '(10D 10H) '10D) #f)

