library(alineR, lib.loc = commandArgs(TRUE)[1])
r <- list(
  aline("kərampu", "ləməntuŋ"),
  aline(c("batu", "kərampu"), c("batʊ", "ləməntuŋ")),
  aline("watu", "dat", sim = TRUE),
  ALINE.segments(raw.alignment(c("watu", "dat"))),
  aline(c("batu", "kərampu"), c("batʊ", "ləməntuŋ"), Place = 10),
  do.call("aline", c(list(w1 = c("batu", "kərampu"), w2 = c("batu", "ləməntuŋ")),
          as.list(setNames(c(61,92,51,26,54,38,20,40,31,38,66,72,60), names(formals(raw.alignment)[-1]))))),
  aline(c("ũmlatʃ", "dinnira"), c("omlatʃ", "diŋŋira")))
for (x in r) cat(format(x, digits = 7), "\n")
