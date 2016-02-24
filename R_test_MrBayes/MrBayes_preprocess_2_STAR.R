#!/usr/bin/Rscript

Args <- commandArgs()
INPUT_DIR <- Args[6]

#Generate species tree from the output of RAxML.
#Generate the RAxML_INPUT_INPUT_FILES_list.txt under the current directory.
#usage : Rscript name_of_the_script.R INPUTDIR_NAME

library("phybase")
cmd <-
  paste(
    "ls ./",INPUT_DIR,"/Cluster*.nex.t_extract_transformat.t"," > INPUT_FILES_list.txt",sep = ""
  )
system(cmd)

INPUT_LIST <- readLines("./INPUT_FILES_list.txt")
INPUT_FILES <- paste(getwd(),"/",INPUT_LIST,sep = "")

OUTGROUP <- "Klac"

#this is special,cause the numbels of taxa in any gene trees are same.
TREE <- read.tree(INPUT_FILES[1])
NUM_TAXAS <- length(TREE[[1]]$tip.label)

OUTPUTNAME = paste(format(Sys.time(), "%b_%d_%Y"),"_MB_startrees_output.tre",sep = "")

test.boottrees <- matrix("",length(INPUT_FILES),1000)

#cmd<-paste("echo","try",sep = " ")
#system(cmd)

for (i in 1:length(INPUT_FILES))
{
  x <- scan(INPUT_FILES[i],what = "character",sep = "\n")
  test.boottrees[i,] <- x
}

test.taxaname <- TREE[[1]]$tip.label
species.structure <- matrix(0, NUM_TAXAS, NUM_TAXAS)
diag(species.structure) <- 1
test.startrees <- rep("",1000)

for (i in 1:1000) {
  test.startrees[i] <-
    star.sptree(
      test.boottrees[,i],speciesname = test.taxaname,taxaname = test.taxaname, species.structure =
        species.structure, outgroup = OUTGROUP, method = "nj"
    )
  print(i)
}

write(test.startrees, file = OUTPUTNAME)