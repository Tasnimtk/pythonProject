#load the required libraries
library(ggplot2)
library(dplyr)
library(sf)
library(mapview)#the last 2 to visualize the obs on a map
library(tidyr)

#load the dataset from github
df <- read.csv("https://raw.githubusercontent.com/enricoromano/Python-and-R-project-/baea5d52f994c4f8de0669dc4ca72aac6b0d81f0/meteo.csv")

#let's check the dataset ! 
str(df)

#do we have any NAs, none in our case
any(is.na(df))

#let's see how many locations we have
table(df$longitude)
table(df$latitude)

#it seems we have 6 locations in total, with 168 record for each place
#so we have a week (per hour) of records per location

#we visualize our observations on a map 
#we subset a dataframe based only on the latitude & longitude

locations = df %>%
  select(latitude, longitude)

#now we create a sf object
#Here, we indicate that we want the longitude and latitude 
#to be plotted using the World Geographic System 1984 projection, 
#which is referenced as European Petroleum Survey Group (EPSG) 4326. 
locations_sf <- st_as_sf(locations, coords = c("longitude","latitude"), crs = 4326)

#let's view our map
mapview(locations_sf)

#we have 4 locations in Europe:
#Rome, Paris, Berlin & London
#one in New York
#one in Tokyo

### DATA CLEANING
#we transform hourly.time variable into two variables "day" and "time"
df = df %>%
  separate(hourly.time, into = c("date", "time"), sep = "T")

#we also see that many variables are simply the unit of some other variables
#select only the unit variables
unit = df %>%
  select(contains('hourly_units'))

#check to see the unique values in each. Each one contains only one unit
unique(unit)
#we know all the temperatures are in ?C, heights in m, precipitations in mm 
#timezone is iso8601, relative humidity in %, and pressure in hPa

#we can drop all of these columns as they bring no value added to the analysis
#since they are all in the same unit
df = df %>%
  select(-contains('hourly_units'))

### DATA VISUALIZATION
#we can visualize the evolution of the temperature over the week (per hour) for each location
#first we subset that location from the dataset (based on the map)
#we create a subset for each city

berlin = df %>%
  filter(latitude == 52.52, longitude == 13.4199980)

rome = df %>%
  filter(latitude == 41.875, longitude == 12.5)

london = df %>%
  filter(latitude == 51.5, longitude == -0.120000124)

paris = df %>%
  filter(latitude == 48.86, longitude == 2.3599997)

tokyo = df %>%
  filter(latitude == 35.625, longitude == 139.625)

newyork = df %>%
  filter(latitude == 40.75, longitude == -74)

#now we visualize the temperatures (per hour) for the whole week per city
#each line represents a day in the week of 22/11 - 28/11
#we see that 22/11 is the hottest day in most plots for all the cities
#and that the temperature is decreasing with time


