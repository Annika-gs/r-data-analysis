# Downloading data
download.file("https://ndownloader.figshare.com/files/2292169", 
              "data/portal_data_joined.csv")

# Load the data
surveys <-  read.csv("data/portal_data_joined.csv")

# Examine the first 6 lines
head(surveys)

# Look at structure
str(surveys)

# Indexing and subsetting
surveys[1, 1] # First element in first column
surveys[1, 6]
surveys[1:3, 7]
surveys[, 1]
surveys [8:11, ]

surveys_200 <- c(surveys[200,])
surveys_200

surveys_200 <- data.frame(surveys[200,])
surveys_200

nrow(surveys_200)
nrow(surveys)
nrow(34786,)
surveys_last <- surveys[34786,]
tail(surveys)

surveys_middle <- surveys[nrow(surveys)/2,]
surveys_middle
34786/2

surveys[1:6, ]
surveys_head <- surveys[-(7:nrow(surveys)), ]

