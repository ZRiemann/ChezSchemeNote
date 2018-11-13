#!/usr/bin/scheme --script

(display "
================================================================================
syntax: (lambda formals body1 body2 ...)
returns: a procedure
libraries: (rnrs base), (rnrs)

创建过错，建立本地变量绑定最终都由lambda/case-lambda定义

")
(display "
================================================================================
4.3 Case-Lambda

解决lambda不支持可选参数问题

syntax:(case-lambda clause ...)
returns: a procedure
libraries:(rnrs control), (rnrs)

[formals body1 body2]
")

(define make-list
  (case-lambda
   [(n) (make-list n #f)]
   [(n x)
    (do ([n n (- n 1)]
         [ls '() (cons x ls)])
        ((zero? n) ls))]))
(make-list 2)
(make-list 10 2)

(display "
================================================================================
4.4 Local Binding
本地绑定
syntax:(let ([var expr] ...) body1 body2 ...)
returns: the values of the final body expression
libraries:(rnrs base), (rnrs)
syntax-extention:
(define-syntax let
  (syntax-rules ()
    [(_ ((x e) ...) b1 b2 ...)
     ((lambda (x ...) b1 b2 ...) e ...)]))


(let ([x (* 3.0 3.0)] [y (* 4.0 4.0)])
  (sqrt (+ x y))) <graphic> 5.0 

(let ([x 'a] [y '(b c)])
  (cons x y)) <graphic> (a b c) 

(let ([x 0] [y 1])
  (let ([x y] [y x])
    (list x y))) <graphic> (1 0)

--------------------------------------------------------------------------------
对expr ... 进行从左到右的求值
let* 转换为一组嵌套的let表达式
syntax:(let* ([var expr] ...) body1 body2 ...)
returns: the values of the final body expression
libraries:(rnrs base), (rnrs)
syntax-extension:
(define-syntax let*
  (syntax-rules ()
    [(_ () e1 e2 ...)
     (let () e1 e2 ...)]
    [(_ ((x1 v1) (x2 v2) ...) e1 e2 ...)
     (let ((x1 v1))
       (let* ((x2 v2) ...) e1 e2 ...))]))

(let* ([x (* 5.0 5.0)]
       [y (- x (* 4.0 4.0))])
  (sqrt y)) <graphic> 3.0 

;; 注意与let的区别
(let ([x 0] [y 1])
  (let* ([x y] [y x])
    (list x y))) <graphic> (1 1)

--------------------------------------------------------------------------------
本地绑定，允许递归
(letrec ([sum (lambda (x)
                (if (zero? x)
                    0
                    ;; 递归
                    (+ x (sum (- x 1)))))])
  (sum 5)) <graphic> 15

syntax: (letrec ((var expr) ...) body1 body2 ...)
returns: the values of the final body expression
libraries: (rnrs base), (rnrs)
may be expressed in terms of let and set! as:
(let ((var #f) ...)
  (let ((temp expr) ...)
    (set! var temp) ...
    (let () body1 body2 ...)))

--------------------------------------------------------------------------------
顺序+递归
syntax: (letrec* ((var expr) ...) body1 body2 ...) 
returns: the values of the final body expression 
libraries: (rnrs base), (rnrs)

(let ((var #f) ...)
  (set! var expr) ...
  (let () body1 body2 ...))
")

(display "
================================================================================
Section 4.5 Multiple Values

绑定多个值
syntax: (let-values ((formals expr) ...) body1 body2 ...) 
syntax: (let*-values ((formals expr) ...) body1 body2 ...) 
returns: the values of the final body expression 
libraries: (rnrs base), (rnrs)

(let-values ([(a b) (values 1 2)] [c (values 1 2 3)])
  (list a b c)) <graphic> (1 2 (1 2 3)) 

(let*-values ([(a b) (values 1 2)] [(a b) (values b a)])
  (list a b)) <graphic> (2 1)

")

(display "
================================================================================
Variable Definitions
定义变量

syntax: (define var expr) 
syntax: (define var)
;;; 定义过程的简化形式
;;; 等价于 (define var0 (lambda (var1 ...)) body1 body2 ...)
syntax: (define (var0 var1 ...) body1 body2 ...) 
syntax: (define (var0 . varr) body1 body2 ...) 
syntax: (define (var0 var1 var2 ... . varr) body1 body2 ...) 
libraries: (rnrs base), (rnrs)
")

(display "
================================================================================
Section 4.7. Assignmnt

syntax: (set! var expr) 
returns: unspecified 
libraries: (rnrs base), (rnrs)

")