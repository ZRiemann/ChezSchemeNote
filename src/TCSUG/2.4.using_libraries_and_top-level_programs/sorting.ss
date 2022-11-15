(library (A) (export a)
  (import (rnrs))
  (define-syntax a
    (lambda (x)
      (syntax-case x ()
        [(_ id) (free-identifier=? #'id #'undefined)]))))