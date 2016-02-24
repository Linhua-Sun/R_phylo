#!/usr/bin/Rscript

Args <- commandArgs()
INPUT_DIR <- Args[6]
#INPUT_DIR <- "test_data"

cmd <-
  paste("ls ",getwd(),"/",INPUT_DIR,"/Cluster*.nex.t"," > INPUT_FILES_list.txt",sep = "")
system(cmd)

OUTGROUP <- "Klac"
INPUT_LIST <- readLines("./INPUT_FILES_list.txt")

for (i in INPUT_LIST) {
  tr <- read.nexus(i)
  filename <- paste(i,"_extract_transformat.t",sep = "")
  tr <- tr[102:1101]
  
  for (j in 1:1000) {
    tr[[j]]$edge.length <- NULL
    tr[[j]] <- root(tr[[j]], OUTGROUP, resolve.root = TRUE)
  }
  
  write.tree(tr,file = filename)
}