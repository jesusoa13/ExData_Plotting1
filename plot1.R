# Remember to start with a new session!

#===============================================================================
# Heading
#===============================================================================

# Date: 2023-12-27
# Creator: Jesus Ortiz
# Project: exploratory_data_analysis
# Sections:
#     A. Loading Data Set
#     B. Transform Data for Plotting
#     C. Plotting Data
#
# Notes: R-Version for this code and packages R 4.3.1

#===============================================================================
# A. Loading Data Set
#===============================================================================
household_power_consumption <- read.csv("~/Documents/01 Projects /02 Exploratory Data Analysis/01 data/household_power_consumption.txt", sep=";")

df <- household_power_consumption

#===============================================================================
# B. Transform Data for Plotting
#===============================================================================
library(dplyr)
library(lubridate)

# Create column for date and time
df$DateTime <- dmy_hms(paste(df$Date, df$Time))

# Convert date to as.Date() and filter by specified dates
df.01 <- df %>% 
  mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
  filter(Date == "2007-02-01"| Date == "2007-02-02")

# Convert relevant columns to numeric
df.01 <- df.01 %>%
  mutate(across(-c(Date, Time, DateTime), as.numeric))

#===============================================================================
# C. Plotting Data
#===============================================================================

#-------------------------------------------------------------------------------
# Plot 1 - Histogram for Global Active Power
#-------------------------------------------------------------------------------
png("plot1.png", width=480, height=480)

hist(df.01$Global_active_power, xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = "red")
dev.off()