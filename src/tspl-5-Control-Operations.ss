#!/usr/bin/scheme --script

(display "
================================================================================
5. Control Operations(控制操作)
  - 5.1 基本控制结构、过程应用
  - 5.+ 顺序，条件求值、递归、mapping、持续对象、延时计算、多值、运行时程序结构
")

(display "
================================================================================
5.1 Procedure Application

过程应用程序
syntax: (expr0 expr1 ...) 
returns: values of applying the value of expr0 to the values of expr1 ...
 1. 对expr0,expr1...逐项进行求值
 2. 将expr1... 应用到 expr0，进行求值
    if(expr0 不是 过程 || expr0 过程参数不匹配){ 抛出异常；}

--------------------------------------------------------------------------------
procedure: (apply procedure obj ... list) 
returns: the values of applying procedure to obj ... and the elements of list 
libraries: (rnrs base), (rnrs)

apply 调用过程， obj ... 作为<procedure>的常规参数
                list 作为 <procedure> 的剩余参数

作用：用list作为参数时，不需要对列表进行解构
例子： 求给定列表 (list-min '(8 3 6 2 7)) 中最小值
       思路是(min 8 3 6 2 7), 但是给的是 list，不能 (min list-min)
       使用apply解决： (apply min list-min)

示例：
(apply + '(4 5)) ;; 9 

(apply min '(6 8 3 2 5)) ;; 2 

(apply min  5 1 3 '(6 8 3 2 5)) ;; 1 

(apply vector 'a 'b '(c d e)) ;; #(a b c d e) 

(define first
  (lambda (ls)
    (apply (lambda (x . y) x) ls)))
(define rest
  (lambda (ls)
    (apply (lambda (x . y) y) ls)))
(first '(a b c d)) ;; a
(rest '(a b c d)) ;; (b c d) 

(apply append
  '(1 2 3)
  '((a b) (c d e) (f))) ;; (1 2 3 a b c d e f)
")

(define list-min '(8 3 6 2 7))
(apply min list-min) ;; 2
;; (min list-min) Exception in min: (8 3 6 2 7) is not a real number
(apply min 5 1 3 list-min) ;; 1

(display "
================================================================================
5.2 Sequencing
  顺序执行
syntax: (begin expr1 expr2 ...) 
returns: the values of the last subexpression 
libraries: (rnrs base), (rnrs)
extensions:
((lambda () expr1 expr2 ...))

解决顺序执行多个操作问题
((+ 1 2 3) (* 1 2 3)) ;; Exception: attempt to apply non-procedure 6
(begin (+ 1 2 3) (* 1 2 3)) ;; 6
")
;#((+ 1 2 3) (* 1 2 3))
(begin (+ 1 2 3) (* 1 2 3))
((lambda () (+ 1 2 3) (* 1 2 3)))

(display "
================================================================================
5.3 Conditionals
  条件分支
syntax: (if test consequent alternative) 
syntax: (if test consequent) ;; no auternative result unspecified if test false
returns: the values of consequent or alternative depending on the value of test 
libraries: (rnrs base), (rnrs)

--------------------------------------------------------------------------------
  非运算
procedure: (not obj) 
returns: #t if obj is false, #f otherwise 
libraries: (rnrs base), (rnrs)

(not #f) <graphic> #t
(not #t) <graphic> #f
(not '()) <graphic> #f
(not (< 4 5)) <graphic> #f

--------------------------------------------------------------------------------
  与运算
syntax: (and expr ...) 
returns: see below 
libraries: (rnrs base), (rnrs)

(let ([x 3])
  (and (> x 2) (< x 4))) <graphic> #t 

(let ([x 5])
  (and (> x 2) (< x 4))) <graphic> #f 

(and #f '(a b) '(c d)) <graphic> #f
(and '(a b) '(c d) '(e f)) <graphic> (e f)

--------------------------------------------------------------------------------
  或运算
syntax: (or expr ...) 
returns: see below 
libraries: (rnrs base), (rnrs)

(let ([x 3])
  (or (< x 2) (> x 4))) <graphic> #f 

(let ([x 5])
  (or (< x 2) (> x 4))) <graphic> #t 

(or #f '(a b) '(c d)) <graphic> (a b)

--------------------------------------------------------------------------------
  多重分支
syntax: (cond clause1 clause2 ...) 
returns: see below 
libraries: (rnrs base), (rnrs)

(test)
(test expr1 expr2 ...)
(test => expr)

(else expr1 expr2 ...)

syntax: else 
syntax: => 
libraries: (rnrs base), (rnrs exceptions), (rnrs)


example:

(let ([x 0])
  (cond
    [(< x 0) (list 'minus (abs x))]
    [(> x 0) (list 'plus x)]
    [else (list 'zero x)])) <graphic> (zero 0) 

(define select
  (lambda (x)
    (cond
      [(not (symbol? x))]
      [(assq x '((a . 1) (b . 2) (c . 3))) => cdr]
      [else 0]))) 

(select 3) <graphic> #t
(select 'b) <graphic> 2
(select 'e) <graphic> 0

--------------------------------------------------------------------------------
;;; (if (test-expr) (begin expr1 expr2 ...))
syntax: (when test-expr expr1 expr2 ...)
;;; (if (not (test-expr)) (begin expr1 expr2 ...))
syntax: (unless test-expr expr1 expr2 ...)
returns: see below 
libraries: (rnrs control), (rnrs)

")

(when #t
      (display 'a)
      (newline)
      (display 'b)
      (newline))
;;; equals (when ...)
(if #t (begin
         (display 'a)
         (newline)
         (display 'b)
         (newline)))

(when #f
      (display 'a)
      (newline)
      (display 'b)
      (newline))

(unless #t
      (display 'a)
      (newline)
      (display 'b)
      (newline))

(unless #f
      (display 'a)
      (newline)
      (display 'b)
      (newline))
;;; equals unless
(if (not #f) (begin
           (display 'a)
           (newline)
           (display 'b)
           (newline)))

(display "
--------------------------------------------------------------------------------
syntax: (case expr0 clause1 clause2 ...) 
returns: see below 
libraries: (rnrs base), (rnrs)

((key ...) expr1 expr2 ...)
(else expr1 expr2 ...)

(let ([x 4] [y 5])
  (case (+ x y)
    [(1 3 5 7 9) 'odd]
    [(0 2 4 6 8) 'even]
    [else 'out-of-range])) <graphic> odd
")