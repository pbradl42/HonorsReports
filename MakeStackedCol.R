getplace <- function(data, var) { which(colnames(data) == var) }

makechart <- function(var, type = "percent") {
 #message(var)
#  message(table(fall2016[,getplace(fall2016, var)]))
  e <- globalenv()
  e$fall2016 -> fall2016
  e$fall2015 -> fall2015
  e$fall2014 -> fall2014
  e$fall2013 -> fall2013
  e$fall2012 -> fall2012
  e$fall2011 -> fall2011
  e$fall2010 -> fall2010
#  message(paste("here", nrow(fall2013), sep=" "))
  bygender16 <- as.data.frame(table(fall2016[,getplace(fall2016, var)]))
  if(length(bygender16) == 1) {
    bygender16 <- data.frame(Var1 = "Y", Freq = 0)
  }
  bygender16$percentage <- round((bygender16$Freq / sum(bygender16$Freq)) * 100, 1)
  bygender15 <- as.data.frame(table(fall2015[,getplace(fall2015, var)]))
  if(length(bygender15) == 1) {
    bygender15 <- data.frame(Var1 = "Y", Freq = 0)
  }
  bygender15$percentage <- round((bygender15$Freq / sum(bygender15$Freq)) * 100, 1)
  bygender14 <- as.data.frame(table(fall2014[,getplace(fall2014, var)]))
  if(length(bygender14) == 1) {
    bygender14 <- data.frame(Var1 = "Y", Freq = 0)
  }
  bygender14$percentage <- round((bygender14$Freq / sum(bygender14$Freq)) * 100, 1)
  
  bygender13 <- as.data.frame(table(fall2013[,getplace(fall2013, var)]))
  bygender13$percentage <- round((bygender13$Freq / sum(bygender13$Freq)) * 100, 1)
#  message(paste("here", nrow(bygender13), sep=" "))
  bygender12 <- as.data.frame(table(fall2012[,getplace(fall2012, var)]))
  bygender12$percentage <- round((bygender12$Freq / sum(bygender12$Freq)) * 100, 1)
  
  bygender11 <- as.data.frame(table(fall2011[,getplace(fall2011, var)]))
  bygender11$percentage <- round((bygender11$Freq / sum(bygender11$Freq)) * 100, 1)
  
  bygender10 <- as.data.frame(table(fall2010[,getplace(fall2010, var)]))
  bygender10$percentage <- round((bygender10$Freq / sum(bygender10$Freq)) * 100, 1)
#  message(paste("here", nrow(bygender13), sep=" "))

  bygender16$year <- "2016"
  bygender15$year <- "2015"
  bygender14$year <- "2014"
  bygender13$year <- "2013"
  bygender12$year <- "2012"
  bygender11$year <- "2011"
  bygender10$year <- "2010"
#  message("here2")
  myTotal <- rbind(bygender16, bygender15, bygender14, bygender13, bygender12, bygender11, bygender10)
  myTotal$Var1 <- factor(myTotal$Var1)
 # message(myTotal)
  if (type == "percent") {
    myTotal <- ddply(myTotal, .(year), 
                         transform, pos = cumsum(percentage) - (0.5 * percentage)
    )
    z <- ggplot(myTotal, aes(x=year, y=percentage, fill=Var1)) + geom_bar(stat="identity") + geom_text(aes(label = paste(percentage, "%")), colour = "white", fontface="bold", size=6, y=myTotal$pos) + scale_y_continuous()
  } else {
    myTotal <- ddply(myTotal, .(year), 
                         transform, pos = cumsum(Freq) - (0.5 * Freq)
    )
    z <- ggplot(myTotal, aes(x=year, y=Freq, fill=Var1)) + geom_bar(stat="identity") + geom_text(aes(label = paste(Freq)), colour = "white", fontface="bold", size=6, y=myTotal$pos) + scale_y_continuous()
  }
   return(z)
}

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}