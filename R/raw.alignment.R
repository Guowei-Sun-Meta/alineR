raw.alignment <-function(s,Syllabic=5,Place=40,Stop=50,Voice=10,Nasal=10,Retroflex=10,Lateral=10,Aspirated=5,Long=1,High=5,Back=5,Round=5,sk=10)
  {
    s <- as.character(s)
    if (length(s) != 2) stop("'s' must contain exactly two words")
    ### Input Arguments ###
    features<-as.integer(c(Syllabic,Place,Stop,Voice,Nasal,Retroflex,Lateral,Aspirated,Long,High,Back,Round))
    if (length(features) != 12 || anyNA(features))
      stop("feature weights must be 12 non-missing numbers")
    sk <- as.integer(sk)
    if (length(sk) != 1 || is.na(sk)) stop("'sk' must be a single non-missing number")
    ### C++ interface ####
    z<-.Call(C_exchange,s,features,sk)
    m<-list(s,z[[3]],z[[1]],z[[2]])
    names(m)<-c("word pair","similarity score","alignment1","alignment2")
    return(m)
  }