#berlin
ggplot() +
  geom_point(data = berlin[c(1:24),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-22")) +
  geom_line(data = berlin[c(1:24),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-22")) +
  geom_point(data = berlin[c(25:48),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-23")) +
  geom_line(data = berlin[c(25:48),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-23"))+
  geom_point(data = berlin[c(49:72),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-24")) +
  geom_line(data = berlin[c(49:72),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-24")) +
  geom_point(data = berlin[c(73:96),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-25")) +
  geom_line(data = berlin[c(73:96),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-25"))+
  geom_point(data = berlin[c(97:120),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-26")) +
  geom_line(data = berlin[c(97:120),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-26")) +
  geom_point(data = berlin[c(121:144),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-27")) +
  geom_line(data = berlin[c(121:144),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-27"))+
  geom_point(data = berlin[c(145:168),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-28")) +
  geom_line(data = berlin[c(145:168),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-28")) +
  ggtitle("Temperature Per Hour For The Week 22/11-28/11 in Berlin")
  
#rome
ggplot() +
  geom_point(data = rome[c(1:24),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-22")) +
  geom_line(data = rome[c(1:24),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-22")) +
  geom_point(data = rome[c(25:48),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-23")) +
  geom_line(data = rome[c(25:48),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-23"))+
  geom_point(data = rome[c(49:72),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-24")) +
  geom_line(data = rome[c(49:72),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-24")) +
  geom_point(data = rome[c(73:96),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-25")) +
  geom_line(data = rome[c(73:96),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-25"))+
  geom_point(data = rome[c(97:120),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-26")) +
  geom_line(data = rome[c(97:120),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-26")) +
  geom_point(data = rome[c(121:144),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-27")) +
  geom_line(data = rome[c(121:144),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-27"))+
  geom_point(data = rome[c(145:168),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-28")) +
  geom_line(data = rome[c(145:168),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-28")) +
  ggtitle("Temperature Per Hour For The Week 22/11-28/11 in Rome")

#paris
ggplot() +
  geom_point(data = paris[c(1:24),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-22")) +
  geom_line(data = paris[c(1:24),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-22")) +
  geom_point(data = paris[c(25:48),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-23")) +
  geom_line(data = paris[c(25:48),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-23"))+
  geom_point(data = paris[c(49:72),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-24")) +
  geom_line(data = paris[c(49:72),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-24")) +
  geom_point(data = paris[c(73:96),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-25")) +
  geom_line(data = paris[c(73:96),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-25"))+
  geom_point(data = paris[c(97:120),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-26")) +
  geom_line(data = paris[c(97:120),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-26")) +
  geom_point(data = paris[c(121:144),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-27")) +
  geom_line(data = paris[c(121:144),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-27"))+
  geom_point(data = paris[c(145:168),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-28")) +
  geom_line(data = paris[c(145:168),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-28")) +
  ggtitle("Temperature Per Hour For The Week 22/11-28/11 in Paris")

#london
ggplot() +
  geom_point(data = london[c(1:24),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-22")) +
  geom_line(data = london[c(1:24),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-22")) +
  geom_point(data = london[c(25:48),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-23")) +
  geom_line(data = london[c(25:48),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-23"))+
  geom_point(data = london[c(49:72),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-24")) +
  geom_line(data = london[c(49:72),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-24")) +
  geom_point(data = london[c(73:96),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-25")) +
  geom_line(data = london[c(73:96),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-25"))+
  geom_point(data = london[c(97:120),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-26")) +
  geom_line(data = london[c(97:120),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-26")) +
  geom_point(data = london[c(121:144),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-27")) +
  geom_line(data = london[c(121:144),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-27"))+
  geom_point(data = london[c(145:168),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-28")) +
  geom_line(data = london[c(145:168),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-28")) +
  ggtitle("Temperature Per Hour For The Week 22/11-28/11 in London")

#newyork
ggplot() +
  geom_point(data = newyork[c(1:24),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-22")) +
  geom_line(data = newyork[c(1:24),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-22")) +
  geom_point(data = newyork[c(25:48),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-23")) +
  geom_line(data = newyork[c(25:48),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-23"))+
  geom_point(data = newyork[c(49:72),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-24")) +
  geom_line(data = newyork[c(49:72),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-24")) +
  geom_point(data = newyork[c(73:96),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-25")) +
  geom_line(data = newyork[c(73:96),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-25"))+
  geom_point(data = newyork[c(97:120),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-26")) +
  geom_line(data = newyork[c(97:120),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-26")) +
  geom_point(data = newyork[c(121:144),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-27")) +
  geom_line(data = newyork[c(121:144),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-27"))+
  geom_point(data = newyork[c(145:168),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-28")) +
  geom_line(data = newyork[c(145:168),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-28")) +
  ggtitle("Temperature Per Hour For The Week 22/11-28/11 in New York")

#tokyo
ggplot() +
  geom_point(data = tokyo[c(1:24),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-22")) +
  geom_line(data = tokyo[c(1:24),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-22")) +
  geom_point(data = tokyo[c(25:48),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-23")) +
  geom_line(data = tokyo[c(25:48),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-23"))+
  geom_point(data = tokyo[c(49:72),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-24")) +
  geom_line(data = tokyo[c(49:72),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-24")) +
  geom_point(data = tokyo[c(73:96),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-25")) +
  geom_line(data = tokyo[c(73:96),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-25"))+
  geom_point(data = tokyo[c(97:120),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-26")) +
  geom_line(data = tokyo[c(97:120),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-26")) +
  geom_point(data = tokyo[c(121:144),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-27")) +
  geom_line(data = tokyo[c(121:144),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-27"))+
  geom_point(data = tokyo[c(145:168),], mapping = aes(x = time, y = hourly.temperature_2m, color="2021-11-28")) +
  geom_line(data = tokyo[c(145:168),], mapping = aes(x = time, y = hourly.temperature_2m, group=1, color="2021-11-28"))+
  ggtitle("Temperature Per Hour For The Week 22/11-28/11 in Tokyo")


##let us aggregate the hours and calculate the average temperature per day for the cities
##we also add the apparent (felt) temperature to compare it to the real temp
##we also add average precipitation

#berlin
by_day_berlin = group_by(berlin, date)
summarised_berlin = summarise(by_day_berlin, temp = mean(hourly.temperature_2m), apparent_temp=mean(hourly.apparent_temperature), precip= mean(hourly.precipitation))

#rome
by_day_rome = group_by(rome, date)
summarised_rome = summarise(by_day_rome, temp = mean(hourly.temperature_2m), apparent_temp=mean(hourly.apparent_temperature),precip = mean(hourly.precipitation))

#paris
by_day_paris = group_by(paris, date)
summarised_paris = summarise(by_day_paris, temp = mean(hourly.temperature_2m), apparent_temp=mean(hourly.apparent_temperature), precip= mean(hourly.precipitation))

#london
by_day_london = group_by(london, date)
summarised_london = summarise(by_day_london, temp = mean(hourly.temperature_2m), apparent_temp=mean(hourly.apparent_temperature), precip= mean(hourly.precipitation))

#newyork
by_day_newyork = group_by(newyork, date)
summarised_newyork = summarise(by_day_newyork, temp = mean(hourly.temperature_2m), apparent_temp=mean(hourly.apparent_temperature), precip= mean(hourly.precipitation))

#tokyo
by_day_tokyo = group_by(tokyo, date)
summarised_tokyo = summarise(by_day_tokyo, temp = mean(hourly.temperature_2m), apparent_temp=mean(hourly.apparent_temperature), precip= mean(hourly.precipitation))

#we plot the evolution of the average temperature per day in each city

ggplot()+
  geom_point(data = summarised_berlin, mapping = aes(x = date, y = temp, color="Berlin")) +
  geom_line(data = summarised_berlin, mapping = aes(x = date, y = temp, group=1, color="Berlin")) +
  geom_point(data = summarised_rome, mapping = aes(x = date, y = temp, color="Rome")) +
  geom_line(data = summarised_rome, mapping = aes(x = date, y = temp, group=1, color="Rome")) +
  geom_point(data = summarised_london, mapping = aes(x = date, y = temp, color="London")) +
  geom_line(data = summarised_london, mapping = aes(x = date, y = temp, group=1, color="London")) +
  geom_point(data = summarised_paris, mapping = aes(x = date, y = temp, color="Paris")) +
  geom_line(data = summarised_paris, mapping = aes(x = date, y = temp, group=1, color="Paris"))+
  geom_point(data = summarised_tokyo, mapping = aes(x = date, y = temp, color="Tokyo")) +
  geom_line(data = summarised_tokyo, mapping = aes(x = date, y = temp, group=1, color="Tokyo"))+
  geom_point(data = summarised_newyork, mapping = aes(x = date, y = temp, color="New York")) +
  geom_line(data = summarised_newyork, mapping = aes(x = date, y = temp, group=1, color="New York"))+
  ggtitle("Average Temperature For The Period: 2021/11/22 - 2021/11/28 ") 

#rome is the hottest city among all on average
#rome & tokyo have similar ranges
#all the others have similar ranges
#all the cities' temperatures seem to be declining over time
#logical, since approaching winter

##We can also visualize their evolution one at a time & compare it to average felt temperature:

#berlin
summarised_berlin %>% 
  ggplot() +
  geom_point(mapping = aes(x = date, y = temp, color="Real Temperature")) +
  geom_line(mapping = aes(x = date, y = temp, group=1, color="Real Temperature")) +
  geom_point(mapping = aes(x = date, y = apparent_temp, color="Felt Temperature")) +
  geom_line(mapping = aes(x = date, y = apparent_temp, group=1, color="Felt Temperature")) +
  ggtitle("Average Temperature (Measured Vs Apparent) in Berlin") 

#rome
summarised_rome %>% 
  ggplot() +
  geom_point(mapping = aes(x = date, y = temp, color="Real Temperature")) +
  geom_line(mapping = aes(x = date, y = temp, group=1, color="Real Temperature")) +
  geom_point(mapping = aes(x = date, y = apparent_temp, color="Felt Temperature")) +
  geom_line(mapping = aes(x = date, y = apparent_temp, group=1, color="Felt Temperature")) +
  ggtitle("Average Temperature (Measured Vs Apparent) in Rome") 

#paris
summarised_paris %>% 
  ggplot() +
  geom_point(mapping = aes(x = date, y = temp, color="Real Temperature")) +
  geom_line(mapping = aes(x = date, y = temp, group=1, color="Real Temperature")) +
  geom_point(mapping = aes(x = date, y = apparent_temp, color="Felt Temperature")) +
  geom_line(mapping = aes(x = date, y = apparent_temp, group=1, color="Felt Temperature")) +
  ggtitle("Average Temperature (Measured Vs Apparent) in Paris") 

#london
summarised_london %>% 
  ggplot() +
  geom_point(mapping = aes(x = date, y = temp, color="Real Temperature")) +
  geom_line(mapping = aes(x = date, y = temp, group=1, color="Real Temperature")) +
  geom_point(mapping = aes(x = date, y = apparent_temp, color="Felt Temperature")) +
  geom_line(mapping = aes(x = date, y = apparent_temp, group=1, color="Felt Temperature")) +
  ggtitle("Average Temperature (Measured Vs Apparent) in London") 

#newyork
summarised_newyork %>% 
  ggplot() +
  geom_point(mapping = aes(x = date, y = temp, color="Real Temperature")) +
  geom_line(mapping = aes(x = date, y = temp, group=1, color="Real Temperature")) +
  geom_point(mapping = aes(x = date, y = apparent_temp, color="Felt Temperature")) +
  geom_line(mapping = aes(x = date, y = apparent_temp, group=1, color="Felt Temperature")) +
  ggtitle("Average Temperature (Measured Vs Apparent) in New York") 

#tokyo
summarised_tokyo %>% 
  ggplot() +
  geom_point(mapping = aes(x = date, y = temp, color="Real Temperature")) +
  geom_line(mapping = aes(x = date, y = temp, group=1, color="Real Temperature")) +
  geom_point(mapping = aes(x = date, y = apparent_temp, color="Felt Temperature")) +
  geom_line(mapping = aes(x = date, y = apparent_temp, group=1, color="Felt Temperature")) +
  ggtitle("Average Temperature (Measured Vs Apparent) in Tokyo") 

#we see that the apparent temperature (what people feel)
#is always lower than the measured temperature

##we can also visualize the average precipitation per day in each city
#berlin
summarised_berlin %>%
  ggplot(mapping = aes(x = date, y = precip))+
    geom_bar(stat="identity",fill="pink") + ggtitle("Rainfall in Berlin")

#rome
summarised_rome %>%
  ggplot(mapping = aes(x = date, y = precip))+
  geom_bar(stat="identity",fill="pink") + ggtitle("Rainfall in Rome")

#paris
summarised_paris %>%
  ggplot(mapping = aes(x = date, y = precip))+
  geom_bar(stat="identity",fill="pink") + ggtitle("Rainfall in Paris")

#london
summarised_london %>%
  ggplot(mapping = aes(x = date, y = precip))+
  geom_bar(stat="identity",fill="pink") + ggtitle("Rainfall in London")

#newyork
summarised_newyork %>%
  ggplot(mapping = aes(x = date, y = precip))+
  geom_bar(stat="identity",fill="pink") + ggtitle("Rainfall in New York")

#tokyo
summarised_tokyo %>%
  ggplot(mapping = aes(x = date, y = precip))+
  geom_bar(stat="identity",fill="pink") + ggtitle("Rainfall in Tokyo")
