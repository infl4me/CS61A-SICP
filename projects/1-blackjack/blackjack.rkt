#lang simply-scheme

(define (twenty-one strategy)
  (define (play-dealer customer-hand dealer-hand-so-far rest-of-deck)
    (cond ((> (best-total dealer-hand-so-far) 21) 1)
          ((< (best-total dealer-hand-so-far) 17)
           (play-dealer customer-hand
                        (se dealer-hand-so-far (first rest-of-deck))
                        (bf rest-of-deck)))
          ((< (best-total customer-hand) (best-total dealer-hand-so-far)) -1)
          ((= (best-total customer-hand) (best-total dealer-hand-so-far)) 0)
          (else 1)))

  (define (play-customer customer-hand-so-far dealer-up-card rest-of-deck)
    (cond ((> (best-total customer-hand-so-far) 21) -1)
          ((strategy customer-hand-so-far dealer-up-card)
           (play-customer (se customer-hand-so-far (first rest-of-deck))
                          dealer-up-card
                          (bf rest-of-deck)))
          (else
           (play-dealer customer-hand-so-far
                        (se dealer-up-card (first rest-of-deck))
                        (bf rest-of-deck)))))

  (let ((deck (make-deck)))
    (play-customer (se (first deck) (first (bf deck)))
                   (first (bf (bf deck)))
                   (bf (bf (bf deck))))) )

(define (make-ordered-deck)
  (define (make-suit s)
    (every (lambda (rank) (word rank s)) '(A 2 3 4 5 6 7 8 9 10 J Q K)) )
  (se (make-suit 'H) (make-suit 'S) (make-suit 'D) (make-suit 'C)) )

(define (make-deck)
  (define (shuffle deck size)
    (define (move-card in out which)
      (if (= which 0)
          (se (first in) (shuffle (se (bf in) out) (- size 1)))
          (move-card (bf in) (se (first in) out) (- which 1)) ))
    (if (= size 0)
        deck
        (move-card deck '() (random size)) ))
  (shuffle (make-ordered-deck) 52) )

(define (card-value card)
  (cond
    ((equal? card "AC") 11)
    ((equal? card "AD") 11)
    ((equal? card "AH") 11)
    ((equal? card "AS") 11)
    ((equal? card "KC") 10)
    ((equal? card "KD") 10)
    ((equal? card "KH") 10)
    ((equal? card "KS") 10)
    ((equal? card "QC") 10)
    ((equal? card "QD") 10)
    ((equal? card "QH") 10)
    ((equal? card "QS") 10)
    ((equal? card "JC") 10)
    ((equal? card "JD") 10)
    ((equal? card "JH") 10)
    ((equal? card "JS") 10)
    ((equal? card "10C") 10)
    ((equal? card "10D") 10)
    ((equal? card "10H") 10)
    ((equal? card "10S") 10)
    ((equal? card "9C") 9)
    ((equal? card "9D") 9)
    ((equal? card "9H") 9)
    ((equal? card "9S") 9)
    ((equal? card "8C") 8)
    ((equal? card "8D") 8)
    ((equal? card "8H") 8)
    ((equal? card "8S") 8)
    ((equal? card "7C") 7)
    ((equal? card "7D") 7)
    ((equal? card "7H") 7)
    ((equal? card "7S") 7)
    ((equal? card "6C") 6)
    ((equal? card "6D") 6)
    ((equal? card "6H") 6)
    ((equal? card "6S") 6)
    ((equal? card "5C") 5)
    ((equal? card "5D") 5)
    ((equal? card "5H") 5)
    ((equal? card "5S") 5)
    ((equal? card "4C") 4)
    ((equal? card "4D") 4)
    ((equal? card "4H") 4)
    ((equal? card "4S") 4)
    ((equal? card "3C") 3)
    ((equal? card "3D") 3)
    ((equal? card "3H") 3)
    ((equal? card "3S") 3)
    ((equal? card "2C") 2)
    ((equal? card "2D") 2)
    ((equal? card "2H") 2)
    ((equal? card "2S") 2)))

(define (best-total hand)
  (define (ace? card) (equal? (first card) 'A))

  (define (count-hand h)
    (define (value c) (if (ace? c) 0 (card-value c)))
    (if (empty? h) 0
        (+ (value (first h)) (count-hand (bf h)))))

  (define (count-hand-aces hand count)
    (define (value card cur_count) (if (ace? card) (if (<= cur_count 10) 11 1) 0))
    (if (empty? hand) count
        (count-hand-aces (bf hand) (+ count (value (first hand) count)))))

  (count-hand-aces hand (count-hand hand)))

(best-total '(AD 8S)) ; 19
(best-total '(AD 8S 5H)) ; 14
(best-total '(AD AS 9H)) ; 21
(best-total '(AD AS 9H 6D)) ; 17
(best-total '(AD AS 9H 6D 10S)) ; 27
(best-total '(AD AS AH AC)) ; 14
