library(alineR, lib.loc = Sys.getenv("ALIB"))
pairs <- list(c(strrep("a",60), strrep("p",60)), c(strrep("i",60), "k"), c("k", strrep("i",60)),
              c(strrep("pa",30), strrep("ik",30)), c(strrep("aN",30), strrep("uF",30)), c(strrep("tS", 30), strrep("dZ",30)))
for (p in pairs) { r <- raw.alignment(p); cat(nchar(p[1]), nchar(p[2]), "score", r[[2]], "outlen", nchar(r[[3]]), nchar(r[[4]]), "\n") }
for (sk in c(-100, 0, 100)) for (i in 1:50) { set.seed(i); w <- function() paste(sample(letters, sample(1:60,1), TRUE), collapse=""); invisible(raw.alignment(c(w(), w()), sk = sk)) }
cat("DONE\n")
