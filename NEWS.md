# alineR 1.1.5

Resubmission after archival (2021-04-21).

## Bug fixes

* Fixed an out-of-bounds read in the C++ entry point: 13 feature weights were
  read from a 12-element vector (reported by valgrind on CRAN).
* Fixed stack buffer overflows for longer words. Alignment buffers were fixed
  at 20/50 characters, so words of about 11+ encoded characters produced
  corrupted alignments and longer words could crash R. Words of up to 60
  encoded characters are now supported; longer words give an R error.
* Invalid input (empty words, unknown encoded characters such as the `@`
  placeholder from `encode.ALINE(mark = TRUE)`, NA weights) now gives an R
  error instead of aborting the R session.
* Native routines are now registered correctly (`R_init_alineR`).
* `ALINE.segments()` now uses the feature weights it is given instead of
  always using the defaults, and no longer fails when an alignment string
  has no padding blanks.
* `decode.ALINE()` now drops every invalid character, not only the last one.

## Changes

* `generate.training()` no longer writes a CSV file by default
  (`table = FALSE`); set `table = TRUE` and `file.out` to write one.
* Updated URLs and DOIs; added regression tests reproducing the worked
  examples in Downey, Sun & Norquest (2017).
