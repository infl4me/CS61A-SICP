; Write a procedure ends-e that takes a sentence as its argument and returns a sentence
; containing only those words of the argument whose last letter is E:
; (ends-e ’(please put the salami above the blue elephant))
; (please the above the blue)

(define (ends-e words)
  (define (ends-e? w)
    (equal? (last w) 'e))

  (cond ((null? words) '())
        ((ends-e? (car words)) (cons (car words) (ends-e (cdr words))))
        ((not (ends-e? (car words))) (ends-e (cdr words)))
        (else '())))

(ends-e '(please put the salami above the blue elephant)) ; (please the above the blue)
