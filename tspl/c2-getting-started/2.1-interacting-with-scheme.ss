#!/usr/bin/scheme --script

(display "2.1 交互式Scheme
- 常量的值是常量自身
- 定义过程
  define 理解为建立变量绑定
  lambda 理解为创建过程
  * 表示乘法过程
- 加载文件 (load \"file-name.ss\")
")
"hello"
(display "hello\n")

(define square
  (lambda (n)
    (* n n)))

(square 5)
(display (square 5))
(display "\n")
(square 3.14)
(display (square 3.14))
(display "\n")

(load "reciprocal.ss")
(display (reciprocal 10))
(display "\n")

(let ([x 'a])
  (let ([f (lambda (y) (list x y))])
    (f 'b)))

(let ([f (let ([x 'sam]) 
  (lambda (y z) (list x y z)))])
    (f 'a 'm))

(let ([f (lambda x x)])
  (f 1 2 3 4))

(let ([g (lambda (x . y) (list x y))])
  (g 1 2 3 4))

(let ([h (lambda (x y . z) (list x y z))])
  (h 'a 'b 'c 'd))

(let ([f (lambda (x) x)])
  (f 'a))

(let ([f (lambda x x)])
  (f 'a))

(let ([f (lambda (x . y) x)])
  (f 'a))

(let ([f (lambda (x . y) y)])
  (f 'a))

(define list-1 (lambda x x))

((lambda (f x) (f x)) 1 2)

(display "Section 2.6. Top-Level Definitions")
(define double-any
  (lambda (f x) (f x x)))

(double-any + 10)
(double-any cons 'a)

(define sandwich "peanut-butter-and-jelly")
(display sandwich)

(define cadr 
  (lambda (x)
    (car (cdr x))))

(define (cadr x)
  (car (cdr x)))

(define (list . x ) x)

(define doubler 
  (lambda (f)
    (lambda (x) (f x x))))

(define double
  (doubler +))

(double 13/2)

(define double-cons
  (doubler cons))

(double-cons 'a)

(define double-any
  (lambda f x)
    ((doubler f) x))

(define proc1
  (lambda (x y)
    (proc2 y x)))

(define proc2 cons)

(display "2.7. Conditional Expressions
 (if test consequent alternative)
")

(define abs
  (lambda (n)
    (if (< n 0)
      (- 0 n)
      n)))

(if #t 'true 'false)

(if '() #t #f)

(not #t)
(not #f)
(or #f 'a #f)

(null? '())
(null? 'abc)

(pair? '(a . c))

(define reciprocal
  (lambda (n)
    (if (and (number? n) (not (= n 0)))
      (/ 1 n)
      "oops!")))

(define sign
  (lambda (n)
    (cond
      [(< n 0) -1]
      [(> n 0) +1]
      [else 0])))

(define zlength
  (lambda (ls)
    (if (null? ls)
      0
      (+ (zlength (cdr ls)) 1))))

(trace zlength)
(zlenght '(1 2))

(trace length)

(define zlist-copy
  (lambda (ls)
    (if (null? ls)
      '()
      (cons (car ls)
        (zlist-copy (cdr ls))))))

(define memv
  (lambda (x ls)
    (cond
      [(null? ls) #f]
      [(eqv? (car ls) x) ls]
      [else (memv x (cdr ls))])))

(define tree-copy
  (lambda (tr)
    (if (not (pair? tr))
        tr
        (cons (tree-copy (car tr))
              (tree-copy (cdr tr))))))

(define abs-all
  (lambda (ls)
    (if (null? ls)
      '()
      (cons (abs (car ls))
        (abs-all (cdr ls))))))

(define abs-all
  (lambda (ls)
    (map abs ls)))

(map (lambda (x) (* x x))
  '(1 3 5 7))

(map cons '(a b c) '(1 2 3))

(define zmake-list
  (lambda (n o)
    (if (eqv? n 0)
      '()
      (cons o (zmake-list (- n 1) o)))))
(zmake-list 7 '())

(define zlist-ref
  (lambda (ls n)
    (if (eqv? n 0)
      (car ls)
      (zlist-ref (cdr ls) (- n 1)))))

(define zlist-tail
  (lambda (ls n)
    (if (eqv? n 0)
      ls
      (zlist-tail (cdr ls) (- n 1)))))

(zlist-ref '(1 2 3 4) 0)
(zlist-tail '(1 2 3 4) 0)
(zlist-ref '(a short (nested) list) 2)
(zlist-tail '(a short (nested) list) 2)

#|
(define transpose
  (lambda (ls)
    (cons 
    (map (lambda (pa)
      (car pa))
      ls)
      map (lambda (pa)
      (cdr pa))
      ls)))
|#
(define transpose
  (lambda (ls)
    (cons 
      (map (lambda (pa) (car pa)) ls)
      (map (lambda (pa) (cdr pa)) ls)
    )
  ))
(transpose '((a . 1) (b . 2) (c . 3)))

(let ([abcde '(a b c d e)])
  (set! abcde (reverse abcde))
  abcde)


(define quadratic-formula
  (lambda (a b c)
    (let ([root1 0] [root2 0] [minusb 0] [radical 0] [divisor 0])
      (set! minusb (- 0 b))
      (set! radical (sqrt (- (* b b) (* 4 (* a c)))))
      (set! divisor (* 2 a))
      (set! root1 (/ (+ minusb radical) divisor))
      (set! root2 (/ (- minusb radical) divisor))
      (cons root1 root2))))

(define quadratic-formula
  (lambda (a b c)
    (let ([minusb (- 0 b)]
          [radical (sqrt (- (* b b) (* 4 (* a c))))]
          [divisor (* 2 a)])
      (let ([root1 (/ (+ minusb radical) divisor)]
            [root2 (/ (- minusb radical) divisor)])
        (cons root1 root2)))))

(define kons-count 0)
(define kons
  (lambda (x y)
    (set! kons-count (+ kons-count 1))
    (cons x y)))

(kons 'a '(b c))
kons-count

(kons 'a (kons 'b (kons 'c '())))

kons-count

(define next 0)
(define count
  (lambda ()
    (let ([v next])
      (set! next (+ next 1))
      v)))
(count)
(count)

(define count
  (let ([next 0])
    (lambda ()
      (let ([v next])
        (set! next (+ next 1))
        v))))

(define make-counter
  (lambda ()
    (let ([next 0])
      (lambda ()
        (let ([v next])
          (set! next (+ next 1))
          v)))))

(define lazy
  (lambda (t)
    (let ([val #f] [flag #f])
      (lambda ()
        (if (not flag)
            (begin (set! val (t))
                   (set! flag #t)))
        val))))

(define p
  (lazy (lambda ()
          (display "Ouch!")
          (newline)
          "got me")))

(define make-stack
  (lambda ()
    (let ([ls '()])
      (lambda (msg . args)
        (cond
          [(eqv? msg 'empty?) (null? ls)]
          [(eqv? msg 'push!) (set! ls (cons (car args) ls))]
          [(eqv? msg 'top) (car ls)]
          [(eqv? msg 'pop!) (set! ls (cdr ls))]
          [else "oops"])))))

(define stack1 (make-stack))
(define stack2 (make-stack))
(list (stack1 'empty?) (stack2 'empty?))

(stack1 'push! 'a)
(list (stack1 'empty?) (stack2 'empty?))

(stack1 'push! 'b)
(stack2 'push! 'c)
(stack1 'top)
;(b)
(stack2 'top)

'(three #;(not four) elements list)