;;; Syntactic extensions are defined with define-syntax. define-syntax is similar to define,
;;; except that define-syntax associates a syntactic transformation procedure, or transformer, 
;;; with a keyword (such as let), rather than associating a value with a variable.
(define-syntax zlet #;(The identifier appearing after define-syntax is the name, or keyword, of the syntactic extension being defined)
  (syntax-rules () ;The syntax-rules form is an expression that evaluates to a transformer. 
                    ; auxiliary keywords is nearly always (). An example of an auxiliary keyword is the else of cond. 
                    ; a sequence of one or more rules, or pattern/template pairs.
    [(_ ((x e) ...) b1 b2 ...) ; partten pattern/template pairs
                               ; The pattern should always be a structured expression whose first element is an underscore ( _ ).
                               ; x,e,b1,b2: Pattern variables match any substructure and are bound to that substructure within the corresponding template.
                               ; The notation pat ... in the pattern allows for zero or more expressions matching the ellipsis prototype pat in the input.
     ((lambda (x ...) b1 b2 ...) e ...)])) ; template

(define-syntax zletx
  (syntax-rules ()
    [(_ ((x e) ...) b ...)
     ((lambda (x ...) b ...) e ...)]))

(zletx ([x 1])
    (+ 3 x))

(define-syntax zand
  (syntax-rules ()
    [(_) #t]
    [(_ e) e]
    [(_ e1 e2 e3 ...)
     (if e1 (zand e2 e3 ...) #f)]))

(let ([x 3])(and (not (= x 0)) (/ 1 x)))
; => 1/3

(define-syntax zand-incorrect ; incorrect!
  (syntax-rules ()
    [(_) #t]
    [(_ e1 e2 ...)
     (if e1 (zand-incorrect e2 ...) #f)]))
; => #t

;;; Section 3.3.Continuations

(call/cc
  (lambda (k)
    (* 5 4)))


(define lwp-list '())
(define lwp
  (lambda (thunk)
    (set! lwp-list (append lwp-list (list thunk)))))

(define start
  (lambda ()
    (let ([p (car lwp-list)])
      (set! lwp-list (cdr lwp-list))
      (p))))

(define pause
  (lambda ()
    (call/cc
      (lambda (k)
        (lwp (lambda () (k)))
        (start)))))

(lwp (lambda () (let f () (pause) (display "h") (f))))
(lwp (lambda () (let f () (pause) (display "e") (f))))
(lwp (lambda () (let f () (pause) (display "y") (f))))
(lwp (lambda () (let f () (pause) (display "!") (f))))
(lwp (lambda () (let f () (pause) (newline) (f))))
(start)

(let ([x '(0 1)]) 
  (call/cc 
    (lambda (k)
      (if (null? x)
          (quote ())
          (k (cdr x))
      )
    )
  )

  k
)

(let ([k.n (call/cc (lambda (k) (cons k 0)))])
  (let ([k (car k.n)] [n (cdr k.n)])
    (write n)
    (newline)
    (if (= n 10)
      'done
      (k (cons k (+ n 1))))))

;;; Section 3.6. Libraries
(library (grades)
  (export gpa->grade gpa)
  (import (rnrs))

  (define in-range?
    (lambda (x n y)
      (and (>= n x) (< n y))))

  (define-syntax range-case
    (syntax-rules (- else)
      [(_ expr ((x - y) e1 e2 ...) ... [else ee1 ee2 ...])
       (let ([tmp expr])
         (cond
           [(in-range? x tmp y) e1 e2 ...]
           ...
           [else ee1 ee2 ...]))]
      [(_ expr ((x - y) e1 e2 ...) ...)
       (let ([tmp expr])
         (cond
           [(in-range? x tmp y) e1 e2 ...]
           ...))]))

  (define letter->number
    (lambda (x)
      (case x
        [(a)  4.0]
        [(b)  3.0]
        [(c)  2.0]
        [(d)  1.0]
        [(f)  0.0]
        [else (assertion-violation 'grade "invalid letter grade" x)])))

  (define gpa->grade
    (lambda (x)
      (range-case x
        [(0.0 - 0.5) 'f]
        [(0.5 - 1.5) 'd]
        [(1.5 - 2.5) 'c]
        [(2.5 - 3.5) 'b]
        [else 'a])))

  (define-syntax gpa
    (syntax-rules ()
      [(_ g1 g2 ...)
       (let ([ls (map letter->number '(g1 g2 ...))])
         (/ (apply + ls) (length ls)))])))

(import (grades))
(gpa c a c b b)
(gpa->grade 2.8)
