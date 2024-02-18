#lang racket

(require rackunit)
(require "../blackjack.rkt")

(check-equal? (stop-at-17-strategy '(AD 8S) 'AD) #f)
(check-equal? (stop-at-17-strategy '(QD 7S) 'AD) #f)
(check-equal? (stop-at-17-strategy '(QD 6S) 'AD) #t)
(check-equal? (stop-at-17-strategy '(2D 7S) 'AD) #t)
(check-equal? (stop-at-17-strategy '(AD AS) 'AD) #t)
(check-equal? (stop-at-17-strategy '(AD JS) 'AD) #f)
