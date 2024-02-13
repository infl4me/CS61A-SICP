#lang racket

(define (square x) (* x x))

(define (iterative-improve good-enough? improve)
  (define (iterate guess)
    (if (good-enough? guess)
        guess
        (iterate (improve guess))))

  iterate)

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt x)
  ((iterative-improve
    (lambda (guess) (< (abs (- (square guess) x)) 0.001))
    (lambda (guess) (average guess (/ x guess))))
   1.0))

(sqrt 9) ; 3.00009155413138
(sqrt (+ 100 37)) ; 11.704699917758145

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  ((iterative-improve (lambda (guesses)
			(< (abs (- (first guesses) (last guesses))) tolerance))
		      (lambda (guesses)
			(list (last guesses) (f (last guesses)))))
   (list first-guess (f first-guess))))

(fixed-point cos 1.0) ; .7390822985224023
