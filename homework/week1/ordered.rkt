; Write a predicate ordered? that takes a sentence of numbers as its argument and
; returns a true value if the numbers are in ascending order, or a false value otherwise.

(define (ordered? numbers)
  (cond ((null? numbers) #t)
        ((null? (cdr numbers)) #t)
        ((and (<= (car numbers) (cadr numbers))
              (ordered? (cdr numbers))) #t)
        (else #f)))

(ordered? '(1 2 3 4)) ; Output: #t
(ordered? '(4 3 2 1)) ; Output: #f
(ordered? '(1 2 2 3)) ; Output: #t
(ordered? '(1 3 2 3)) ; Output: #f

(ordered? '(1)) ; Output: #t
(ordered? '()) ; Output: #t

