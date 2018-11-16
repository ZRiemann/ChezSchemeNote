#!/usr/bin/scheme --script

(display "
================================================================================
Section 7.2.OpeningFiles
")

(buffer-mode? 'block) ;; #t
(buffer-mode? 'line) ;; #t
(buffer-mode? 'none) ;; #t
(buffer-mode? 'something-else) ;; #f
(define buffer-mode-universe-list
  (enum-set->list
   ))
