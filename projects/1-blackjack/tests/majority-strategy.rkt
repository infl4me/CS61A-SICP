#lang racket

(require rackunit)
(require "../blackjack.rkt")

(define stop-at-17-strategy (stop-at-strategy 17))
(define stop-at-13-strategy (stop-at-strategy 13))
(define majority-custom-strategy
  (majority-strategy stop-at-17-strategy dealer-sensitive-strategy valentine-strategy))

; all strategies false
(check-equal? (dealer-sensitive-strategy '(10D 8S) '10D) #f)
(check-equal? (valentine-strategy '(10D 8S) '10D) #f)
(check-equal? (stop-at-17-strategy '(10D 8S) '10D) #f)
(check-equal? (majority-custom-strategy '(10D 8S) '10D) #f)

; one strategy true
(check-equal? (dealer-sensitive-strategy '(10D 8H) '10D) #f)
(check-equal? (valentine-strategy '(10D 8H) '10D) #t)
(check-equal? (stop-at-17-strategy '(10D 8H) '10D) #f)
(check-equal? (majority-custom-strategy '(10D 8H) '10D) #f)

; two strategies true
(check-equal? (dealer-sensitive-strategy '(10D 3S) 'AD) #t)
(check-equal? (valentine-strategy '(10D 3S) 'AD) #t)
(check-equal? (stop-at-13-strategy '(10D 3S) 'AD) #f)
(check-equal? (majority-custom-strategy '(10D 3S) 'AD) #t)

; three strategies true
(check-equal? (dealer-sensitive-strategy '(10D 6S) '10D) #t)
(check-equal? (valentine-strategy '(10D 6S) '10D) #t)
(check-equal? (stop-at-17-strategy '(10D 6S) '10D) #t)
(check-equal? (majority-custom-strategy '(10D 6S) '10D) #t)
