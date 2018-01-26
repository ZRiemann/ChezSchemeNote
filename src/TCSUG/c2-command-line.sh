#! /usr/bin/scheme --script
(for-each
 (lambda (x) (display x) (newline))
 (cdr (command-line)))
