#!/usr/bin/scheme --script

(display "
================================================================================
Section 6.8.String
")

(string=? "mom" "mom") ;; #t
(string<? "mom" "mommy") ;; #t
(string>? "Dad" "Dad") ;; #f
(string=? "Mom and Dad" "mom and dad") ;; #f
(string<? "a" "b" "c") ;; #t

(string-ci=? "Mom and Dad" "mom and dad") ;; #t
(string-ci<=? "say what" "Say What!?") ;; #t
(string-ci>? "N" "m" "L" "k") ;; #t
(string-ci=? "Straße" "Strasse") ;; #t

(string) ;; ""
(string #\a #\b #\c) ;; "abc"
(string #\H #\E #\Y #\!) ;; "HEY!"

(make-string 0) ;; ""
(make-string 5) ;; "\x0;\x0;\x0;\x0;\x0;"
(make-string 0 #\x) ;; ""
(make-string 5 #\x) ;; "xxxxx"

(string-length "abc") ;; 3
(string-length "") ;; 0
(string-length "hi there") ;; 8
(string-length (make-string 1000000)) ;; 1000000

(string-ref "hi there" 0) ;; #\h
(string-ref "hi there" 5) ;; #\e


(let ([str (string-copy "hi three")])
  (string-set! str 5 #\e)
  (string-set! str 6 #\r)
  str) ;; "hi there"

(string-copy "abc") ;; "abc" 

(let ([str "abc"])
  (eq? str (string-copy str))) ;; #f

(string-append) ;; ""
(string-append "abc" "def") ;; "abcdef"
(string-append "Hey " "you " "there!") ;; "Hey you there!"

(substring "hi there" 0 1) ;; "h"
(substring "hi there" 3 6) ;; "the"
(substring "hi there" 5 5) ;; "" 

(let ([str "hi there"])
  (let ([end (string-length str)])
    (substring str 0 end))) ;; "hi there"

(let ([str (string-copy "sleepy")])
  (string-fill! str #\Z)
  str) ;; "ZZZZZZ"

(string-upcase "Hi") ;; "HI"
(string-downcase "Hi") ;; "hi"
(string-foldcase "Hi") ;; "hi" 

(string-upcase "Straße") ;; "STRASSE"
(string-downcase "Straße") ;; "straße"
(string-foldcase "Straße") ;; "strasse"
(string-downcase "STRASSE")  ;; "strasse" 

(string-downcase ";;") ;; ";;" 

(string-titlecase "kNock KNoCK") ;; "Knock Knock"
(string-titlecase "who's there?") ;; "Who's There?"
(string-titlecase "r6rs") ;; "R6rs"
(string-titlecase "R6RS") ;; "R6rs"

(string->list "") ;; ()
(string->list "abc") ;; (#\a #\b #\c)
(apply char<? (string->list "abc")) ;; #t
(map char-upcase (string->list "abc")) ;; (#\A #\B #\C)

(list->string '()) ;; ""
(list->string '(#\a #\b #\c)) ;; "abc"
(list->string
  (map char-upcase
       (string->list "abc"))) ;; "ABC"


