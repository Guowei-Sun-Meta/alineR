## Resubmission of an archived package

alineR was archived on 2021-04-21 because check problems were not corrected
in time. This version fixes them:

* Examples no longer write files to the working directory
  (`candidate_alignments.csv`, `open.with.excel.csv`).
* The valgrind "Invalid read" in `src/alineR.cpp` is fixed, along with related
  stack buffer overflows for long words. Verified clean with
  AddressSanitizer/UBSan over all examples and tests.

## Test environments

* local macOS (aarch64), R 4.6.2
* win-builder (devel) -- TODO
* (optional) rhub valgrind / sanitizers -- TODO

## R CMD check results

0 errors | 0 warnings | 1 note

* New submission / Package was archived on CRAN.
