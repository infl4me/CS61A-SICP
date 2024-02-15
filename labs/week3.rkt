#lang simply-scheme

; original function
(define (count-change-orig amount)
  (define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (= kinds-of-coins 0)) 0)
          (else (+ (cc amount
                       (- kinds-of-coins 1))
                   (cc (- amount
                          (first-denomination
                           kinds-of-coins))
                       kinds-of-coins)))))

  (define (first-denomination kinds-of-coins)
    (cond ((= kinds-of-coins 1) 1)
          ((= kinds-of-coins 2) 5)
          ((= kinds-of-coins 3) 10)
          ((= kinds-of-coins 4) 25)
          ((= kinds-of-coins 5) 50)))

  (cc amount 5)
  )

(count-change-orig 100) ; 292


; 1. Identify a way to change the program to reverse the order in which coins are tried, that is, to change
; the program so that pennies are tried first, then nickels, then dimes, and so on.
(define (count-change1 amount)
  (define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (= kinds-of-coins 0)) 0)
          (else (+ (cc amount
                       (- kinds-of-coins 1))
                   (cc (- amount
                          (first-denomination
                           kinds-of-coins))
                       kinds-of-coins)))))

  (define (first-denomination kinds-of-coins)
    (cond ((= kinds-of-coins 1) 50)
          ((= kinds-of-coins 2) 25)
          ((= kinds-of-coins 3) 10)
          ((= kinds-of-coins 4) 5)
          ((= kinds-of-coins 5) 1)))

  (cc amount 5)
  )

(count-change1 100) ; 292


; 3. Modify the cc procedure so that its kinds-of-coins parameter, instead of being an integer, is a
; sentence that contains the values of the coins to be used in making change. The coins should be tried in the
; sequence they appear in the sentence. For the count-change procedure to work the same in the revised
; program as in the original, it should call cc as follows:
; (define (count-change amount)
; (cc amount ’(50 25 10 5 1)) )

(define (count-change2 amount)
  (define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (empty? kinds-of-coins)) 0)
          (else (+ (cc amount (bf kinds-of-coins))
                   (cc (- amount (first kinds-of-coins))
                       kinds-of-coins)))))

  (cc amount '(50 25 10 5 1))
  )

(count-change2 100) ; 292
