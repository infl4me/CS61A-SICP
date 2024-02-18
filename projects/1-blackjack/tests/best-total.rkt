#lang racket

(require rackunit)
(require "../blackjack.rkt")

(check-equal? (best-total '(AD 8S)) 19)
(check-equal? (best-total '(AD 8S 5H)) 14)
(check-equal? (best-total '(AD AS 9H)) 21)
(check-equal? (best-total '(AD AS 9H 6D)) 17)
(check-equal? (best-total '(AD AS 9H 6D 10S)) 27)
(check-equal? (best-total '(AD AS AH AC)) 14)
