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

(not #f) ;; #t
(not #t) ;; #f
(not '()) ;; #f
(not (< 4 5)) ;; #f

--------------------------------------------------------------------------------
  与运算
syntax: (and expr ...) 
returns: see below 
libraries: (rnrs base), (rnrs)

(let ([x 3])
  (and (> x 2) (< x 4))) ;; #t 

(let ([x 5])
  (and (> x 2) (< x 4))) ;; #f 

(and #f '(a b) '(c d)) ;; #f
(and '(a b) '(c d) '(e f)) ;; (e f)

--------------------------------------------------------------------------------
  或运算
syntax: (or expr ...) 
returns: see below 
libraries: (rnrs base), (rnrs)

(let ([x 3])
  (or (< x 2) (> x 4))) ;; #f 

(let ([x 5])
  (or (< x 2) (> x 4))) ;; #t 

(or #f '(a b) '(c d)) ;; (a b)

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
    [else (list 'zero x)])) ;; (zero 0) 

(define select
  (lambda (x)
    (cond
      [(not (symbol? x))]
      [(assq x '((a . 1) (b . 2) (c . 3))) => cdr]
      [else 0]))) 

(select 3) ;; #t
(select 'b) ;; 2
(select 'e) ;; 0

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
    [else 'out-of-range])) ;; odd
")

(display "
================================================================================
5.4 Recurison and Iteration

命名let，是一个通用的迭代和递归构造
- var 和 expr 绑定
- name 绑定整个let过程，在body中调用name,即递归调用let过程
syntax: (let name ((var expr) ...) body1 body2 ...) 
returns: values of the final body expression 
libraries: (rnrs base), (rnrs)
rewritten:
((letrec ((name (lambda (var ...) body1 body2 ...)))
   name)
 expr ...)

;;; 非尾递归，找除数
(define divisors
  (lambda (n)
    (let f ([i 2])
      (cond
        [(>= i n) '()]
        [(integer? (/ n i)) (cons i (f (+ i 1)))]
        [else (f (+ i 1))])))) 

(divisors 5) ;; ()
(divisors 32) ;; (2 4 8 16)

;;; 尾递归，找除数
(define divisors
  (lambda (n)
    (let f ([i 2] [ls '()])
      (cond
        [(>= i n) ls]
        [(integer? (/ n i)) (f (+ i 1) (cons i ls))]
        [else (f (+ i 1) ls)]))))
")
(define divisors
  (lambda (n)
    (let f ([i 2])
      (cond
        [(>= i n) '() (display 'end)]
        [(integer? (/ n i)) (display i) (newline) (cons i (f (+ i 1)))]
        [else (display 'not-divisor) (newline) (f (+ i 1))]))))

(define divisors-tail
  (lambda (n)
    (let f ([i 2] [ls '()])
      (cond
        [(>= i n) ls]
        [(integer? (/ n i)) (f (+ i 1) (cons i ls))]
        [else (f (+ i 1) ls)]))))

(trace divisors)
(trace divisors-tail)
(divisors 32)
(divisors-tail 32)

(display "
--------------------------------------------------------------------------------
do循环;
var 被赋予 init 初始值，并在循环迭代时被重新绑定到 update... 值
test 表达式被求值，true时执行 result ... 表达式序列，返回最后一个表达式值
                  false时执行 expr ... 表达式序列，update ... 被求值并更新绑定 value
syntax: (do ((var init update) ...) (test result ...) expr ...) 
returns: the values of the last result expression 
libraries: (rnrs control), (rnrs)

vs C:

var = init;
do{
expr ...;
update(var) ...;
}while(!test);
result ...;

(define factorial
  (lambda (n)
    (do ([i n (- i 1)] [a 1 (* a i)])
        ((zero? i) a)))) 

(factorial 10) ;; 3628800 

(define fibonacci
  (lambda (n)
    (if (= n 0)
        0
        (do ([i n (- i 1)] [a1 1 (+ a1 a2)] [a2 0 a1])
            ((= i 1) a1))))) 

(fibonacci 6) ;; 8
")

(define factorial
  (lambda (n)
    (do ([i n (- i 1)] [a 1 (* a i)])
        ((zero? i ) (display i) (newline) a)
      (display a) (newline))))

(factorial 10) ;; 3628800 

(define fibonacci
  (lambda (n)
    (if (= n 0)
        0
        (do ([i n (- i 1)] [a1 1 (+ a1 a2)] [a2 0 a1])
            ((= i 1) a1))))) 

(fibonacci 6) ;; 8

(display "
================================================================================
Mapping and Folding
映射与则叠
当程序必须重复或迭代列表的元素时，映射或折叠操作通常更方便。
抽象了将procedure逐个应用到列表元素过程。
注意和apply的区别

procedure: (map procedure list1 list2 ...) 
returns: list of results 
libraries: (rnrs base), (rnrs)
definition:
(define map
  (lambda (f ls . more)
    (if (null? more)
        (let map1 ([ls ls])
          (if (null? ls)
              '()
              (cons (f (car ls))
                    (map1 (cdr ls)))))
        (let map-more ([ls ls] [more more])
          (if (null? ls)
              '()
              (cons
                (apply f (car ls) (map car more))
                (map-more (cdr ls) (map cdr more))))))))

;; 将个元素分别进行abs操作，返回新的列表
(map abs '(1 -2 3 -4 5 -6)) ;; (1 2 3 4 5 6) 
;; (apply abs '(1 -2 3 -4 5 -6)) apply 是迭代条用，返回abs的值，但abs不是双目运算符

;; 用两个列表实现双目运算后返回一个结果列表
(map (lambda (x y) (* x y))
     '(1 2 3 4)
     '(8 7 6 5)) ;; (8 14 18 20)
")

(map abs '(1 -2 3 -4 5 -6))

(display "
--------------------------------------------------------------------------------
for-each
 如map但不返回列表；
 保证从左到右执行；
 procedure 不改变参数
procedure: (for-each procedure list1 list2 ...) 
returns: unspecified 
libraries: (rnrs base), (rnrs)

(define for-each
  (lambda (f ls . more)
    (do ([ls ls (cdr ls)] [more more (map cdr more)])
        ((null? ls))
      (apply f (car ls) (map car more))))) 

;; 计算两个列表中相同元素的个数
(let ([same-count 0])
  (for-each
    (lambda (x y)
      (when (= x y)
        (set! same-count (+ same-count 1))))
    '(1 2 3 4 5 6)
    '(2 3 3 4 7 6))
  same-count) ;; 3
")

(display "
--------------------------------------------------------------------------------
判断是否存在procedure满足条件的参数。
- list1 list2 ... 必须长度相等
- procedure 参数个数等于列表个数，且不改变列表元素，且返回值被boolean
- 如果列表空，放回#f;
  否则 将lists应用到procedure,直到列表只有一个元素或procedure返回#t
procedure: (exists procedure list1 list2 ...) 
returns: see below 
libraries: (rnrs lists), (rnrs)

(define exists
  (lambda (f ls . more)
    (and (not (null? ls)) ;; ls == null 时退出，参数合法性检查
      (let exists ([x (car ls)] [ls (cdr ls)] [more more])
        (if (null? ls)
            (apply f x (map car more))
            (or (apply f x (map car more))
                (exists (car ls) (cdr ls) (map cdr more))))))))

(exists symbol? '(1.0 #\a "hi" '())) ;; #f 

(exists member
        '(a b c)
        '((c b) (b a) (a c))) ;; (b a) 

(exists (lambda (x y z) (= (+ x y) z))
        '(1 2 3 4)
        '(1.2 2.3 3.4 4.5)
        '(2.3 4.4 6.4 8.6)) ;; #t
")

(display "
--------------------------------------------------------------------------------
一直求值到procedure返回#f
- list1 list2 ... 为空时返回 #t
procedure: (for-all procedure list1 list2 ...) 
returns: see below 
libraries: (rnrs lists), (rnrs)

(define for-all
  (lambda (f ls . more)
    (or (null? ls)
      (let for-all ([x (car ls)] [ls (cdr ls)] [more more])
        (if (null? ls)
            (apply f x (map car more))
            (and (apply f x (map car more))
                 (for-all (car ls) (cdr ls) (map cdr more))))))))

(for-all symbol? '(a b c d)) ;; #t 

(for-all =
         '(1 2 3 4)
         '(1.0 2.0 3.0 4.0)) ;; #t 

(for-all (lambda (x y z) (= (+ x y) z))
         '(1 2 3 4)
         '(1.2 2.3 3.4 4.5)
         '(2.2 4.3 6.5 8.5)) ;; #f

--------------------------------------------------------------------------------
左则叠，从左往右的折叠调用procedure
procedure: (fold-left procedure obj list1 list2 ...) 
returns: see below 
libraries: (rnrs lists), (rnrs)

(fold-left cons '() '(1 2 3 4)) ;; ((((() . 1) . 2) . 3) . 4) 

(fold-left
  (lambda (a x) (display x) (newline) (+ a (* x x)))
  0 '(1 2 3 4 5)) ;; 55 

(fold-left
  (lambda (a . args) (append args a))
  '(question)
  '(that not to)
  '(is to be)
  '(the be: or)) ;; (to be or not to be: that is the question)

--------------------------------------------------------------------------------
右则叠
procedure: (fold-right procedure obj list1 list2 ...) 
returns: see below 
libraries: (rnrs lists), (rnrs)

(fold-right cons '() '(1 2 3 4)) ;; (1 2 3 4) 

(fold-right
  (lambda (x a) (display x) (newline) (+ a (* x x)))
  0 '(1 2 3 4 5)) ;; 55 

(fold-right
  (lambda (x y a) (cons* x y a))   ;; (parting is such sweet sorrow
  '((with apologies))                gotta go see ya tomorrow
  '(parting such sorrow go ya)       (with apologies))
  '(is sweet gotta see tomorrow))

--------------------------------------------------------------------------------
类似map，只是参数列表时vector，不是list。
procedure: (vector-map procedure vector1 vector1 ...) 
returns: vector of results 
libraries: (rnrs base), (rnrs)

(vector-map abs '#(1 -2 3 -4 5 -6)) ;; #(1 2 3 4 5 6)
(vector-map (lambda (x y) (* x y))
  '#(1 2 3 4)
  '#(8 7 6 5)) ;; #(8 14 18 20)

--------------------------------------------------------------------------------
类似 for-each
procedure: (vector-for-each procedure vector1 vector2 ...) 
returns: unspecified 
libraries: (rnrs base), (rnrs)

(let ([same-count 0])
  (vector-for-each
    (lambda (x y)
      (when (= x y)
        (set! same-count (+ same-count 1))))
    '#(1 2 3 4 5 6)
    '#(2 3 3 4 7 6))
  same-count) ;; 3

--------------------------------------------------------------------------------

procedure: (string-for-each procedure string1 string2 ...) 
returns: unspecified 
libraries: (rnrs base), (rnrs)

(let ([ls '()])
  (string-for-each
    (lambda r (set! ls (cons r ls)))
    "abcd"
    "===="
    "1234")
  (map list->string (reverse ls))) ;; ("a=1" "b=2" "c=3" "d=4")
")

(let ([ls '()])
  (string-for-each
    (lambda r (display r)(newline)(set! ls (cons r ls)))
    "abcd"
    "===="
    "1234")
  (map list->string (reverse ls)))


(display "
Section 5.6. Continuations(延续 *重点理解* )
- 延续是过程，可以被调用。
- 延续保存了计算节点的剩余过程。
- 延续可以实现断点调试、过程中途退出、协程、并发等各类高级应用场景。
- call/cc获得它的继续并将它传递给procedure，它应该接受一个参数。
- 调用延续，将放回相应处理值

procedure: (call/cc procedure) 
procedure: (call-with-current-continuation procedure) 
returns: see below 
libraries: (rnrs base), (rnrs)

;;; nonlocal exit example
(define member
  (lambda (x ls)
    ;;; 捕获后续作用域，构造一个当前后续具体的表示并传递给 p
    (call/cc
     ;; 捕获的参数是一个过程 p; 如lambda(break) ,lambda 接受一个参数
     ;; 后续自生是一个过程 k;
     ;; 每当 k 被以值 val 应用时， 其返回call/cc过程(后续操作val后)的值。并成为call/cc过程的新值
      (lambda (break)
        (do ([ls ls (cdr ls)])
            ((null? ls) #f)
          (when (equal? x (car ls))
            (break ls)))))))
(member 'd '(a b c)) ;; #f
(member 'b '(a b c)) ;; (b c)
")

;;; p = (lambda (k) (* 5 4))
;;; k = continuation, 此处未调用
(call/cc
 (lambda (k)
   (* 5 4)))

(call/cc
 (lambda (k)
   (* 5
      ;; 此处调用 k, 参数为 4, 则 p 返回值为 4
      ;; 捕获了 4 表达式求值后的 后续过程
      ;; call/cc的值为 4, 后续过程在 k调用 处
      (k 4))))

(+ 2
  (call/cc
 (lambda (k)
   (* 5
      (k 4)))))

(define product
  (lambda (ls)
    (call/cc
      (lambda (break)
        (let f ([ls ls])
          (cond
            [(null? ls) 1]
            [(= (car ls) 0) (break 0)]
            [else
             (display (list '* (car ls)))(newline)
             (* (car ls) (f (cdr ls)))]))))))
(product '(1 2 3 4 5))
(product '(7 3 8 0 1 9 5))

(define self-cc
  (call/cc (lambda (k) k)))

(self-cc
 (self-cc
  (lambda (x) "hello")))

(define retry #f)
(define factorial
  (lambda (x)
    (if (= x 0)
        (call/cc (lambda (k)
                   (display 'set-k) (newline)
                   (set! retry k) 1))
        (begin
          (display (list '+ x)) (newline)
          (+ x (factorial (- x 1)))))))
(factorial 4)
retry
;;; 2 * 24 = 48
(retry 2)
;;; 8 * 24 = 0
(retry 0)
(retry 100)

(define lwp-list '())
(define lwp
  (lambda (thunk)
    (set! lwp-list (append lwp-list (list thunk))))) 

(define start
  (lambda ()
    (let ([p (car lwp-list)])
      (set! lwp-list (cdr lwp-list))
      (p))))

(define pause
  (lambda ()
    (call/cc
      (lambda (k)
        (lwp (lambda () (k #f)))
        (start)))))

(lwp (lambda () (let f () (pause) (display "h") (f))))
(lwp (lambda () (let f () (pause) (display "e") (f))))
(lwp (lambda () (let f () (pause) (display "y") (f))))
(lwp (lambda () (let f () (pause) (display "!") (f))))
(lwp (lambda () (let f () (pause) (newline) (f))))
(start)

(display "
--------------------------------------------------------------------------------
提供进入/离开后续的保护
- in/body/out 都是无参数过程
- in 进入前过错
- body 过程
- out 离开后执行的过程
procedure: (dynamic-wind in body out) 
returns: values resulting from the application of body 
libraries: (rnrs base), (rnrs)
")

(let ([p (open-input-file "/tmp/aaa.txt")])
  (dynamic-wind
    (lambda () (display "in") (newline) #f)
    (lambda () (display "body") (newline) (process p))
    (lambda () (display "out") (newline) (close-port p))))

(display "
================================================================================
Section 5.7. Delayed Evaluation
  延后计算
- 在需要时计算
- 一旦计算，不会被重新计算
- 常仅在没有副作用的情况下使用，

syntax: (delay expr) 
returns: a promise 
procedure: (force promise) 
returns: result of forcing promise 
libraries: (rnrs r5rs)

;;; 下面的示例显示了如何使用延迟和强制构建流抽象。
(define stream-car
  (lambda (s)
    (car (force s))))

(define stream-cdr
  (lambda (s)
    (cdr (force s))))

(define counters
  (let next ([n 1])
    (delay (cons n (next (+ n 1))))))

(stream-car counters) <graphic> 1
(stream-car (stream-cdr counters)) <graphic> 2

(define stream-add
  (lambda (s1 s2)
    (delay (cons
             (+ (stream-car s1) (stream-car s2))
             (stream-add (stream-cdr s1) (stream-cdr s2))))))

(define even-counters
  (stream-add counters counters))

(stream-car even-counters) <graphic> 2 

(stream-car (stream-cdr even-counters)) <graphic> 4

;;; 实现伪代码
delay may be defined by

(define-syntax delay
  (syntax-rules ()
    [(_ expr) (make-promise (lambda () expr))]))

where make-promise might be defined as follows.

(define make-promise
  (lambda (p)
    (let ([val #f] [set? #f])
      (lambda ()
        (unless set?
          (let ([x (p)])
            (unless set?
              (set! val x)
              (set! set? #t))))
        val))))

With this definition of delay, force simply invokes the promise to force
evaluation or to retrieve the saved value.

(define force
  (lambda (promise)
    (promise)))
")

(display "
================================================================================
Section 5.8. Multiple Values
 多值问题

问题：将列表拆分成2个列表，就需要返回多值。
方案1：将多值放到数据结构中，由消费者提取。
方案2：使用内置的多值支持，比方案1更加简介；

多值接口由2个过程组成： values，call-with-values
values:生产多值
call-with-values:消费多值

procedure: (values obj ...) 
returns: obj ... 
libraries: (rnrs base), (rnrs)

procedure: (call-with-values producer consumer) 
returns: see below 
libraries: (rnrs base), (rnrs)

(values) <graphic>

(values 1) <graphic> 1 

(values 1 2 3) <graphic> 1
                2
                3 

(define head&tail
  (lambda (ls)
    (values (car ls) (cdr ls)))) 

(head&tail '(a b c)) <graphic> a
                      (b c)


(call-with-values
  (lambda () (values 'bond 'james))
  (lambda (x y) (cons y x))) <graphic> (james . bond) 

(call-with-values values list) <graphic> '()

;; 计算线段的长度和斜率
(define segment-length
  (lambda (p1 p2)
    (call-with-values
      (lambda () (dxdy p1 p2))
      (lambda (dx dy) (sqrt (+ (* dx dx) (* dy dy))))))) 

(define segment-slope
  (lambda (p1 p2)
    (call-with-values
      (lambda () (dxdy p1 p2))
      (lambda (dx dy) (/ dy dx)))))

(segment-length '(1 . 4) '(4 . 8)) <graphic> 5
(segment-slope '(1 . 4) '(4 . 8)) <graphic> 4/3

(define describe-segment
  (lambda (p1 p2)
    (call-with-values
      (lambda () (dxdy p1 p2))
      (lambda (dx dy)
        (values
          (sqrt (+ (* dx dx) (* dy dy)))
          (/ dy dx)))))) 

(describe-segment '(1 . 4) '(4 . 8)) <graphic> 5
                                     <graphic> 4/3

(define split
  (lambda (ls)
    (if (or (null? ls) (null? (cdr ls)))
        (values ls '())
        (call-with-values
          (lambda () (split (cddr ls)))
          (lambda (odds evens)
            (values (cons (car ls) odds)
                    (cons (cadr ls) evens))))))) 

(split '(a b c d e f)) <graphic> (a c e)
                        (b d f)

(if (values 1 2) 'x 'y)

(+ (values) 5)

(define-syntax first
  (syntax-rules ()
    [(_ expr)
     (call-with-values
       (lambda () expr)
       (lambda (x . y) x))]))

(if (first (values #t #f #t)) 'a 'b) <graphic> a

(call-with-values
  (lambda () (call/cc (lambda (k) (k 0 1))))
  (lambda (x y) x))
")

(define cc #f)
(call/cc
 (lambda (k)
   (display 'aaa) (newline)
   (display 'bbb) (newline)
   (set! cc k)
   (k 'ccc)
   (display 'ddd) (newline)
   (display 'eee) (newline)
   ))
cc
(cc 1)

(display "
================================================================================
Section 5.9. Eval
Scheme的eval过程允许程序员编写构建和计算其他程序的程序。
这种运行时元编程的能力不应过度使用，但在需要时很方便。（运行时编程）

- obj 必须时有效的表达式
- evnironment，scheme-report-environment和null-environment返回的环境是不可变的。
procedure: (eval obj environment) 
returns: values of the Scheme expression represented by obj in environment 
libraries: (rnrs eval)


(define cons 'not-cons)
(eval '(let ([x 3]) (cons x 4)) (environment '(rnrs))) <graphic> (3 . 4) 

(define lambda 'not-lambda)
(eval '(lambda (x) x) (environment '(rnrs))) <graphic> #<procedure> 

(eval '(cons 3 4) (environment)) <graphic> exception

procedure: (environment import-spec ...) 
returns: an environment 
libraries: (rnrs eval)

procedure: (null-environment version) 
procedure: (scheme-report-environment version) 
returns: an R5RS compatibility environment 
libraries: (rnrs r5rs)
")