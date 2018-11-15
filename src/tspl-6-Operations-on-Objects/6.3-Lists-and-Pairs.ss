#!/usr/bin/scheme --script

(display "
================================================================================
Section 6.3. Lists and Pairs
")

(cons 'a '()) ;; (a)
(cons 'a '(b c)) ;; (a b c)
(cons 3 4) ;; (3 . 4)

(car '(a)) ;; a
(car '(a b c)) ;; a
(car (cons 3 4)) ;; 3

(cdr '(a)) ;; ()
(cdr '(a b c)) ;; (b c)
(cdr (cons 3 4)) ;; 4
;;#(cdr '()) ;; Exception in cdr is not a pair

(let ([x (list 'a 'b 'c)])
  (set-car! x 1)
  x) ;; (1 b c)

(let ([x (list 'a 'b 'c)])
  (set-cdr! x 1)
  x) ;; (a . 1)

(trace car)
(trace cdr)
(cadadr '(a (b c)))
(car (cdr (car (cdr '(a (b c))))))

(list) ;; ()
(list 1 2 3) ;; (1 2 3)
(list 3 2 1) ;; (3 2 1)

(cons* '()) ;; ()
(list '())
(cons* '(a b)) ;; (a b)
(list '(a b))
(cons* 'a 'b 'c) ;; (a b . c)
(list 'a 'b 'c)
(cons* 'a 'b '(c d)) ;; (a b c d)
(list 'a 'b '(c d)) ;; (a b (c d))

(define length
  (lambda (x)
    (define improper-list
      (lambda ()
        (assertion-violation 'length "not a proper list" x))) 

    (let f ([h x] [t x] [n 0])
      (if (pair? h)
          (let ([h (cdr h)])
            (if (pair? h)
                (if (eq? h t)
                    (improper-list)
                    (f (cdr h) (cdr t) (+ n 2)))
                (if (null? h)
                    (+ n 1)
                    (improper-list))))
          (if (null? h)
              n
              (improper-list)))))) 

(length '()) ;; 0
(length '(a b c)) ;; 3
(length '(a b . c)) ;; exception
(length
  (let ([ls (list 'a 'b)])
    (set-cdr! (cdr ls) ls) ;; exception
    ls))
(length
  (let ([ls (list 'a 'b)])
    (set-car! (cdr ls) ls) ;; 2
    ls))

(define list-ref
  (lambda (ls n)
    (if (= n 0)
        (car ls)
        (list-ref (cdr ls) (- n 1))))) 

(list-ref '(a b c) 0) ;; a
(list-ref '(a b c) 1) ;; b
(list-ref '(a b c) 2) ;; c

(list-tail '(a b c) 0) ;; (a b c)
(list-tail '(a b c) 2) ;; (c)
(list-tail '(a b c) 3) ;; ()
(list-tail '(a b c . d) 2) ;; (c . d)
(list-tail '(a b c . d) 3) ;; d
(let ([x (list 1 2 3)])
  (eq? (list-tail x 2)
       (cddr x))) ;; #t

(append '(a b c) '()) ;; (a b c)
(append '() '(a b c)) ;; (a b c)
(append '(a b) '(c d)) ;; (a b c d)
(append '(a b) 'c) ;; (a b . c)
(let ([x (list 'b)])
  (eq? x (cdr (append '(a) x)))) ;; #t


(reverse '()) ;; ()
(reverse '(a b c)) ;; (c b a)


(memq 'a '(b c a d e)) ;; (a d e)
(memq 'a '(b c d e g)) ;; #f
(memq 'a '(b a c a d a)) ;; (a c a d a) 

(memv 3.4 '(1.2 2.3 3.4 4.5)) ;; (3.4 4.5)
(memv 3.4 '(1.3 2.5 3.7 4.9)) ;; #f
(let ([ls (list 'a 'b 'c)])
  (set-car! (memv 'b ls) 'z)
  ls) ;; (a z c) 

(member '(b) '((a) (b) (c))) ;; ((b) (c))
(member '(d) '((a) (b) (c))) ;; #f
(member "b" '("a" "b" "c")) ;; ("b" "c") 

(let ()
  (define member?
    (lambda (x ls)
      (and (member x ls) #t)))
  (member? '(b) '((a) (b) (c)))) ;; #t 

(define count-occurrences
  (lambda (x ls)
    (cond
      [(memq x ls) =>
       (lambda (ls)
         (+ (count-occurrences x (cdr ls)) 1))]
      [else 0]))) 

(count-occurrences 'a '(a b c d a)) ;; 2

(remq 'a '(a b a c a d)) ;; (b c d)
(remq 'a '(b c d)) ;; (b c d) 

(remv 1/2 '(1.2 1/2 0.5 3/2 4)) ;; (1.2 0.5 3/2 4) 

(remove '(b) '((a) (b) (c))) ;; ((a) (c))

(remp odd? '(1 2 3 4)) ;; (2 4)
(remp
  (lambda (x) (and (> x 0) (< x 10)))
  '(-5 15 3 14 -20 6 0 -9)) ;; (-5 15 14 -20 0 -9)

(filter odd? '(1 2 3 4)) ;; (1 3)
(filter
  (lambda (x) (and (> x 0) (< x 10)))
  '(-5 15 3 14 -20 6 0 -9)) ;; (3 6)

(assq 'b '((a . 1) (b . 2))) ;; (b . 2)
(cdr (assq 'b '((a . 1) (b . 2)))) ;; 2
(assq 'c '((a . 1) (b . 2))) ;; #f 

(assv 2/3 '((1/3 . 1) (2/3 . 2))) ;; (2/3 . 2)
(assv 2/3 '((1/3 . a) (3/4 . b))) ;; #f 

(assoc '(a) '(((a) . a) (-1 . b))) ;; ((a) . a)
(assoc '(a) '(((b) . b) (a . c))) ;; #f 

(let ([alist (list (cons 2 'a) (cons 3 'b))])
  (set-cdr! (assv 3 alist) 'c)
  alist) ;; ((2 . a) (3 . c))

(list-sort < '(3 4 2 1 2 5)) ;; (1 2 2 3 4 5)
(list-sort > '(0.5 1/2)) ;; (0.5 1/2)
(list-sort > '(1/2 0.5)) ;; (1/2 0.5)
(list->string
  (list-sort char>?
    (string->list "hello"))) ;; "ollhe"



