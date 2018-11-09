#!/usr/bin/scheme --script

(display "
Section 2.9 Assignment
")

(display "
================================================================================
需求：变量状态被top-level共享，但不想被全局顶层可视
方案：使用let 绑定变量并使用set!使过程变量在(过程内)顶层可视；

;;; 定义 shhh, tell 顶层符号
(define shhh #f)
(define tell #f)

(let ([secret 0])
  ;;; 改变 shhh 的定义
  (set! shhh
    (lambda (message)
      (set! secret message)))
  ;;; 改变 tell 的定义
  ;;; 使得 secret 成为顶层变量
  (set! tell
    (lambda ()
      secret)))

(shhh \"sally likes harry\")
(tell) ;; => \"sally likes harry\"
secret ;; => exception: variable secret is not bound
")

(define shhh #f)
(define tell #f)
(let ([secret 0])
  (set! shhh
    (lambda (message)
      (set! secret message)))
  (set! tell
    (lambda ()
      secret))) 

(shhh "sally likes harry")
(display (tell)) (newline)
#;secret

(display "
================================================================================
需求： 延迟求值
方案：
  定义 lazy 过程，传一个 chunk 参数
  lazy 返回一个新的 chunk。

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
          (display \"Ouch!\")
          (newline)
          \"got me\")))

")

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

(trace p)
(p)
(p)
(p)

(display "
================================================================================
需求：堆栈，push!,top,pop!,empty?
实现：利用set!
扩展：dump

(define make-stack
  (lambda ()
    (let ([ls '()])
      (lambda (msg . args)
        (cond
         [(eqv? msg 'empty?) (null? ls)]
         [(eqv? msg 'push!) (set! ls (cons (car args) ls))]
         [(eqv? msg 'top) (car ls)]
         [(eqv? msg 'pop!) (set! ls (cdr ls))]
         [(eqv? msg 'dump) ls]
         [else \"opps\"])))))

(define stack1 (make-stack))

")

;;; (trace define) not bound
(define make-stack
  (lambda ()
    (let ([ls '()])
      (lambda (msg . args)
        (cond
         [(eqv? msg 'empty?) (null? ls)]
         [(eqv? msg 'push!) (set! ls (cons (car args) ls))]
         [(eqv? msg 'top) (car ls)]
         [(eqv? msg 'pop!) (set! ls (cdr ls))]
         [(eqv? msg 'dump) ls]
         [else "opps"])))))

(define stack1 (make-stack))
(define stack2 (make-stack))
(trace list)
(trace stack1)
(trace stack2)

(list (stack1 'empty?) (stack2 'empty?)) ;; => (#t #t)

(stack1 'push! 'a)
(stack1 'push! 'b)
(stack1 'dump)
(stack2 'dump)



(display "
================================================================================
功能：利用set-car!, set-cdr!来改变链表

(define p (list 1 2 3))
(set-car! (cdr p) 'two)
(set-cdr! p '())

")

(define p (list 1 2 3))

(trace set-car!)
(trace set-cdr!)

(set-car! (cdr p) 'two)
(display p)(newline)

(set-cdr! p '())
(display p)(newline)


(display "
================================================================================
功能：tconc
           [*.*]
      +-<---^ ^------->------+
     [a.*]-->[b.*]-->[c.*]-->[ignore.()]

make-queue: 创建队列
getq: 获取头数据
delq!: 删除头数据

;;; q
;;;               [*.*]
;;;  +-------------^ ^----+
;;; [ignored.()]      [ignored.()]
;;;
;;; ((ignored) ignored)
;;;
(define make-queue
  (lambda ()
    (let ([end (cons 'ignored '())])
      (cons end end)))) 

;;; q ((ignored) ignored)
;;; v 'a

(define putq!
  (lambda (q v)
    ;;; end: (ignored)
    (let ([end (cons 'ignored '())])
      ;;; ((a) a)
      (set-car! (cdr q) v)
      ;;; ((a ignore) a ignore)
      (set-cdr! (cdr q) end)
      ;;; ((a ignore) ignore)
      (set-cdr! q end))))

(define getq
  (lambda (q)
    (car (car q)))) 

(define delq!
  (lambda (q)
    (set-car! q (cdr (car q)))))
")

(define make-queue
  (lambda ()
    (let ([end (cons 'ignored '())])
      (cons end end)))) 

(define putq!
  (lambda (q v)
    (let ([end (cons 'ignored '())])
      (set-car! (cdr q) v)
      (display q) (newline)
      (set-cdr! (cdr q) end)
      (display q) (newline)
      (set-cdr! q end)
      (display q) (newline)))) 

(define getq
  (lambda (q)
    (car (car q)))) 

(define delq!
  (lambda (q)
    (set-car! q (cdr (car q)))
    (display q) (newline)))

(define myq (make-queue))
(display myq) (newline)
(trace putq!)
(trace delq!)
(trace getq)
(trace make-queue)
(putq! myq 'a)
(putq! myq 'b)
(getq myq) #; a
(delq! myq)
(getq myq) #; b
(delq! myq)
(putq! myq 'c)
(putq! myq 'd)
(getq myq) #; c
(delq! myq)
(getq myq) #; d

(display "
================================================================================
The End!
")