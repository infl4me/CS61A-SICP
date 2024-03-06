#lang simply-scheme

; 1. Try these in Scheme:
(define x (cons 4 5))
(car x)
(cdr x)

(define y (cons 'hello 'goodbye))
(define z (cons x y))
(car (cdr z))
(cdr (cdr z))


; 2. Predict the result of each of these before you try it:
(cdr (car z)) ; 5
(car (cons 8 3)) ; 8
(car z) ; (4 5)
; (car 3) ; err?


; 3. Enter these definitions into Scheme:
(define (make-rational num den)
  (cons num den))
(define (numerator rat)
  (car rat))
(define (denominator rat)
  (cdr rat))
(define (*rat a b)
  (make-rational (* (numerator a) (numerator b))
                 (* (denominator a) (denominator b))))
(define (print-rat rat)
  (word (numerator rat) '/ (denominator rat)))


; 4. Try this:
(print-rat (make-rational 2 3))
(print-rat (*rat (make-rational 2 3) (make-rational 1 4)))


; 5. Define a procedure +rat to add two rational numbers, in the same style as *rat above.

(define (+rat a b)
  (make-rational (+ (* (numerator a) (denominator b))
                    (* (denominator a) (numerator b)))
                 (* (denominator a) (denominator b))))

(print-rat (+rat (make-rational 2 3) (make-rational 1 3)))


; 6. Now do exercises 2.2, 2.3, and 2.4 from SICP.

; sicp 2.2:
(define (make-point x y) (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (make-segment p1 p2) (cons p1 p2))
(define (start-segment seg) (car seg))
(define (end-segment seg) (cdr seg))

(define (midpoint-segment seg)
  (make-segment
   (/ (+ (x-point (start-segment seg)) (x-point (end-segment seg))) 2)
   (/ (+ (y-point (start-segment seg)) (y-point (end-segment seg))) 2)))

(midpoint-segment (make-segment (make-point 3 1) (make-point 8 6))) ; (11/2 7/2)

;sicp 2.3:
(define (make-rectangle seg1 seg2) (cons seg1 seg2))
(define (rect-side1 rect) (car rect))
(define (rect-side2 rect) (cdr rect))

(define (rect-d side)
  (let ((x2 (x-point (end-segment side)))
        (x1 (x-point (start-segment side)))
        (y2 (y-point (end-segment side)))
        (y1 (y-point (start-segment side))))
    (sqrt
     (+
      (expt (- x2 x1) 2)
      (expt (- y2 y1) 2)))))

(define (rect-perimeter rect)
  (* 2 (+ (rect-d (rect-side1 rect)) (rect-d (rect-side2 rect)))))

(define rect1
  (make-rectangle
   (make-segment (make-point 4 2) (make-point 10 4))
   (make-segment (make-point 10 4) (make-point 6 16)))
  )

(rect-perimeter rect1) ; 37.95
