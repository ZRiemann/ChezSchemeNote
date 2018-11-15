#!/usr/bin/scheme --script

(display "
================================================================================
6.1 Constants and Quotation
")

3.2 ;; 3.2
'aaa

(+ 2 3) ;; 5
'(+ 2 3) ;; (+ 2 3)
(quote (+ 2 3)) ;; (+ 2 3)
'a ;; a
'cons ;; cons
'() ;; ()
'7 ;; 7

(display "
--------------------------------------------------------------------------------
(qusiquote obj ...)
")

`(+ 2 3) ;; (+ 2 3) 

`(+ 2 ,(* 3 4)) ;; (+ 2 12)
`(a b (,(+ 2 3) c) d) ;; (a b (5 c) d)
`(a b ,(reverse '(c d e)) f g) ;; (a b (e d c) f g)
(let ([a 1] [b 2])
  `(,a . ,b)) ;; (1 . 2) 
(let ([a 1] [b 2])
  `(a . b)) ;; (a . b) 

`(+ ,@(cdr '(* 2 3))) ;; (+ 2 3)
;;; ,@() 作用将列表内容剥离出来，拼接
`(+ ,(cdr '(* 2 3))) ;; (+ (2 3))
`(a b ,@(reverse '(c d e)) f g) ;; (a b e d c f g)
(let ([a 1] [b 2])
  `(,a ,@b)) ;; (1 . 2)
`#(,@(list 1 2 3)) ;; #(1 2 3) 

'`,(cons 'a 'b) ;; `,(cons 'a 'b)
`',(cons 'a 'b) ;; '(a . b)

`(a (unquote) b) ;; (a b)
`(a (unquote (+ 3 3)) b) ;; (a 6 b)
`(a (unquote (+ 3 3) (* 3 3)) b) ;; (a 6 9 b)
`(a ,(+ 3 3) ,(* 3 3) b) ;; 注意,()
`(a (+ 3 3) (* 3 3) b)   ;; 没有 ,() 就没有反引用

(let ([x '(m n)]) ``(a ,@,@x f)) ;; `(a (unquote-splicing m n) f)
(let ([x '(m n)])
  (eval `(let ([m '(b c)] [n '(d e)]) `(a ,@,@x f))
        (environment '(rnrs)))) ;; (a b c d e f)