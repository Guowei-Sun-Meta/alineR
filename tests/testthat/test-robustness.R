test_that("long words align without corrupting output", {
  for (n in c(10, 12, 15, 20, 30, 45, 60)) {
    w <- substr(strrep("ta", 40), 1, n)
    a <- raw.alignment(c(w, w))
    expect_type(a[[3]], "character")
    # every segment of the word appears in the alignment
    expect_equal(nchar(gsub("[^a-z]", "", a[[3]])), n)
    expect_equal(a[[3]], a[[4]])
    expect_equal(aline(w, w), 0)
  }
})

test_that("words that are too long give an R error, not a crash", {
  w <- strrep("t", 61)
  expect_error(raw.alignment(c(w, "ta")), "too long")
})

test_that("invalid encoded input gives an R error, not a crash", {
  expect_error(raw.alignment(c("Ata", "ta")), "must start with a segment")
  expect_error(raw.alignment(c("t@a", "ta")), "invalid encoded character")
  expect_error(raw.alignment(c("", "ta")), "empty")
  expect_error(raw.alignment("ta"), "exactly two")
  expect_error(raw.alignment(c("ta", "ta"), Place = NA), "non-missing")
})

test_that("mark = TRUE placeholder does not crash aline()", {
  expect_message(expect_error(aline("Èta", "ta", mark = TRUE)), "Invalid character")
})

test_that("ALINE.segments honours non-default weights", {
  a <- raw.alignment(c("watu", "dat"), Place = 10)
  s <- ALINE.segments(a, Place = 10)
  expect_equal(sum(s), a[[2]])
})

test_that("ALINE.segments works when no padding blanks are present", {
  a <- raw.alignment(c("ta", "ta"))
  expect_equal(sum(ALINE.segments(a)), a[[2]])
})

test_that("generate.training writes nothing by default", {
  old <- setwd(tempdir()); on.exit(setwd(old))
  before <- list.files()
  data <- data.frame(dog = c("dog", "perro"), cat = c("cat", "gato"))
  set.seed(1)
  M <- generate.training(raw.data = data, search.size = 20)
  expect_named(M, c("standard_ipa_symbol", "ALINE_symbol"))
  expect_setequal(list.files(), before)
})
