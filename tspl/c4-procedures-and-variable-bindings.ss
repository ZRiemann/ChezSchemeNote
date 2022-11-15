;;; Chapter 4. Procedures and Variable Bindings
;;; Section 4.1. Variable Reference
;;; Section 4.2. Lambda
;;; Section 4.3. Case-Lambda
;;; Section 4.4. Local Binding
;;; Section 4.5. Multiple Values
;;; Section 4.6. Variable Definitions
;;; Section 4.7. Assignment

;;; Section 4.1. Variable Reference
;;; syntax: variable
;;; returns: the value of variable
list                ; => #<procedure list>
(define x 'a)
x                   ; => a
(list x x)          ; =>(a a)

;;; it is not necessary for the definition of a variable to appear before its first reference appears,
;;; as long as the reference is not actually evaluated until the definition has been completed.
(define f
  (lambda (x)
    (g x)))
; g 可以后于 f 定义, 优点: 库定义更灵活,相当于定义了接口规范,用户使用时可自定义g的行为
(define g
  (lambda (x)
    (+ x x)))
(define q (ggxx 3)) ; => variable ggxx is not bound

;;; Section 4.2. Lambda
;;; syntax: (lambda formals body1 body2 ...)
;;; returns: a procedure
(lambda (x) (+ x 3)) ; =>  #<procedure>
((lambda (x) (+ x 3)) 7) ; => 10
((lambda (x y) (* x (+ x y))) 7 13) ; => 140
((lambda (f x) (f x x)) + 11) ; => 22
((lambda () (+ 3 4))) ; => 7
((lambda (x . y) (list x y)) 28 37) ; => (28 (37))
((lambda (x . y) (list x y)) 28 37 47 28) ; => (28 (37 47 28))
((lambda (x y . z) (list x y z)) 1 2 3 4) ; => (1 2 (3 4))
((lambda x x) 7 13) ; => (7 13)

;;; Section 4.3. Case-Lambda
;;; syntax: (case-lambda clause ...)
;;; returns: a procedure
;;; libraries: (rnrs control) (rnrs)
(define make-list
  (case-lambda
    [(n) (make-list n #f)]
    [(n x)
     (do ([n n (- n 1)] [ls '() (cons x ls)])
         ((zero? n) ls))]))
(make-list 3 'a)
(make-list 3)

(define substring1
  (case-lambda
    [(s) (substring1 s 0 (string-length s))]
    [(s start) (substring1 s start (string-length s))]
    [(s start end) (substring s start end)]))

;;; Section4.4. Local Binding
;;; syntax: (let ((var expr) ...) body1 body2 ...)
;;; returns: the values of the final body expression
;;; libraries: (rnrs base), (rnrs)
;;; let, let*, letrec, and letrec*...
