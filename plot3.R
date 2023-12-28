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

# Create new column with name of the date
df.01$DateName <- format(df.01$Date, format = "%a")

#===============================================================================
# C. Plotting Data
#===============================================================================

#-------------------------------------------------------------------------------
# Plot 3 - Energy sub metering
#-------------------------------------------------------------------------------

# Customize x-axis labels to display abbreviated day names
unique_dates <- unique(df.01$DateName)  # Get unique date names

png("plot3.png", width=480, height=480)

with(df.01, plot(DateTime, Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xaxt = "n", xlab = ""))
lines(df.01$DateTime, df.01$Sub_metering_2, type = "l", col = "red")
lines(df.01$DateTime, df.01$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
axis(1, at = df.01$DateTime[c(1, 1441)],  # Adjust indices for desired placement
     labels = unique_dates)

dev.off()