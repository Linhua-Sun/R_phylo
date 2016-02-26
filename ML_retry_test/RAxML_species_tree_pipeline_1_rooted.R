#!/usr/bin/Rscript
Args <- commandArgs()
INPUT_DIR <- Args[6]

#INPUT_DIR <- "test_data"

#this script is used to generate rooted RAxML bootstrap tree based on RAxML's OUTPUT in a folder(test_data)
#usage : Rscript name_of_the_script.R INPUTDIR_NAME

library("phybase")

cmd <-
  paste("ls ",INPUT_DIR,"/RAxML_bootstrap.Cluster*fas_out1"," > INPUT_FILES_list.txt",sep = "")

system(cmd)

OUTGROUP <- "Klac"

INPUT_LIST <- readLines("./INPUT_FILES_list.txt")

INPUT_FILES <- paste(getwd(),"/",INPUT_LIST,sep = "")

for (i in INPUT_FILES) {
  tr <- read.tree(i)
  filename <- paste(i,"_rooted.t",sep = "")
  for (j in 1:1000) {
    tr[[j]] <- root(tr[[j]], OUTGROUP, resolve.root = TRUE)
  }
  write.tree(tr,file = filename)
}