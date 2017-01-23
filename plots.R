library(ggplot2) 

X <- read.csv(url("https://docs.google.com/spreadsheets/d/1fWJ_yhH1-tly8NavSH_hLSWklUEEn-kcil7sgtiIyV0/pub?output=csv"))
X$DOILink <- paste("<a target='_new' href='https://doi.org/",X$DOI,"'>", X$DOI,"</a>", sep="")

X <- X[c(1:9, 37)]

# filter uncatalogued data
X <- X[1:102,]

plotYearDistribution <- function() {
  p <- ggplot(X, aes(Year)) + 
    geom_bar() 
  print(p)
}


bodyPartDistribution <- function() {
  r<-unlist(lapply(X$Tracked.body.part,  function(s) strsplit(as.character(s), " *([,]) *")))
  r<-sub(" *\\(.*\\) *", "", r)
  r<-sub("^ ", "", r)
  r<-sub(" $", "", r)
  d<-data.frame(Tracked.body.part=r)
  p <- ggplot(d, aes(Tracked.body.part)) + 
    geom_bar()  +coord_flip()
  print(p)
}

deviceDistribution <- function() {
  r<-unlist(lapply(X$Device,  function(s) strsplit(as.character(s), " *[+] *")))
  
  r<-sub(" *\\(.*\\) *", "", r)
  r<-sub("^ ", "", r)
  r<-sub(" $", "", r)
  d<-data.frame(device=r)
  p <- ggplot(d, aes(device)) + 
    geom_bar() +coord_flip()
  print(p)
}

plotYearDistribution()

bodyPartDistribution()

deviceDistribution()