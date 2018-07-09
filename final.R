library(SocialMediaLab)

# Google developer API key
apikey <- "XXXXXXXXXXXXXXXX(use your google Api Key)"
key <- AuthenticateWithYoutubeAPI(apikey)

# Collect data using Youtube video IDs
video <- c('5eDqRysaico', 'dJclNIN-TPo')
ytdata <- CollectDataYoutube(video, key, writeToFile = FALSE)
str(ytdata)
write.csv(ytdata, file='C:/Users/user/Desktop/result/yt9.csv', row.names = F)

# Read Youtube data file
data <- read.csv(file.choose(), header = T)
str(data)
data <- data[data$ReplyToAnotherUser != FALSE,]
y <- data.frame(data$User, data$ReplyToAnotherUser)

## Create user network
library(igraph)
net <- graph.data.frame(y, directed = T)
net <- simplify(net)
V(net)
E(net)
V(net)$label <- V(net)$name
V(net)$degree <- degree(net)

# Histogram of node degree
hist(V(net)$degree,
     col = 'green',
     main = 'Histogram of the Node Degree',
     ylab = 'Frequency',
     xlab = 'Degree of vertices')

# Network diagram
plot(net,
     vertex.size =0.2*V(net)$degree,
     edge.arrow.size = 0.1,
     vertex.label.cex = 0.01*V(net)$degree)

## sentiment analysis
library(naivebayes)
library(syuzhet)
library(plyr)
library(ggplot2)

 
# Read data file
data <- read.csv(file.choose(), header = T)
str(data)
comments <- iconv(data$Comment, to = 'utf-8')

# Obtain sentiment scores
s <- get_nrc_sentiment(comments)
head(s)
s$neutral <- ifelse(s$negative+s$positive==0, 1, 0)
head(s)
comments[8]


# Bar plot 
barplot(100*colSums(s)/sum(s),
        las = 2,
        col = rainbow(10),
        ylab = 'Percentage',
        main = 'Sentiment Scores for youtube comments')

          
        



