library(biomaRt)
library(curl)
library(tidyverse)
mart <- useMart("ensembl", dataset="mmusculus_gene_ensembl")
for (i in 1:nrow(X01)){
  seq = getSequence(id = X01$ENSEMBL[i], type = "ensembl_gene_id", seqType = "5utr", mart = mart)
  x<-0
  if (length(seq$"5utr")!=0) {
    for (a in 1:length(seq$"5utr")){
      if (!is.na(nchar(seq[a,"5utr"]))){
        if (seq[a,"5utr"] != "Sequence unavailable"){
          x<-x+nchar(gsub(" ","",seq[a,"5utr"]))}
        X01[i,"5'UTR"]<-x
      }else{X01[i,"5'UTR"]<-NA}
    }
    for (a in 1:length(seq$"5utr")){
      if (!is.na(nchar(seq[a,"5utr"]))){
        if (seq[a,"5utr"] != "Sequence unavailable"){
          X01[i,paste("5'UTR",a)]<-nchar(gsub(" ","",seq[a,"5utr"]))}
      }else{X01[i,paste("5'UTR",a)]<-0}
    }
  }
  print(paste("完成第",i,"个了！"))
}
write.csv(X01,"output_5UTR0101.csv")
getwd()
