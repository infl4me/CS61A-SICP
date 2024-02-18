#lang racket

(require rackunit)
(require "../blackjack.rkt")

(check-equal? (dealer-sensitive-strategy '(10D 8S) '10D) #f)
(check-equal? (dealer-sensitive-strategy '(10D 7S) '10D) #f)
(check-equal? (dealer-sensitive-strategy '(10D 6S) '10D) #t)
(check-equal? (dealer-sensitive-strategy '(10D 6S) 'AD) #t)
(check-equal? (dealer-sensitive-strategy '(10D 6S) '7D) #t)
(check-equal? (dealer-sensitive-strategy '(10D 6S) '6D) #f)
(check-equal? (dealer-sensitive-strategy '(10D 2S) '6D) #f)
(check-equal? (dealer-sensitive-strategy '(9D 2S) '6D) #t)
