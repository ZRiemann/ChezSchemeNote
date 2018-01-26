#! /usr/bin/scheme --script

(scheme-start
 (lambda fns
   (for-each
    (lambda (fn)
      (printf "loading ~a ..." fn)
      (load fn)
      (printf "~%"))
    fns)
   (new-cafe)))
