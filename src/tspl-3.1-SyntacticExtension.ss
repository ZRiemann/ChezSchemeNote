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
(zlet ((x 3))
      (+ x x))

(display "
================================================================================
The End.
")