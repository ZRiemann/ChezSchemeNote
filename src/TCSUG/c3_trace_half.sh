#! /usr/bin/scheme --script
(define half
  (trace-lambda half (x)
                (cond
                 [(zero? x) 0]
                 [(odd? x) (half (- x 1))]
                 [(even? x) (+ (half (- x 1)) 1)])))

(half 5)