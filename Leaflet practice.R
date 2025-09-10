install.packages("leaflet")


library(leaflet)
library(readxl)
library(dplyr)

#Input Data:
#From https://data.opendatasoft.com/explore/dataset/us-colleges-and-universities%40public/information/?flg=en-us
#from the IPEDS and NCES data sets
#accessed via opendatasoft Dataset identifier: us-colleges-and-universities@public

edu <- read_excel("us-colleges-and-universities@public.xlsx")
edu$LATITUDE <- as.numeric(edu$LATITUDE) 
edu$LONGITUDE <- as.numeric(edu$LONGITUDE)

#CHECKING TO SEE IF SCHOOLS ARE SPELLED THE SAME IN THE DATAFRAME AS I HAVE THEM

part <- c("CARNEGIE MELLON UNIVERSITY",
        "CUNY CITY COLLEGE",
        "CLEMSON UNIVERSITY",
        "HOWARD UNIVERSITY",
        "THE PENNSYLVANIA STATE UNIVERSITY",
          "RUTGERS UNIVERSITY-NEWARK",
          "SOUTH DAKOTA STATE UNIVERSITY",
          "THE UNIVERSITY OF ALABAMA",
          "UNIVERSITY OF ARIZONA",
          "UNIVERSITY OF CINCINNATI-MAIN CAMPUS",
          "UNIVERSITY OF CONNECTICUT",
          "UNIVERSITY OF GEORGIA",
          "UNIVERSITY OF NEW HAMPSHIRE-MAIN CAMPUS",
          "UNIVERSITY OF OREGON",
          "THE UNIVERSITY OF TEXAS AT AUSTIN",
          "UTAH STATE UNIVERSITY",
          "VIRGINIA POLYTECHNIC INSTITUTE AND STATE UNIVERSITY")

#name in vector that do not match
part[!(part %in% edu$NAME)]

#smaller dataframe with just participants
df <- edu[edu$NAME %in% part,]

#only those of folks who participated 
leaflet(data = df) %>%
  addTiles() %>%
  setView(lng = -97, lat = 38, zoom = 4)%>%
  addMarkers()


#testing adding logos 

bama <- df[df$NAME %in% "THE UNIVERSITY OF ALABAMA",]

icons <- iconList("BAMA" = makeIcon(iconUrl = "https://upload.wikimedia.org/wikipedia/commons/1/12/Alabama_Athletics_logo.svg",
                                    iconWidth = 25,
                                    iconHeight = 25))

leaflet(data = bama) %>%
  addTiles()%>%
  setView(lng = -97, lat = 38, zoom = 4)%>%
  addMarkers(icon = icons)

#Where to go next: Replace the icons with logos 
#https://www.jla-data.net/eng/leaflet-markers-in-r/




