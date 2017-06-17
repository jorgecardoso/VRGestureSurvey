library(ggplot2) 
library(stringr)

X <- read.csv(url("https://docs.google.com/spreadsheets/d/1fWJ_yhH1-tly8NavSH_hLSWklUEEn-kcil7sgtiIyV0/pub?output=csv"))
X$DOILink <- paste("<a target='_new' href='https://doi.org/",X$DOI,"'>", X$DOI,"</a>", sep="")

X <- X[c(1:9, 37)]

# filter uncatalogued data
#X <- X[1:150,]



body.parts<-unlist(lapply(X$Tracked.body.part,  function(s) strsplit(as.character(s), " *([+]) *")))
body.parts<-sub(" *\\(.*\\) *", "", body.parts)
body.parts<-sub("^ ", "", body.parts)
body.parts<-sub(" $", "", body.parts)
body.parts <- factor(body.parts)

allDevices<-data.frame()
for (part in levels(body.parts)) {
  print(part)
  devices <- X[grepl(part, X$Tracked.body.part),]
  devices$Tracked.body.part.cleaned <- part
  
  r<-unlist(lapply(devices$Device,  function(s) strsplit(as.character(s), " *[+] *")))
  
  r<-sub(" *\\(.*\\) *", "", r)
  r<-sub("^ ", "", r)
  r<-sub(" $", "", r)
  r<-factor(r)
  
  print(paste("Devices for ", part, ":"))
  print(levels(r))
  allDevices <- rbind(allDevices, devices)
}


X$Year <- factor(X$Year)
plotYearDistribution <- function() {
  p <- ggplot(X, aes(Year)) + 
    geom_bar() +
    ggtitle("Distribution of year of publication") +
    ylab("Count") +
    theme_bw() +
    theme(text = element_text(size=14))
  print(p)
}


bodyPartDistribution <- function() {
  r<-unlist(lapply(X$Tracked.body.part,  function(s) strsplit(as.character(s), " *([+]) *")))
  r<-sub(" *\\(.*\\) *", "", r)
  r<-sub("^ ", "", r)
  r<-sub(" $", "", r)
  
  
  t<-sort(table(r))
  d <- as.data.frame(t)
  p <- ggplot(d, aes(x=r, y=Freq)) + 
    geom_bar(stat='identity') +coord_flip() +
    ggtitle("Distribution of tracked body part") +
    ylab("Count") +
    theme_bw() +
    theme(text = element_text(size=14),
          axis.title.y=element_blank()  ) 
  print(p)
}

deviceDistribution <- function() {
  r<-unlist(lapply(X$Device,  function(s) strsplit(as.character(s), " *[+] *")))
  
  r<-sub(" *\\(.*\\) *", "", r)
  r<-sub("^ ", "", r)
  r<-sub(" $", "", r)
  t<-sort(table(r))
  d <- as.data.frame(t)
  p <- ggplot(d, aes(x=r, y=Freq)) + 
    geom_bar(stat='identity') +coord_flip() +
    ggtitle("Categories of detection technologies")+
    ylab("Count") +
    theme_bw() +
    theme(text = element_text(size=14),
          axis.title.y=element_blank()  ) 
  print(p)
  
 
}

plotYearDistribution()

bodyPartDistribution()

deviceDistribution()