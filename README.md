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
| 7 | Buffer overflow on long words | Wrong results / crash | Fixed | [75aff80](https://github.com/Guowei-Sun-Meta/research/commit/75aff803e0318e3b7f580107ca237783272a294b) |
| 8 | Invalid input (empty word, bad code, NA weight) reaches C++ unchecked | Out-of-bounds write / garbage | Fixed | [34e5433](https://github.com/Guowei-Sun-Meta/research/commit/34e543340c09444c3f863a028863ca3d4a623c3d) |
| 9 | Native routines never registered (`R_init_markovchain`) | Package hygiene | 1.2.0 | fix ready: [5a93f72](https://github.com/Guowei-Sun-Meta/research/commit/5a93f72) |
| 10 | `decode.ALINE()` drops only the last invalid character | Wrong decoded alignment | 1.2.0 | fix ready: [d238edd](https://github.com/Guowei-Sun-Meta/research/commit/d238edd) |
| 11 | `ALINE.segments()` ignores its weight arguments | Returns `"Error"` | 1.2.0 |  |
| 12 | Skip penalty `sk` is added, not subtracted, and on a x100 scale | Changes published results | 1.2.0 |  |

**1.1.5 = fixes 1-8.** Issues 8-12 were found in the correctness check (see log); 9-12 are deferred to 1.2.0. Fixes 9 and 10 were made and then reverted from 1.1.5 ([354e7de](https://github.com/Guowei-Sun-Meta/research/commit/354e7de42d563c37f4ce901c74a43a841a602b29), [2a1a14b](https://github.com/Guowei-Sun-Meta/research/commit/2a1a14b70c6e479fb3529640a8d156b8181837b3)); their commits can be re-applied in 1.2.0. 12 needs a decision with Sean, since fixing it changes every published ALINE distance.
