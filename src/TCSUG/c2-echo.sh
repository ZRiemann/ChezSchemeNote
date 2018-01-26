#! /usr/bin/scheme --script
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