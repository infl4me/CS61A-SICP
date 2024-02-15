#lang simply-scheme

; Write a procedure substitute that takes three arguments: a sentence, an old word, and a new word. It
; should return a copy of the sentence, but with every occurrence of the old word replaced by the new word.
; For example:
; > (substitute ’(she loves you yeah yeah yeah) ’yeah ’maybe)
; (she loves you maybe maybe maybe)

(define (substitute sentence old new)
  (if (empty? sentence)
      '()
      (se
       (if (equal? (first sentence) old)
           new
           (first sentence))
       (substitute (bf sentence) old new))))

(substitute '(she loves you yeah yeah yeah) 'yeah 'maybe) ; (she loves you maybe maybe maybe)


; 5. Find the values of the expressions

(define (t f)
  (lambda (x) (f (f (f x)))) )
(define (1+ x) (+ x 1))

((t 1+) 0) ; 3
((t (t 1+)) 0) ; 9
(((t t) 1+) 0) ; 27

; 7. Write and test the make-tester procedure. Given a word w as argument, make-tester returns a procedure
; of one argument x that returns true if x is equal to w and false otherwise.

(define (make-tester expected) (lambda (actual) (equal? actual expected)))

((make-tester 'hal) 'hal) ; #t
((make-tester 'hal) 'cs61a) ; #f
(define sicp-author-and-astronomer? (make-tester 'gerry))
(sicp-author-and-astronomer? 'hal) ; #f
(sicp-author-and-astronomer? 'gerry) ; #t
