#!/usr/bin/scheme --script

(display "
================================================================================
Section 6.9.Vectors
")
(vector)
(vector 'a 'b 'c)

(make-vector 3)
(make-vector 3 'a)

(make-vector 0) <graphic> #()
(make-vector 0 '#(a)) <graphic> #()
(make-vector 5 '#(a)) <graphic> #(#(a) #(a) #(a) #(a) #(a))

(vector-length '#()) <graphic> 0
(vector-length '#(a b c)) <graphic> 3
(vector-length (vector 1 '(2) 3 '#(4 5))) <graphic> 4
(vector-length (make-vector 300)) <graphic> 300

(vector-ref '#(a b c) 0) <graphic> a
(vector-ref '#(a b c) 1) <graphic> b
(vector-ref '#(x y z w) 3) <graphic> w
;;(vector-ref '#(x y z w) 4) <graphic> Exception in vector-ref: 4 is not a valid index for #(x y z w)

(let ([v (vector 'a 'b 'c 'd 'e)])
  (vector-set! v 2 'x)
  v) <graphic> #(a b x d e)

(let ([v (vector 1 2 3)])
  (vector-fill! v 0)
  v) <graphic> #(0 0 0)


(vector->list (vector)) <graphic> ()
(vector->list '#(a b c)) <graphic> (a b c) 

(let ((v '#(1 2 3 4 5)))
  (apply * (vector->list v))) <graphic> 120


(list->vector '()) <graphic> #()
(list->vector '(a b c)) <graphic> #(a b c) 

(let ([v '#(1 2 3 4 5)])
  (let ([ls (vector->list v)])
    (list->vector (map * ls ls)))) <graphic> #(1 4 9 16 25)
