#!/usr/bin/scheme --script

;; 打印脚本参数
(for-each
 (lambda (x) (display x) (newline))
 (cdr (command-line)))

;; implements the triditional Unix echo command
;; 实现传统的 Unix echo 命令
(let ([args (cdr (command-line))])
  (unless (null? args)
          (let-values ([(newline? args)
                        (if (equal? (car args) "-n")
                            (values #f (cdr args))
                            (values #t args))])
            (do ([args args (cdr args)] [sep "" " "])
                ((null? args))
              (printf "~a~a" sep (car args)))
            (when newline? (newline)))))

(display "2.1.4 常量表达式")(newline)
(display "      原则：常量的值是常量自身")(newline)
(display "      字符串: 直接用双引号包含")(newline)
(display "\"this is string constant\"")(newline)
(display "      数值: 本身")(newline)
(display 3.2415926)(newline)
(display '(a b c d))(newline)

(display "5. define a procedure(过程定义)")(newline)
(display "   sample: (define square (lambda (n)(* n n)))")(newline)
(define square
  (lambda (n)
    (* n n)))
(display "   call: (square 3) => 9")(newline)
(display (square 3))(newline)
(display "倒数:
(define reciprocal
  (lambda (n)
     (if (= n 0)
         \"oops!\"
         (/ 1 n))))")(newline)
(define reciprocal
  (lambda (n)
    (if (= n 0)
        "oops!"
        (/ 1 n))))
(display "call: (reciprocal 3)")(newline)
(display (reciprocal 3))(newline)
(display "call: (reciprocal 0)")(newline)
(display (reciprocal 0))(newline)

(display "5.2 简单表达式")(newline)
(display "5.2.1 数值: 精确整数(任意精度)/不精确整数/有理数/实数/复数*")(newline)
(display "5.2.2 算术过程: +,-,*,/")(newline)
(display "5.2.3 前序标记法: 无优先级\\简化连续参数")(newline)
(display "5.2.4 嵌套")(newline)
(display "      (/ (* 6/7 7/2) (- 4.5 1.5)) => 1.0")(newline)
(display "5.2.5 聚合数据 aggregate data structures ")(newline)
(display "5.2.6 列表 '(1 2 3) (quote (1 2 3))")(newline)
(display "5.2.7 '(1 2 3) (quote (1 2 3))")(newline)
(display "5.2.8 符号与变量 symbol and variable")(newline)
(display "      (quote hello) 视hello为符号不是辩论")(newline)
(display "5.2.9 程序与数据同质")(newline)
(display "5.2.10 常量引用即自身 '1 => 1 (quote \"hello\") => \"hello\"")(newline)
(display "2.11 列表操作")(newline)
(display "       '(a b c)")(newline)
(display "       (car '(a b c)) => a")(newline)
(display "       (cdr '(a b c)) => (b c)")(newline)
(display "       improper/dotted list(点列表)")(newline)
(display "       (a . b) [a.b]")(newline)
(display "       proper list(常规列表)")(newline)
(display "       (a b) [a.-]->[b.0]")(newline)
(display "2.3 表达式求值 Evaluation Expressions")(newline)
(display "      核心句法 常量、过程、引用")(newline)
(display "      扩展句法 let,lambda")(newline)
(display "      顺序：从左到右")(newline)
(display "2.4 let 局部变量,及变量覆盖")(newline)
(display "      (let ([x 1] [y 2]) (+ x y)) => 3")(newline)
(display (let ([x 1] [y 2]) (+ x y)))(newline)
(display "      (let ([x 1]) => 3")(newline)
(display "      ([x 1])(let ([x (+ x 1)]) (+ x x))) => 4")(newline)
(display (let ([x 1])(let ([x (+ x 1)]) (+ x x))))(newline)
(display "2.5 lambda (let 由 lambda 扩展)")(newline)
(display "(let ([x 'a])
  (let ([f (lambda (y) (list x y))])
    (f 'b)))")(newline)
(display "=> ")
(display (let ([x 'a])
           (let ([f (lambda (y) (list x y))])
             (f 'b))))(newline)
(display "lambda form: (lambda (var ...) body1 body2 ...)")(newline)
(display "lambda form: (lambda (参数 ...) (函数体1) (函数体2) ...)")(newline)
(display (lambda (x) (+ x x)))(newline)
(display "lambda 创建过程，过程是一个对象，对象可以作为变量值：")(newline)
(display "double 绑定 #<procedure> ")(newline)
(display "(let ([double (lambda (x) (+ x x))])
  (list (double (* 3 4))
        (double (/ 99 11))
        (double (- 2 7))))")(newline)
(display (let ([double (lambda (x) (+ x x))])
           (list (double (* 3 4))
                 (double (/ 99 11))
                 (double (- 2 7)))))(newline)
(newline)
(display "1级抽象：任意对象的 cons : ")(newline)
(display "(let ([double-cons (lambda (x) (cons x x))])
  (double-cons 'a))")(newline)
(display "=> ")
(display
 (let ([double-cons (lambda (x) (cons x x))])
   (double-cons 'a)))(newline)
(newline)
(display "2级抽象：任意对象的任意操作 double:")(newline)
(display "(let ([double-any (lambda (f x) (f x x))])
   (list (double-any + 13) (double-any cons 'a)))")(newline)
(display "=> ")
(display
 (let ([double-any (lambda (f x) (f x x))])
   (list (double-any + 13) (double-any cons 'a))))
(display "演示过程可以是参数，参数包含一切对象")
(newline)
(newline)
(display "
demo: let/lambda 嵌套：变量作用域雷同")
(newline)
(display "(let ([x 'a])
  (let ([f (lambda (y) (list x y))])
    (f 'b)))")
(newline)
(display "=> ")
(display
 (let ([x 'a])
   (let ([f (lambda (y) (list x y))])
     (f 'b))))
(newline)
(display
 "ps: x是lambda表达式的自由变量(free variable由表达式外部绑定)
ps: y有lambda表达式绑定，不是自由变量
ps: 闭包(enclosing)lambda/let 变量必须被绑定")
(newline)
(display "
demo: 外部同名变量无法影响内部变量，符合变量覆盖原则
(let ([f (let ([x 'sam])
           (lambda (y z) (list x y z)))])
  (let ([x 'not-sam])
    (f 'i 'am)))
=> ")
(display
 (let ([f (let ([x 'sam])
            (lambda (y z) (list x y z)))])
   (let ([x 'not-sam])
     (f 'i 'am))))
(display "
ps: x=not-sam 不能影响到 lambda表达式的 x=sam;
")

(display "
ps: let 与 lambda 等价, let 只是可读性好点, 都是核心句法
ps: (let ([x 'a]) (cons x x)) <=> ((lambda (x) (cons x x)) 'a)
ps: (let ([var expr] ...) body1 body2 ...)
ps: ((lambda (var ...) body1 body2 ...) expr ...)

knowledge:
 lambda 形参不必是常规list，甚至不必是list，以下是合法形参
 1. 常规list (var1 ... varn)，调用必须传n个实参
    (let ([f (lambda (x y) (+ x y))]) (f 3 4)) => 7
 2. 单变量 var-rest，调用参数放入list，实参绑定该list
    (let ([f (lambda x x)]) (f 1 2 3 4)) => (1 2 3 4)
 3. 非常规list (var1 ... varn . var-rest)，前2种情况的结合；类似c的可变参数
    (let ([f (lambda (x y . z) (list x y z))]) (f 'a 'b 'c 'd)) => (a b (c d))
demo:
> (let ([f (lambda (x) x)]) (f 'a))
a
> (let ([f (lambda x x)]) (f 'a))
(a)
> (let ([f (lambda (x . y) x)]) (f 'a))
a
> (let ([f (lambda (x . y) y)]) (f 'a))
()

2.6 Top-Level Definitions (顶层定义，全局作用域)
    let/lambda 变量是局部作用域；
    define 关键字建立(任意对象如变量/过程...)顶层定义，可被全局访问，除非被局部覆盖。

demo: 顶层定义被阴影
(define xyz '(x y z))
(let ([xyz '(a b c)])
  xyz)
=> ")
(define xyz '(x y z))
(display
 (let ([xyz '(a b c)])
   xyz))
(display "

demo: scheme 自带的原始定义(primitive procedures)
; 列表
(define list (lambda x x))
; 获取后续的首项
(define cadr
  (lambda (x)
    (car (cdr x))))
; 后续的后续
(define cddr
  (lambda (x)
    (cdr (cdr x))))

interact:
> (cadr '(a b c d))
b
> (cddr '(a b c d))
(c d)

knowledge: 顶层过程的缩写(不建议使用，保持原味易于理解)
ps: (define v0 (lambda (v1 ...) e1 ...)) <=> (define (v0 v1 ...) e1 ...)
ps: (define v0 (lambda (v1) e1 ...)) <=> (define (v0 . v1) e1...)
ps: (define v0 (lambad (v1 ... vn . vr) e1...)) <=> (define (v0 v1 ... vn . vr) e1...)

demo: 重写原始定义
(define (list . x) x)
(define (cadr x) (car (cdr x)))
(define (cddr x) (cdr (cdr x)))

design: 嵌套lambda,逐级定义
(define doubler
  (lambda (f)
    (lambda (x)
      (f x x))))
(define double (doubler +))

knowledge: lambda 表达式内的未定义变量在被调用前不会报错，
           即lambda定义不检测内部变量是否绑定。
")
(define doubler
  (lambda (f)
    (lambda (x)
      (f x x))))
(define double (doubler +))
(define double-any
  (lambda (f x)
    ((doubler f) x)))
(display "
exercise: 2.6.1 (double-any double-any double-any)
=> #dead-loop
")

(display "
$2.7 Condition Expressions 条件表达式
syntax: (if test consequent alternative)
        (if <测试表达式> <#t body> <#f body>)
demo: 绝对值
(define abs
  (lambda (n)
    (if (< n 0)
        (- 0 n)
        n)))

knowledge: 只有 #f 为假，其他都为真；

> (if '() 'true 'false)
true
> (not #t)
#f

ps: (and/or ...)
ps: (eqv? arg1 arg2) 比较两值是否相等
")

(define reciprocal
  (lambda (n)
  (and (not (= n 0))
       (/ 1 n))))
(display "
knowledge: 类型谓词
ps: pair?,symbol?, number?, and string?
(define reciprocal
  (lambda (n)
    (if (and (number? n) (not (= n 0)))
        (/ 1 n)
        \"opps!\")))
(reciprocal \"not-number\") => ")
(define reciprocal
  (lambda (n)
    (if (and (number? n) (not (= n 0)))
        (/ 1 n)
        "opps!")))
(display (reciprocal "not-number"))
(display "
(reciprocal 2) => ")
(display (reciprocal 2))
(newline)
(display "
knowledge: assertion-violation 断言异常
(define reciprocal
  (lambda (n)
    (if (and (number? n) (not (= n 0)))
        (/ 1 n)
        (assertion-violation 'reciprocal
                             \"improper argument\"
                             n))))
(reciprocal \"str\") => 
")
(define reciprocal
  (lambda (n)
    (if (and (number? n) (not (= n 0)))
        (/ 1 n)
        (assertion-violation 'reciprocal
                             "improper argument"
                             n))))
;(reciprocal "str")

(display "
$: 2.7.2 cond
syntax: (cond (test expr) ... (test expr))
;: if 版本
(define sign
  (lambda (n)
    (if (< n 0)
        -1
        (if (> n 0)
            +1
            0))))
;: cond 版本
(define sign
  (lambda (n)
    (cond
     [(< n 0) -1]
     [(> n 0) +1]
     [else 0])))
(sign -88)
=> ")
;: if 版本
(define sign
  (lambda (n)
    (if (< n 0)
        -1
        (if (> n 0)
            +1
            0))))
;: cond 版本
(define sign
  (lambda (n)
    (cond
     [(< n 0) -1]
     [(> n 0) +1]
     [else 0])))
(display (sign -88))

(display "
ps: cond 测试从左到右顺序,只匹配一次测试
(define incom-tax
  (lambda (incom)
    (cond
     [(<= incom 10000) \"incom * .05\"]
     [(<= incom 20000) \"incom * .08\"]
     [(<= incom 30000) \"incom * .13\"]
     [else \"incom * 0.21\"])))
(incom-tax 31000)
=> ")
(define incom-tax
  (lambda (incom)
    (cond
     [(<= incom 10000) "incom * .05"]
     [(<= incom 20000) "incom * .08"]
     [(<= incom 30000) "incom * .13"]
     [else "incom * 0.21"])))
(display (incom-tax 31000))(newline)
(display "(incom-tax 11000)
=> ")
(display (incom-tax 11000))(newline)

(display "
$: 2.8 Simple Recursion 简单递归(避免死循环)
ps: 递归2要素，基本参数(控制退出)、递归步骤(调整递归参数，必须逼近基本参数)

demo:
(define length
  (lambda (ls)
    (if (null? ls)
        0
        (+ (length (cdr ls)) 1))))

(length '(a b c))
=> ")
(define length
  (lambda (ls)
    (if (null? ls)
        0
        (+ (length (cdr ls)) 1))))

(display (length '(a b c)))(newline)

(display "
tip: (trace procedure-name) 跟踪运行步骤
ps: (trace length)
(length '(a b c))
")
(trace length)
(trace reciprocal)
(length '(a b c))

(display "
demo: 拷贝list系统自带
(define list-copy
  (lambda (ls)
    (if (null? ls)
        '()
        (cons (car ls)
              (list-copy (cdr ls))))))
(trace list-copy)
")
(define list-copy
  (lambda (ls)
    (if (null? ls)
        '()
        (cons (car ls)
              (list-copy (cdr ls))))))
(display "
demo: 树拷贝
(define tree-copy
  (lambda (tr)
    (if (not (pair? tr))
        tr
        (cons (tree-copy (car tr))
              (tree-copy (cdr tr))))))
(trace tree-copy)
(tree-copy '((a . b) . c))
")
(define tree-copy
  (lambda (tr)
    (if (not (pair? tr))
        tr
        (cons (tree-copy (car tr))
              (tree-copy (cdr tr))))))
(trace tree-copy)
(tree-copy '((a . b) . c))
(display "
fun: 箱式列表 '(a b) => [a,-]->[b,0]

")
(define zshow-list
  (lambda (ls)
    (if (null? ls)
        (display '[0,0])
        (display '[1,0]))))
(display "
$: 2.9 Assignment 赋值
")
