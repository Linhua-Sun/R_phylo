#!/usr/bin/Rscript

#this script is used to generate rooted RAxML bootstrap tree based on RAxML's OUTPUT in a folder(test_data)

library(phybase)
INPUT_DIR <- "test.data"
cmd <-
  paste("ls ",INPUT_DIR,"/*fas_out1"," > INPUT_FILES_list.txt",sep = "")
system(cmd)
OUTGROUP <- "Klac"
INPUT_LIST <- readLines("./INPUT_FILES_list.txt")
INPUT_FILES <- paste(getwd(),"/",INPUT_LIST,sep = "")
for (i in 1:length(INPUT_FILES)) {
  file1 <- INPUT_FILES[i]
  trees <- readLines(file1)
  for (j in 1:length(trees)) {
    treej <- trees[j]
    write.tree.string(treej,"mono.tre",format = "phylip")
    monotree <- read.tree("mono.tre")
    rootedtree <- root(monotree,OUTGROUP,resolve.root = TRUE)
    write.tree(rootedtree,append = TRUE,file = "rooted.t")
    if (j == length(trees)) {
      emptyfile <- readLines("rooted.t")
      name <- paste(file1,"_rooted.t",sep = "")
      write.tree.string(emptyfile,file = name,format = "phylip")
      file.remove("rooted.t")
    }
  }
}
file.remove("mono.tre")
print("IT IS OK!")