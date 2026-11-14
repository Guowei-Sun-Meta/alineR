#!/bin/bash
# Correctness checks for alineR 1.1.5 (macOS with Apple clang; R on PATH).
# Usage, from the repo's alineR/ folder:  bash checks/run_checks.sh
set -e
HERE=$(cd "$(dirname "$0")/.." && pwd); W=$(mktemp -d); cd "$W"
echo "work dir: $W"
R CMD build "$HERE/alineR" >/dev/null && TGZ=$(ls alineR_*.tar.gz)
mkdir lib_new lib_old lib_asan
R CMD INSTALL -l lib_new "$TGZ" >/dev/null 2>&1
R CMD INSTALL -l lib_old "$HERE/alineR_archive/alineR_1.1.4.tar.gz" >/dev/null 2>&1

echo "== R CMD check --as-cran"
R CMD check --as-cran --no-manual "$TGZ" > check.txt 2>&1 || true
grep -E 'WARNING$|NOTE$|ERROR$|^Status' check.txt

echo "== paper examples (expected: no diff)"
Rscript "$HERE/checks/paper_examples.R" lib_new 2>/dev/null | diff "$HERE/checks/paper_examples_expected.txt" - && echo OK

echo "== differential test vs 1.1.4"
Rscript "$HERE/checks/differential.R" lib_old old.rds >/dev/null 2>&1
Rscript "$HERE/checks/differential.R" lib_new new.rds >/dev/null 2>&1
Rscript -e 'a <- readRDS("old.rds"); b <- readRDS("new.rds"); s <- sapply(names(a), function(n) identical(a[[n]], b[[n]])); cat("identical:", names(s)[s], "\ndiffer:", names(s)[!s], "\n")'
Rscript "$HERE/checks/differential_valid.R" old.rds new.rds

echo "== AddressSanitizer / UBSan"
R_MAKEVARS_USER="$HERE/checks/Makevars.sanitizers" R CMD INSTALL --no-test-load -l lib_asan "$TGZ" >/dev/null 2>&1
RH=$(R RHOME); RT=$(dirname "$(clang -print-file-name=libclang_rt.asan_osx_dynamic.dylib)")/libclang_rt.asan_osx_dynamic.dylib
for t in sanitizer_long_words sanitizer_worst_case sanitizer_examples_and_bad_input; do
  ALIB=$W/lib_asan R_HOME=$RH DYLD_INSERT_LIBRARIES=$RT ASAN_OPTIONS=detect_leaks=0 \
    "$RH/bin/exec/R" --vanilla --no-echo -f "$HERE/checks/$t.R" > "$t.txt" 2>&1 || true
  echo "$t: sanitizer reports $(grep -caE 'AddressSanitizer|runtime error' "$t.txt"), finished: $(grep -cE 'DONE' "$t.txt")"
done
