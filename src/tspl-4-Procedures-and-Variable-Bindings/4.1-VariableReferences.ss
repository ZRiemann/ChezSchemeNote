#!/usr/bin/scheme --script

(display "
================================================================================
变量引用
句法：variable
返回：the value of variable

- 标识符(identifier)使用前必须被绑定(bound)到实体，否则句法违规。
- (lambda (...) ...) 内的标识符在lambda被调用前，可以不被绑定。
")

(define var-aaa 'aaa)
var-aaa

list
(define x 'a)
(let ([x 'b])
  (list x x))

(define f
  (lambda (x)
    ;; g 后面被绑定
    (g x)))
(define g
  (lambda (x)
    (+ x x)))
;;; f中的g已经绑定
;;; f被应用时，所有相关变量都已经绑定
(f 3)