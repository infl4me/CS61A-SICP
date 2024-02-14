#lang racket

; find a way to express the fact procedure in a Scheme without any way to
; define global names

((lambda (fn) (fn fn 5))
 (lambda (fn n)
   (if (= n 0)
       1
       (* n (fn fn (- n 1)))))) ; 120
