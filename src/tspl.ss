;; The Scheme Program Language
;; sample precedures

;; usage:
;; $ scheme
;; $ (load "tspl.ss")

;; square(n)
(define square
  (lambda (n)
    (* n n)))

;; reciprocal
(define reciprocal
  (lambda (n)
    (if (= n 0)
        "oops!"
        (/ 1 n))))

;; dobole any
(define double-any
  (lambda (f x)
    (f x x)))

;; 自定义list过程
(define zlist
  (lambda (x . y)
    (cons x y)))
