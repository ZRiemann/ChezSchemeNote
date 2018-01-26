#! /usr/bin/env scheme-script
;; #! /usr/bin/scheme-script
;; #! /usr/bin/scheme --program
;; implements the triditional Unix echo command
;; 实现传统的 Unix echo 命令
;;(parameterize ([optimize-level 3]) (compile-program "c2-echo-app.sh"))
(import (rnrs))
(let ([args (cdr (command-line))])
  (unless (null? args)
          (let-values ([(newline? args)
                        (if (equal? (car args) "-n")
                            (values #f (cdr args))
                            (values #t args))])
            (do ([args args (cdr args)] [sep "" " "])
                ((null? args))
              (display sep)
              (display (car args)))
              ;(printf "~a~a" sep (car args)))
            (when newline? (newline)))))