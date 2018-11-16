#!/usr/bin/scheme --script

(display "
================================================================================
Section 7.1.Transcoders
")

(native-transcoder)
(native-eol-style)
(eol-style none)
(latin-1-codec)
(utf-8-codec)
(utf-16-codec)

(error-handling-mode replace)
