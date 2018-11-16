#!/usr/bin/scheme --script

(display "
================================================================================
Section 6.6.Flonums
")

(flonum? 0) ;; #f
(flonum? 3/4) ;; #f
(flonum? 3.5) ;; #t
(flonum? .02) ;; #t
(flonum? 1e10) ;; #t
(flonum? 3.0+0.0i) ;; #f

