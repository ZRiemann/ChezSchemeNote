#!/usr/bin/scheme --script

(display "scheme build server you...")
(newline)

(parameterize 
  ([optimize-level 3])
  (generate-inspector-information #f)
  ; strip-fasl-file
  (compile-program "program.ss")
  (compile-library "sorting.ss"))
(display "try: scheme --program program.so aaa bbb ccc")
(newline)
;(load-program (program))

;;; (lambda fns (for-each load fns) (new-cafe))

