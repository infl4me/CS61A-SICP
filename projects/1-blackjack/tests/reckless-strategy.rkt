#lang racket

(require rackunit)
(require "../blackjack.rkt")

(check-equal? ((reckless-strategy dealer-sensitive-strategy) '() '10D) #t)
(check-equal? ((reckless-strategy dealer-sensitive-strategy) '(10D) '10D) #t)
(check-equal? ((reckless-strategy dealer-sensitive-strategy) '(10D 8S) '10D) #t)
(check-equal? ((reckless-strategy dealer-sensitive-strategy) '(10D 8S 2S) '10D) #f)
