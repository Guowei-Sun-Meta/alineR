# alineR CRAN fix

Bringing [alineR](https://cran.r-project.org/package=alineR) back to CRAN (archived 2021-04-21).

## Layout

| Path | Contents |
|:--|:--|
| `alineR/` | Working copy of the package being fixed |
| `alineR_archive/alineR_1.1.4/` | Original CRAN 1.1.4 source, untouched (reference) |
| `alineR_archive/alineR_1.1.4.tar.gz` | Original CRAN 1.1.4 tarball (for `install.packages(..., repos = NULL)`) |
| `alineR_debugging.Rmd` | Debugging log: details and verification of each fix |
| `alineR_ An R Package ... .pdf` | The R Journal paper (2017) |

## Issues

Each fix is one commit on top of the [baseline](https://github.com/Guowei-Sun-Meta/research/commit/d07e559fc542a93e33a9c6c4595bccf5d4323b10) (untouched 1.1.4), so its link shows only the package code change. Documentation is committed separately.

| # | Issue | Why it matters | Status | Change |
|:--|:--|:--|:--|:--|
| 1 | C++ reads 13 weights from a 12-element vector | Caused archival (valgrind) | Fixed | [64e665a](https://github.com/Guowei-Sun-Meta/research/commit/64e665a35c220b6bad4863df4433625d935b1226) |
| 2 | Examples write CSV files to the working directory | Caused archival | Fixed | [e2be357](https://github.com/Guowei-Sun-Meta/research/commit/e2be357472108219030bc46bc96923018b47035d) |
| 3 | Version equals archived 1.1.4 | Blocks resubmission | Fixed | [5f016bf](https://github.com/Guowei-Sun-Meta/research/commit/5f016bf371c70c1564dd4ccb1c3502db1fe4a7c5) |
| 4 | Two moved URLs | NOTE | Fixed | [36d02b5](https://github.com/Guowei-Sun-Meta/research/commit/36d02b5b6add27adcb9487f1c9bf9ea6e7eb7e6b) |
| 5 | Invalid package alias `aline-package` | NOTE | Fixed | [c26891b](https://github.com/Guowei-Sun-Meta/research/commit/c26891b3f482cc6fcc4c4473cb10c56e71fa4e38) |
| 6 | Template keywords `~kwd1`, `~kwd2` | NOTE | Fixed | [4aef4e2](https://github.com/Guowei-Sun-Meta/research/commit/4aef4e24863106c9808d5881a30cbc200d5595da) |
| 7 | Buffer overflow on long words | Wrong results / crash | Open |  |
