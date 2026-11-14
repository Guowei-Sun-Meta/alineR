library(alineR, lib.loc = Sys.getenv("ALIB"))
old <- setwd(tempdir())
for (f in ls("package:alineR")) { pdf(NULL); suppressMessages(example(f, package = "alineR", character.only = TRUE, echo = FALSE)); invisible(dev.off()) }
setwd(old); cat("EXAMPLES DONE\n")
cases <- list(
  empty = quote(raw.alignment(c("", "ta"))),
  NA_word = quote(raw.alignment(c(NA, "ta"))),
  upper_start = quote(raw.alignment(c("Nta", "ta"))),
  at_sign = quote(raw.alignment(c("t@a", "ta"))),
  digit = quote(raw.alignment(c("t1a", "ta"))),
  mark_TRUE = quote(aline("Èta", "ta", mark = TRUE)),
  all_invalid = quote(aline("ÈÈ", "ta")),
  NA_weight = quote(raw.alignment(c("ta", "ta"), Place = NA)),
  one_word = quote(raw.alignment("ta")))
for (n in names(cases)) { r <- tryCatch(suppressMessages(eval(cases[[n]])), error = function(e) paste("R error:", conditionMessage(e)))
  cat(sprintf("%-12s %s\n", n, if (is.character(r) && length(r) == 1) r else "returned a value")) }
cat("EDGE DONE\n")
