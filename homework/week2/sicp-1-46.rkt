#lang racket

(define (square x) (* x x))

(define (iterative-improve good-enough? improve-guess)
  (define (iterate guess)
    (if (good-enough? guess)
        guess
        (iterate (improve-guess guess))))

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
