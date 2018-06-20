sex <-  factor(c("male", "female", "female", "male"))
levels(sex)
nlevels(sex)

# Factors of females captured aainst males
plot(surveys$sex)

# Create subset of the sex data
sex <-  surveys$sex
levels(sex)[1] <- "Female"
levels(sex)[2] <-  "Male"

levels(sex)
levels(sex)[1:3] <-  c("Undetermined", "Female", "Male")

plot(sex)

sex <- factor(sex, levels = c("Female", "Male", "Undetermined"))
plot(sex)

