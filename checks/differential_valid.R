for (f in commandArgs(TRUE)) { r <- readRDS(f); N <- ncol(r$weighted); enc <- r$encode
  strip <- function(x) gsub("[ |<-]", "", x)
  ok1 <- strip(r$weighted[2, ]) == enc[1:N]; ok2 <- strip(r$weighted[3, ]) == enc[N + 1:N]
  cat(basename(f), ": alignment1 valid", sum(ok1), "/", N, "| alignment2 valid", sum(ok2), "/", N, "\n") }
