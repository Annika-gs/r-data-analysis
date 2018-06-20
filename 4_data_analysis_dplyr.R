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
    filter(weight == max(weight)) %>% 
    select(year, genus, species_id, weight) %>% 
    arrange(desc(weight))

surveys_complete <- 
    surveys %>% 
    filter(!is.na(weight), 
           !is.na(hindfoot_length), 
           !is.na(sex))

#Keep species for which there are at least 50 observations
species_counts <- surveys_complete %>% 
    count(species_id) %>% 
    filter(n>=50)

num_species <- surveys_complete %>% 
    count(species_id) %>% 
    filter(n >= 1000)

surveys_complete %>% 
    filter(species_id %in% num_species$species_id)

animals <- c("pig", "cat", "dog", "donkey", "gorilla", "mouse")

other_animals <- c("zebra", "parrot", "donkey", "cat", "camel")

animals <- c(animals, "zebra", "parrot", "camel")

animals

animals %in% other_animals

animals %in% other_animals$animals

other_animals

intersect(animals, other_animals)
#reduce the surveys_complete object so that it only contains species with at least 50 observations (these 
# are in object species_count)

numerous_species <-  species_counts$species_id

surveys_complete <- 
    surveys_complete %>% 
    filter(species_id %in% numerous_species)

dim(surveys_complete)

write_csv(surveys_complete, "data/surveys_complete.csv")

# how to plot with ggplot2

surveys_plot <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
    geom_jitter()

library(tidyverse)

dim(surveys_complete)    

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + geom_point(alpha = 0.1, aes(colour = species_id))

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length)) + 
    geom_boxplot() +
    geom_point(alpha = 0.1, colour = "tomato")

yearly_counts <- 
    surveys_complete %>% 
    group_by(year, species_id) %>% 
    tally()

surveys_complete %>% 
    group_by(year, species) %>% 
    tally()

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) + 
    geom_line()

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, colour = species_id)) +
    geom_line()

# faceting - splitting graphs of the same scale into loads of seperate graphs
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, colour = species_id)) +
    geom_line() +
    facet_wrap(~species_id) # ~tells facet_wrap that to use to split the graphs

yearly_sex_counts <- surveys_complete %>% 
    group_by(year, species_id, sex) %>% 
    tally()

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, colour = sex)) +
    geom_line() +
    facet_wrap(~species_id) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1.1)) +
    labs(title = "Species counts over time",
         x = "Year of observation",
         y = "Number of species")

ggsave("images/my_fancy_plot.png", width = 15, height = 10, dpi = 300)

