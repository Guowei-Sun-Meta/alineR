lib <- commandArgs(TRUE)[1]; out <- commandArgs(TRUE)[2]
suppressMessages(library(alineR, lib.loc = lib))
res <- list()
m <- show.map(); ipa <- unique(c(m$IPA, letters))
set.seed(42)
# random words whose encoded length is <= 10 (where 1.1.4 is memory-safe)
mk <- function() repeat { w <- paste(sample(ipa, sample(1:6, 1), TRUE), collapse = "")
  e <- suppressMessages(encode.ALINE(w)); if (nchar(e) >= 1 && nchar(e) <= 10 && grepl("^[a-z]", e)) return(w) }
N <- 1500
w1 <- replicate(N, mk()); w2 <- replicate(N, mk())
W <- t(replicate(N, sample(0:100, 13, TRUE)))
res$encode <- suppressMessages(encode.ALINE(c(w1, w2)))
res$dist <- suppressMessages(aline(w1, w2))
res$sim  <- suppressMessages(aline(w1, w2, sim = TRUE))
res$algn <- suppressMessages(aline(w1[1:300], w2[1:300], alignment = TRUE))
fn <- names(formals(raw.alignment))[-1]
res$weighted <- sapply(1:N, function(i) { a <- as.list(W[i, ]); names(a) <- fn
  r <- do.call(raw.alignment, c(list(c(res$encode[i], res$encode[N + i])), a)); c(r[[2]], r[[3]], r[[4]]) })
res$segments <- lapply(1:300, function(i) ALINE.segments(raw.alignment(c(res$encode[i], res$encode[N + i]))))
res$decode <- lapply(1:300, function(i) { r <- raw.alignment(c(res$encode[i], res$encode[N + i]))
  suppressMessages(decode.ALINE(w1[i], r[[3]])) })
res$map <- suppressMessages(aline(c("ũmlatʃ","dinnira"), c("Èmlatʃ","diŋŋira"), m1 = "È", m2 = "o"))
data <- data.frame(dog = c("dog","perro"), cat = c("cat","gato"), rat = c("rat","rata"))
set.seed(7); res$train <- suppressMessages(generate.training(data, search.size = 100, table = FALSE))
set.seed(7); res$opt <- suppressMessages(optimize.features(res$train, ranking = c(1,1,1), num = 20, step = 3, replication = 2))
set.seed(7); res$ga <- suppressMessages(optimization.GA(Al = as.matrix(res$train[[2]][4:5, ]), data = res$train[[2]][1:2, ], num = 20, step = 3, plot = FALSE))
res$showmap <- show.map()
saveRDS(res, out)
