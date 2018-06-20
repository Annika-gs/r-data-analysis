surveys <-  read_csv("data/portal_data_joined.csv")

head(surveys)

surveys["1978",]

surveys[nrow = 1978,]
surveys[surveys$year=="1978",]

#dyplr
# filter - used to select rows
# filter(data, column == values to keep)

filter(surveys, year == 1978)

# select

select(surveys, year, plot_id, species_id)

# select only the three columns above but only from 1978

surveys_filter <- filter(surveys, year == 1978)
surveys_filter

select(surveys_filter, year, plot_id, species_id)

# stitching it together with a pipe
# %>% 

surveys_short <- 
surveys %>% 
    filter(year == 1978) %>% 
    select(year, plot_id, species_id)

surveys_short

?select

# Mutate - to create new columns based on exitsting columns or on some operations done on existing columns

surveys %>% 
    select(weight, species)

surveys %>% 
    mutate(weight_kg = weight/1000) %>% 
    select(starts_with("w"))

# CHALLANGE 1
# Create a new data frame from surveys that contains: only species_id column and a new column called 
# hindfoot_half containing values from column hindfoot_length divided by two

Challange_1 <- 
    surveys %>% 
    mutate(hindfoot_half = hindfoot_length/2) %>% 
    filter(hindfoot_half < 30) %>% 
    select(hindfoot_half, species_id)
Challange_1

# how to remove missing observations

surveys %>% 
    mutate(weight_kg = weight/1000) %>% 
    select(starts_with("w")) %>% 
    filter(!is.na(weight)) # filters out rows in column weight that are not NA

# How to have a summary overview of a dataset

surveys

length(table(surveys$year))
range(surveys$year)
range(surveys$species)
summary(surveys)

# Splitting and running calculations on groups

surveys %>% 
    group_by(year) %>% 
    summarise(mean_hingfoot_length = mean(hindfoot_length, 
                                          na.rm = TRUE))

surveys %>% 
    filter(!is.na(weight)) %>% 
    group_by(sex, species_id) %>% 
    summarise(mean_weight = mean(weight))

surveys %>% 
    filter(!is.na(weight)) %>% 
    group_by(sex, species_id) %>% 
    summarise(mean_weight = mean(weight),
              min_weight = min(weight),
              sd_weight = sd(weight))

surveys %>%
    count(species, sort = TRUE)

# arrange - used to rearrange rows

surveys %>% 
    count(species, sort = TRUE)

surveys %>% 
    count(sex, species) %>% 
    arrange(species, desc(n))

# CHALLANGE 2
#How many individuals were caught in each plot_type?

surveys %>% 
    count(plot_type)

surveys %>% 
    group_by(plot_type) %>% 
    tally()
# CHALLANGE 3
# What is the heaviest animals measured in each year? Return columns year, genus, species_id and weight.
# do not return missing observations

surveys %>%
    filter(!is.na(weight)) %>% 
    group_by(year) %>% 
    summarise(max_weight = max(weight)) %>% 

