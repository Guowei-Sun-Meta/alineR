library(alineR, lib.loc = Sys.getenv("ALIB"))
for (n in c(8, 10, 11, 12, 15, 20, 29, 30, 40, 60, 61, 100)) {
  w <- substr(strrep("ta", 60), 1, n)
  r <- tryCatch(raw.alignment(c(w, w)), error = function(e) e)
  if (inherits(r, "error")) cat(sprintf("n=%3d  R error: %s\n", n, conditionMessage(r)))
  else cat(sprintf("n=%3d  segments in alignment=%3d  identical rows=%s  score=%g\n", n,
                   nchar(gsub("[^a-z]", "", r[[3]])), r[[3]] == r[[4]], r[[2]]))
}
cat("DONE\n")
