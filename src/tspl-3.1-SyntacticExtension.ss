#!/usr/bin/scheme --script

(display "
================================================================================
扩展句法： 与核心句法同等
示例：let是扩展句法，由（核心句法）lambda expression, procedure expression定义；
提出核心句法意义：核心句法有限，扩展句法无限，理解核心句法有利于快速掌握该语言；
                 核心句法对语言实现是必须的，因为语言实现不能太大保罗所有。
                 编译、解释器首先将扩增语法展开为核心句法；
核心句法组成：top-level define,constants,variables,procedure applications,
             quote expressions,lambda expressions, if expressions,
             set! expressions.
核心句法语法：
    ；程序由1-n个形式/载体/记录组成
    <program> =  <form>*
    ；载体由定义或表达式组成
    <form>	= <definition> | <expression>
    ； 定义由变量定义 或 一组定义组成
    <definition> = <variable definition> | (begin <definition>*)
    ；变量定义格式 (define <variable> <expression>)
    <variable definition> = (define <variable> <expression>)
    ; 表达式由 常量/变量/引用/lambda/if/set!/application 组成
    ; datum(数据)=对象，数值，链表，符号，向量
    <expression> = <constant>
                  |	<variable>
                  |	(quote <datum>)
                  |	(lambda <formals> <expression> <expression>*)
                  |	(if <expression> <expression> <expression>)
                  |	(set! <variable> <expression>)
                  |	<application>
    ；常量由 布尔/数值/字符/字符串
     <constant>	= <boolean> | <number> | <character> | <string>
    ；形参由变量/变量链表/非常规变量链表组成
    <formals> =	<variable>
               |	(<variable>*)
               |	(<variable> <variable>* . <variable>)
    ；应用由1-n个表达式构成
    <application> =	(<expression> <expression>*)
")

(display "
================================================================================
(begin e1 e2 ...) <==> ((lambda() e1 e2 ...))
 扩展句法                核心句法              省略一对括号
")

(display "
================================================================================
句法扩展由 define-syntax 定义。
define 将值(value)/lambda与变量(variable)关联
define-syntax 将过程转换器(transformer)与关键字(keyword)关联

一个简单的let语法扩展定义：
;;; define-syntax 后跟关键词(如:let)
(define-syntax let
  ;;; syntax-rules 求值转换器
  (syntax-rules ()
    ;;; auxiliary keywords 辅助关键字(如cons的else)
    ;;; 规则(rules)或(pattern/template pairs)模式/模板对
    ;;;
    ;;; pattern 指定输入
    ;;; _是一个不错的惯例，指代上面的let
    ;;; pattern variables(x,e,b1,b2) 绑定到template(x,e,b1,b2)中
    ;;; ... 允许0~n个pat(如(x e), b2, e)重复
    [(_ ((x e) ...) b1 b2 ...)
     ;;; template 指定输入转换
     ((lambda (x ...) b1 b2 ...) e ...)]))

(let (x 3) (+ x x))
((lambda (x) (+ x x)) 3)

注意：
* 句法扩展不能被(trace <let>)
* 0~n写1个示例，如 (x e) ...
* 1~n写2个示例，如 b1 b2 ...

")

(define-syntax zlet
  (syntax-rules ()
    [(_ ((x e) ...) b1 b2 ...)
     ((lambda (x ...) b1 b2 ...) e ...)]))

(untrace display)
(display
 (zlet ((x 3))
      (+ x x)))
(untrace display)
(display "
--------------------------------------------------------------------------------
复杂点的句法扩展，带递归
(define-syntax and
  (syntax-rules ()
               [(_) #t]
               [(_ e) e]
               [(_ e1 e2 e3 ...)
                (if e1 (and e2 e3 ...) #f)]))
")
;; (trace define-syntax) ;; Exception in trace: define-syntax is not bound
(define-syntax zand
  (syntax-rules ()
    [(_) #t]
    [(_ e) e]
    [(_ e1 e2 e3 ...)
     (if e1 (and e2 e3 ...) #f)]))

(untrace display)
(display (zand)) (newline)
(display (zand 1)) (newline)
(display (zand #t #t)) (newline)
(display (zand #t #f)) (newline)
(untrace display)

(display "
================================================================================
Section 3.2. More Rescursion
- let 变量不可以出现在 lambda 表达式中，如下是错误示范：
(let ([sum (lambda (ls)
             (if (null? ls)
                 0
                 (+ (car ls) (sum (cdr ls)))))])
  (sum '(1 2 3 4 5))) ;; exception

- 如下是改进示范： 但语法不简洁，需要2个sum
(let ([sum (lambda (sum ls)
             (if (null? ls)
                 0
                 (+ (car ls) (sum sum (cdr ls)))))])
  (sum sum '(1 2 3 4 5))) <graphic> 15

- 使用letrec改进上例不简洁方案
(letrec ([sum (lambda (ls)
                (if (null? ls)
                    0
                    (+ (car ls) (sum (cdr ls)))))])
  (sum '(1 2 3 4 5))) <graphic> 15

READ MORE...
")


(display "
================================================================================
Section 3.3. Continuations
求值必须跟踪的2要素：
1. 计算什么
2. 对值做什么 - Continuation of computation

(if (null? x) (quote ()) (cdr x))
1. 计算 (null? x)
2. 获取计算结构后，决定执行后续操作 '() 或 (cdr x) - 称作计算延续
3. 可分解的continuation
the value of (if (null? x) (quote ()) (cdr x)),
the value of (null? x),
the value of null?,
the value of x,
the value of cdr, and
the value of x (again).

句法： 使用过程 call/cc 捕获 continuation;
       call/cc 以过程 p 为参数，构造一个当前continuation的具体表示(concrete representation)
       并传给 P, continuation 自身表示为一个过程 k. 当k被应用到一个值是，他返回应用程序的延续。
       如果 p 没有调用 k， 返回在是 call/cc 应用程序的值。

示例：利用continuation捕获，计算阶层

")
(display "
================================================================================
The End.
")