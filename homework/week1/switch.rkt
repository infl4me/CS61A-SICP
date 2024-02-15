; Write a procedure switch that takes a sentence as its argument and returns a sentence
; in which every instance of the words I or me is replaced by you, while every instance of
; you is replaced by me except at the beginning of the sentence, where it’s replaced by I.
; (Don’t worry about capitalization of letters.) Example:
; (switch ’(You told me that I should wake you up))
; (i told you that you should wake me up)

(define (switch sentence)
  (define (replace_word w)
    (cond
      ((equal? 'You w) 'me)
      ((equal? 'I w) 'you)
      ((equal? 'me w) 'you)
      (w)
    ))

  (define (replace_first_word w)
    (cond
      ((equal? 'You w) 'I)
      ((equal? 'I w) 'You)
      (w)
    ))
  (define (iter sentence)
    (if (null? sentence)
      '()
      (cons (replace_word (car sentence))
            (iter (cdr sentence)))))

  (cons (replace_first_word (car sentence))
        (iter (cdr sentence))))


(switch '(You told me that I should wake you up)) ; (i told you that you should wake me up)
