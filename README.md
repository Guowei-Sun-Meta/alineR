# alineR CRAN fix

Bringing [alineR](https://cran.r-project.org/package=alineR) back to CRAN (archived 2021-04-21).

## Layout

| Path | Contents |
|:--|:--|
| `alineR/` | Working copy of the package being fixed |
| `alineR_archive/alineR_1.1.4/` | Original CRAN 1.1.4 source, untouched (reference) |
| `alineR_archive/alineR_1.1.4.tar.gz` | Original CRAN 1.1.4 tarball (for `install.packages(..., repos = NULL)`) |
| `alineR_debugging.Rmd` | Debugging log: details and verification of each fix |
| `SUBMISSION.md` | Steps to check and submit 1.1.5 to CRAN |
| `checks/` | Correctness checks (`bash checks/run_checks.sh`) |
| `alineR_ An R Package ... .pdf` | The R Journal paper (2017) |

## Issues

Each fix is one commit on top of the [baseline](https://github.com/Guowei-Sun-Meta/alineR/commit/dba2ff881c7829d9d971b1875e7828f63637c9e8) (untouched 1.1.4), so its link shows only the package code change. Documentation is committed separately.

| # | Issue | Why it matters | Status | Change |
|:--|:--|:--|:--|:--|
| 1 | C++ reads 13 weights from a 12-element vector | Caused archival (valgrind) | Fixed | [86c8a42](https://github.com/Guowei-Sun-Meta/alineR/commit/86c8a42738b6d59c228b92ddd2267d005c42141d) |
| 2 | Examples write CSV files to the working directory | Caused archival | Fixed | [1281733](https://github.com/Guowei-Sun-Meta/alineR/commit/128173394a0b89b07b99b3dd90badb7109c671e9) |
| 3 | Version equals archived 1.1.4 | Blocks resubmission | Fixed | [45cacfb](https://github.com/Guowei-Sun-Meta/alineR/commit/45cacfbe0fa50f307bb03d905dfebf6faa60b66a) |
| 4 | Two moved URLs | NOTE | Fixed | [6ddb544](https://github.com/Guowei-Sun-Meta/alineR/commit/6ddb544cc38d3ac00a1811598294f253dc7522cb) |
| 5 | Invalid package alias `aline-package` | NOTE | Fixed | [97a7dc9](https://github.com/Guowei-Sun-Meta/alineR/commit/97a7dc90467dea62ccffadfe05df084e55eee35a) |
| 6 | Template keywords `~kwd1`, `~kwd2` | NOTE | Fixed | [0bf502b](https://github.com/Guowei-Sun-Meta/alineR/commit/0bf502b13f0b17466e42c781cba1a8410ff95fd3) |
| 7 | Buffer overflow on long words | Wrong results / crash | Fixed | [1176c73](https://github.com/Guowei-Sun-Meta/alineR/commit/1176c73055f40046cd5310bfd419698242050f46) |
| 8 | Invalid input (empty word, bad code, NA weight) reaches C++ unchecked | Out-of-bounds write / garbage | Fixed | [b0298da](https://github.com/Guowei-Sun-Meta/alineR/commit/b0298da60158ef121575245f584332f1307ae65b) |
