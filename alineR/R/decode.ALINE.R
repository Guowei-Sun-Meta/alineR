# Copyright (c) 2015 by Sean Downey
# Authors: Sean Downey (sean@codexdata.com) and Guowei Sun (gwsun@umd.edu)
# This software is distributed under GPL-3.

decode.ALINE <-
function(x,y,m1=NULL,m2=NULL) {
  map<-map(m1,m2)
  splitx<-strsplit(x,"")
  splity<-strsplit(y,"")    
  # drop every character without a mapping (previously t<-splitx[[1]][-j]
  # restarted from the full word each time, so only the last one was dropped)
  valid<-splitx[[1]] %in% intToUtf8(map$U.Val, multiple=TRUE)
  for(ch in splitx[[1]][!valid]){
    message(paste("Invalid character:",ch,"dropped in alignment"))
  }
  splitx[[1]]<-splitx[[1]][valid]
  num<-length(splity[[1]])
  J<-rep(NA,length(splitx[[1]]))  
  j=1    
  
  for( i in seq_len(num-1))  # was 1:num-1, i.e. 0:(num-1)
  {
    if (!splity[[1]][i]==" " && splity[[1]][i+1]==" ")
    {
      J[j]=i
      j=j+1    
    }
  }

 aligned_y=rep(" ",num)
  
  p=0
  
 for (i in 1:(length(J)))
 { 
   if(splity[[1]][J[i]]=="|"||splity[[1]][J[i]]=="<"||splity[[1]][J[i]]=="-")   
   {
     aligned_y[J[i]]<-splity[[1]][J[i]]
     p=p+1
   }
   else{
   aligned_y[J[i]]=splitx[[1]][(i-p)]   
   }
 }
  z<-paste(aligned_y,sep=' ',collapse='')
  return(z)
}
