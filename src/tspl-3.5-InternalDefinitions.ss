#!/usr/bin/scheme --script

(display "
================================================================================
内部定义，相对与顶层定义。
")
(let ()
  (define even?
    (lambda (x)
      (or (= 0 x)
          (odd? (- x 1)))))
  (define odd?
    (lambda (x)
      (and (not (= x 0))
           (even? (- x 1)))))
  (newline)
  (display (even? 20))
  (newline)
  (display (even? 19))
  (newline))

(define zlist?
  (lambda (x)
    (define race
      (lambda (h t)
        (if (pair? h)
            (let ([h (cdr h)])
              (if (pair? h)
                  (and (not (eq? h t))
                       (race (cdr h) (cdr t)))
                  (null? h)))
            (null? h))))
    (race x x)))
(zlist? '(1 2 3))

(display "
================================================================================
The End.
")