# Regression tests reproducing worked examples from
# Downey, Sun & Norquest (2017), The R Journal 9(1):138-152.
# (The PDF's extracted text renders some IPA symbols as ASCII; e.g. "k@rampu"
# is the IPA word "kərampu".)

test_that("ALINE distance of a single pair matches the paper", {
  expect_equal(aline("kərampu", "ləməntuŋ"), 0.4864198, tolerance = 1e-6)
})

test_that("vectorised ALINE distances match the paper", {
  expect_equal(aline(c("batu", "kərampu"), c("batʊ", "ləməntuŋ")),
               c(0, 0.4864198), tolerance = 1e-6)
})

test_that("encode.ALINE matches the paper", {
  expect_equal(unname(encode.ALINE("diŋŋira")), "digNgNira")
})

test_that("custom mapping example matches the paper", {
  # paper: m1 = "È" mapped to m2 = "o"; equivalent to using "o" directly
  expect_equal(aline(c("ũmlatʃ", "dinnira"), c("omlatʃ", "diŋŋira")),
               c(0.07647059, 0.10810811), tolerance = 1e-6)
  expect_equal(aline(c("ũmlatʃ", "dinnira"), c("Èmlatʃ", "diŋŋira"),
                     m1 = "È", m2 = "o"),
               c(0.07647059, 0.10810811), tolerance = 1e-6)
})

test_that("similarity score, alignment and segment scores match the paper", {
  expect_equal(aline("watu", "dat", sim = TRUE), 50)
  a <- raw.alignment(c("watu", "dat"))
  expect_equal(a[[2]], 50)
  squish <- function(x) gsub(" +", " ", trimws(x))
  expect_equal(squish(a[[3]]), "| - w a t | u")
  expect_equal(squish(a[[4]]), "| d - a t | -")
  s <- ALINE.segments(a)
  expect_equal(s, c(0, 0, 15, 35))
  expect_equal(sum(s), 50)
})

test_that("alignment = TRUE output matches the paper", {
  m <- aline("watu", "dat", alignment = TRUE, sim = TRUE)
  expect_equal(as.character(m["scores", "pair1"]), "50")
})

test_that("changing feature weights matches the paper", {
  expect_equal(aline(c("batu", "kərampu"), c("batʊ", "ləməntuŋ"), Place = 10),
               c(0, 0.4567901), tolerance = 1e-6)
  opts <- c(61, 92, 51, 26, 54, 38, 20, 40, 31, 38, 66, 72, 60)
  names(opts) <- names(formals(raw.alignment)[-1])
  args <- c(list(w1 = c("batu", "kərampu"), w2 = c("batu", "ləməntuŋ")), as.list(opts))
  expect_equal(do.call("aline", args), c(0, 0.5604938), tolerance = 1e-6)
})
