#lang racket

(require rackunit)
(require "../blackjack.rkt")

(define stop-at-17 (stop-at-strategy 17))
(define stop-at-15 (stop-at-strategy 15))

(check-equal? (stop-at-17 '(AD 8S) 'AD) #f)
(check-equal? (stop-at-17 '(QD 7S) 'AD) #f)
(check-equal? (stop-at-17 '(QD 6S) 'AD) #t)
(check-equal? (stop-at-17 '(2D 7S) 'AD) #t)
(check-equal? (stop-at-17 '(AD AS) 'AD) #t)
(check-equal? (stop-at-17 '(AD JS) 'AD) #f)


(check-equal? (stop-at-15 '(QD 6S) 'AD) #f)
(check-equal? (stop-at-15 '(QD 5S) 'AD) #f)
(check-equal? (stop-at-15 '(QD 4S) 'AD) #t)
