#lang simply-scheme

(define (blackjack strategy)
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
  (se '("RR" "RR") (make-suit 'H) (make-suit 'S) (make-suit 'D) (make-suit 'C)) )

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
  (let ((value (bl card)))
    (cond
      ((equal? 'R value) 11)
      ((equal? 'A value) 11)
      ((equal? 'J value) 10)
      ((equal? 'Q value) 10)
      ((equal? 'K value) 10)
      (else value))))

(define (card-type card) (bl card))
(define (card-suit card) (last card))

(define (best-total hand)
  (define (ace? card) (equal? (card-type card) 'A))
  (define (joker? card) (equal? (card-type card) 'R))
  (define (simple? card) (and (not (joker? card)) (not (ace? card))))

  (define (count-hand h)
    (if (empty? h) 0
        (+ (card-value (first h)) (count-hand (bf h)))))

  (define (add-aces cur-count aces-count jokers-count)
    (define (add-last-ace cc)
      (if (<= (+ cc jokers-count) 10) (+ cc 11) (+ cc 1)))

    (if (= aces-count 0)
        cur-count
        (add-last-ace (+ cur-count (- aces-count 1)))
        ))

  (define (add-jokers cur-count jokers-count)
    (let ((diff (- 21 cur-count)))
      (cond
        ((and (>= diff (* 1 jokers-count)) (<= diff (* 11 jokers-count))) (+ cur-count diff))
        ((< diff (* 1 jokers-count)) (+ cur-count (* 1 jokers-count)))
        (else (+ cur-count (* 11 jokers-count))))))

  (let ((jokers (filter (lambda (card) (joker? card)) hand))
        (aces (filter (lambda (card) (ace? card)) hand))
        (simple-hand (filter (lambda (card) (simple? card)) hand)))
    (add-jokers
     (add-aces (count-hand simple-hand) (count aces) (count jokers))
     (count jokers))))

(define (stop-at-strategy n)
  (lambda (hand dealer-up-card) (< (best-total hand) n)))

(define (suit-strategy suit success-strategy fail-strategy)
  (lambda (hand dealer-up-card)
    (let ((hand-by-suit (filter (lambda (card) (equal? (card-suit card) suit)) hand)))
      (if (> (count hand-by-suit) 0)
          (success-strategy hand dealer-up-card)
          (fail-strategy hand dealer-up-card)))))

; strategy that stops at 17 unless you have a heart in your hand, in which case it stops at 19.
(define valentine-strategy
  (suit-strategy 'H (stop-at-strategy 19) (stop-at-strategy 17)))

(define (dealer-sensitive-strategy hand dealer-up-card)
  (let ((dealer-value (card-value dealer-up-card)) (customer-value (best-total hand)))
    (or (and (>= dealer-value 7) (< customer-value 17))
        (and (<= dealer-value 6) (< customer-value 12)))))

; Takes three strategies as arguments and produces a
; strategy as a result, such that the result strategy always decides whether or not to “hit”
; by consulting the three argument strategies, and going with the majority. That is, the
; result strategy should return #t if and only if at least two of the three argument strategies
; do.
(define (majority-strategy strategy1 strategy2 strategy3)
  (lambda (hand dealer-up-card)
    (define (iter count majority-count)
      (cond ((equal? count 0) (>= majority-count 2))
            ((equal? count 1) (iter (- count 1) (+ majority-count (if (strategy3 hand dealer-up-card) 1 0))))
            ((equal? count 2) (iter (- count 1) (+ majority-count (if (strategy2 hand dealer-up-card) 1 0))))
            ((equal? count 3) (iter (- count 1) (+ majority-count (if (strategy1 hand dealer-up-card) 1 0))))))

    (iter 3 0)))

(define (reckless-strategy strategy)
  (lambda (hand dealer-up-card)
    (or (or (empty? hand) (empty? (bl hand)))
        (and (not (strategy hand dealer-up-card)) (strategy (bl hand) dealer-up-card)))))

(define (play-n strategy n)
  (define (iter games-to-play games-won)
    (if (= games-to-play 0)
        games-won
        (iter (- games-to-play 1) (+ games-won (blackjack strategy)))))

  (iter n 0))

(provide (all-defined-out))
