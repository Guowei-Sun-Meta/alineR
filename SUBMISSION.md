# Submitting alineR 1.1.5 to CRAN

Steps to reproduce the 1.1.5 submission from this repo. The submitter must be the
Maintainer in `DESCRIPTION` (currently Sean Downey, `sean@codexdata.com`): CRAN
sends the confirmation email and the remote check results there.

## 0. Prerequisites (once)

```r
install.packages(c("devtools", "rhub", "tinytex"))
tinytex::install_tinytex()   # LaTeX, for the PDF manual check
```

Also needed: pandoc (bundled with RStudio) and, on macOS, the Xcode command line
tools (`xcode-select --install`).

If the check reports `pdflatex is not available` (ERROR/WARNING for the PDF
manual, plus a NOTE about `alineR-manual.tex`), TinyTeX is installed but not on
the `PATH`. Either run `sudo ~/Library/TinyTeX/bin/universal-darwin/tlmgr path add`,
or, without admin rights, add this line to `~/.Renviron` and restart R:

```text
PATH="${HOME}/Library/TinyTeX/bin/universal-darwin:${PATH}"
```

The NOTE "'tidy' doesn't look like recent enough HTML Tidy" is local only (macOS
ships a 2006 `tidy`); CRAN has a current one. To skip it locally:
`_R_CHECK_RD_VALIDATE_RD2HTML_=false R CMD check --as-cran ...`, or install
[tidy-html5](https://www.html-tidy.org/).

## 1. Get the source and build

```bash
git clone https://github.com/Guowei-Sun-Meta/alineR.git
cd alineR
R CMD build alineR            # -> alineR_1.1.5.tar.gz
```

Always check and submit the built tarball, not the folder.

## 2. Local check

```bash
R CMD check --as-cran alineR_1.1.5.tar.gz
```

Expected: `Status: 1 NOTE`, the CRAN incoming NOTE ("New submission / Package
was archived on CRAN"). Anything else must be fixed first. Optional, macOS:
`bash checks/run_checks.sh` reruns the paper-example, differential and
sanitizer checks described in `alineR_debugging.Rmd`.

## 3. Remote checks (results are emailed to the Maintainer, ~30-60 min)

```r
devtools::check_win_devel("alineR")     # required by CRAN: R-devel on Windows
devtools::check_win_release("alineR")
devtools::check_mac_release("alineR")
```

Memory checks (the reason alineR was archived), without GitHub Actions:

```r
rhub::rc_new_token()                                   # once; confirms your email
rhub::rc_submit("alineR", platforms = c("valgrind", "clang-asan", "clang-ubsan"))
```

Expected: no NOTEs beyond the incoming one; valgrind, ASan and UBSan with no errors.

## 4. Submission comments

Paste into the "Optional comment" field of the form (update the test
environments with what you actually ran):

```text
## Resubmission of an archived package

alineR was archived on 2021-04-21 because check problems were not corrected
in time. Version 1.1.5 fixes them:

* valgrind "Invalid read of size 4" in src/alineR.cpp: the C++ read 13 feature
  weights from a 12-element vector. Fixed; related C++ buffer overflows for
  long words and unchecked invalid input were also fixed (verified with
  AddressSanitizer/UBSan).
* Examples no longer write files to the working directory
  (generate.training() now defaults to table = FALSE; the example writes to
  tempdir()).
* Moved URLs replaced by DOIs; Rd alias and keyword NOTEs fixed.

## Test environments

* local macOS (aarch64), R 4.6.2
* win-builder: R-devel, R-release
* mac builder: R-release
* R-hub: valgrind, clang-asan, clang-ubsan

## R CMD check results

0 errors | 0 warnings | 1 note

* New submission / Package was archived on CRAN.
```

## 5. Submit

1. Upload `alineR_1.1.5.tar.gz` at <https://cran.r-project.org/submit.html>,
   with the Maintainer's name and email and the comments above.
2. Click the confirmation link CRAN emails to the Maintainer.
3. Answer reviewer emails within about two weeks. For a resubmission after
   changes: bump nothing, rebuild, re-run steps 2-3, and start the comments
   with "This is a resubmission. In this version I have: ...".

## 6. After acceptance

- Check results: <https://cran.r-project.org/web/checks/check_results_alineR.html>
- Tag the release in this repo: `git tag -a alineR-1.1.5 -m "alineR 1.1.5 on CRAN" && git push origin alineR-1.1.5`
