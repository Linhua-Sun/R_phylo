#!/usr/bin/Rscript

##Generate consensus tree from species tree intermediate.

#Args <- commandArgs()
#INPUT_DIR <- Args[6]

library("ape")
library("Rphylip")
library("methods")
setPath("/usr/local/bin")

files <- dir(pattern = "startrees_output.tre$")
for (i in files) {
  trs <- read.tree(i)
  tree <- Rconsense(trs)
  name <- paste(i,"_consnesus.tre",sep = "")
  write.tree(tree,file = name)
}

#batch rename
#oldstring <- readLines("oldname.txt")
#newstring <- readLines("newname.txt")
#directory <- dir(pattern = "startrees_output.tre_consnesus.tre$")
#for (j in 1:length(directory)) {
#  treefile <- readLines(directory[j])
#  for (i in 1:length(oldstring)) {
#    newtreefile <- sub(oldstring[i],newstring[i],treefile)
#    treefile <- newtreefile
#  }
#  filename <- paste("taxas_name_changed_",directory[j],".tre",sep = "")
#  write(treefile,filename)
#}

##plot tree
#pdf(file = "2015.11.29.species.trim.less.than.10.pdf",height = 8,width = 20)
#MLfiles <- dir(pattern = "^taxas_name_changed_")
#par(mfrow = c(1,3))
#for (i in MLfiles)  {
#  tree1 <- read.tree(i)
#  tree1$tip.label <- gsub("_","\ ",tree1$tip.label)
#  tree1$node.label <- round(as.numeric(tree1$node.label) * 100)
#  plot(
#    tree1,use.edge.length = FALSE,cex = 1.5,font = 3,main = i
#  )
#  nodelabels(
#    tree1$node.label,adj = -0.1,frame = "none",cex = 1,font = 2
#  )
#}
#dev.off()
