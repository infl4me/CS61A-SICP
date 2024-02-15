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

