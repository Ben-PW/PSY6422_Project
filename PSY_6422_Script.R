## PSY6422 project script

# Loading environment
library(dplyr)
library(here)
library(tidyverse)
library(ggplot2)
library(hablar)
library(npreg)
library(ggstance)
library(ggformula)
library(gridExtra)

# Loading data
here()
onsfull <- read.csv(here::here("Data", "ons_c19_estimates_england.csv"),
                    skip = 5,
                    blank.lines.skip = TRUE)
gvtfull <- read.csv(here::here("Data", "gvtengland.csv"))


# Select relevant  data
onsfull <- onsfull[-c(10, 101:108), ]
onsselect <- onsfull %>% select(1, 5)
gvtfull <- gvtfull %>% filter(grepl('England', areaName))
gvtselect <- gvtfull %>% select(4, 5)

# Preparing ONS data
onsdates <- data.frame(str_split_fixed(onsselect$Fortnightly.weighted.estimates, " to ", n = 2))
onsdate1 <- as.Date(onsdates$X1, format = "%d %B %Y") # Recognise ons data as date-time data
onsdate2 <- as.Date(onsdates$X2, format = "%d %B %Y")

onsdf <- data.frame(onsdate1, onsdate2, onsselect$X.3, 
                    stringsAsFactors = TRUE) 
onsdf$date <- as.Date((onsdf$onsdate1 + ((onsdf$onsdate2 - onsdf$onsdate1) / 2)), 
                      format = "%d %B %Y")

onsdf <- na.omit(onsdf) # Remove NA values
onsdf[,'covid'] <- gsub(",","", onsdf[,'onsselect.X.3']) # Remove commas from X.3
rm(onsdates, onsdate1, onsdate2, onsfull, onsselect)
onsdf <- onsdf %>% convert(num(covid))
onsdf <- onsdf %>% select(4, 5)

# Preparing Gvt data
date <- as.Date(gvtselect$date, format = "%d/%m/%Y") 
covid <- gvtselect$newCasesByPublishDate
gvtdf <- data.frame(covid, date)
gvtdf$covid[gvtdf$covid==0] <- NA # Set 0 vals as NA
gvtdf <- na.omit(gvtdf) # Remove NA vals
rm(gvtfull, gvtselect, covid, date)

# Preparing IfG dataframe
date1 <- as.Date(c("2020-05-03","2020-06-01","2020-06-15","2020-09-14","2020-11-05","2020-12-02",
                   "2021-01-06","2021-03-29","2021-04-12","2021-05-17","2021-07-19","2021-12-08"))
date2 <- as.Date(c("2020-06-01","2020-06-15","2020-09-14","2020-11-05","2020-12-02","2021-01-06",
                   "2021-03-29","2021-04-12","2021-05-17","2021-07-19","2021-12-08","2022-02-24"))
alpha <- c(0.5,0.4,0.3,0.3,0.5,0.4,0.5,0.4,0.3,0.2,0.1,0.2)
strindf <- data.frame(date1,date2,alpha)
rm(date1, date2, alpha)

### Building final graphs

#Creating function to add stringency bars
barfunction <- function(date1, date2, alpha){
  a <- annotate(geom = "rect",
                xmin = as.Date(date1), xmax = as.Date(date2), ymin = 0, ymax = Inf, alpha = alpha, fill = "red")
  return(a)
}

##Comp line graph
#Adding initial data
ggp <- ggplot(NULL, aes(x = date, y = covid)) + 
  geom_spline(data = onsdf, 
              aes(x = date, y = covid, colour = "ONS Modelled Estimates"), nknots = 90, size = 1.3) +
  geom_spline(data = gvtdf, 
              aes(x = date, y = covid, colour = "Gvt Reported Positive Tests"), nknots = 90, size = 1.3) 


#Adding lockdown stringency bars
ggp <- ggp + purrr::pmap(strindf, barfunction) 


#Adding aesthetics
ggp <- ggp + labs(title = "Estimated vs Reported Covid Cases over lockdown", 
                  subtitle = "Data sourced from ONS, UK Government and Institute for Government", 
                  x = "Date (year - month)", y = "Covid Cases") +
  scale_y_continuous(labels = scales::comma) +
  scale_x_date(limits = as.Date(c("2020-05-03", NA ))) +
  scale_colour_manual(name = "Legend",
                      values = c("ONS Modelled Estimates"="khaki4", 
                                 "Gvt Reported Positive Tests" = "darkcyan",
                                 "Lockdown Stringency"="red"))
ggp
#Save graph
ggsave("comp_line_6422.pdf", path = here::here("Figures"))


##Dual axis plot
#Adding initial data
coeff <- 0.05

compggp <- ggplot(NULL, aes(x = date, y = covid)) +
  geom_spline(data = onsdf, 
              aes(x = date, y = covid, colour = "ONS Modelled Estimates"), nknots = 90, size = 1.3) +
  geom_spline(data = gvtdf, 
              aes(x = date, y = covid/coeff, colour = "Gvt Reported Positive Tests"), nknots = 90, 
              size = 1.3)

#Stringency bars
compggp <- compggp + purrr::pmap(strindf, barfunction)

#Adding aesthetics
compggp <- compggp + scale_x_date(limits = as.Date(c("2020-05-03", NA ))) +
  theme_minimal() +
  scale_y_continuous(labels = scales::comma) +
  labs(x = "Date (year - month)", y = "Covid Cases (estimated and reported)") + 
  scale_y_continuous(labels = scales::comma, name = "Modelled Population Estimates", 
                     sec.axis = sec_axis(~.*coeff, name = "Reported Positive Tests")) +
  scale_colour_manual(name = "",
                      values = c("ONS Modelled Estimates"="khaki4", 
                                 "Gvt Reported Positive Tests" = "darkcyan",
                                 "Lockdown Stringency" = "red"))
compggp
#Saving graph
ggsave("dual_y_6422.pdf", path = here::here("Figures"))


####################################### Shiny dual Y axis plot ################################################

library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Positive tests vs Estimates: How do the metrics compare in scale and variance"),
  sidebarLayout(
    sidebarPanel(
      width = 2,
      sliderInput("scalegvt","Scale Positive Test Results by:",  min = 1.0, max = 26, value = c(1.0)),
      sliderInput("scaleons", "Scale Population Estimates by:", min = 0.05, max = 1.0, value = c(1.0))
    ),
    
    mainPanel(
      width = 10, 
      plotOutput("distPlot")
    )
  )
)

## Creating server 
server <- function(input, output) {
  coeff1 <- reactive({input$scalegvt
  })
  coeff2 <- reactive({input$scaleons
  })
  output$distPlot <- renderPlot({
    compggp <- ggplot(NULL, aes(x = date, y = covid)) +
      geom_spline(data = onsdf, 
                  aes(x = date, y = covid*coeff2(), colour = "Population Estimates"), nknots = 90, size = 1.3) +
      geom_spline(data = gvtdf, 
                  aes(x = date, y = covid*coeff1(), colour = "Reported Positive Tests"), nknots = 90, 
                  size = 1.3)
    
    #Stringency bars
    compggp <- compggp + purrr::pmap(strindf, barfunction)
    
    #Adding aesthetics
    compggp <- compggp + scale_x_date(limits = as.Date(c("2020-05-03", NA ))) +
      theme_minimal() +
      theme(text = element_text(size = 20)) +
      scale_y_continuous(labels = scales::comma) +
      labs(x = "Date (year - month)", y = "Covid Cases (estimated and reported)") + 
      scale_y_continuous(labels = scales::comma) +
      scale_colour_manual(name = "",
                          values = c("Population Estimates"="khaki4", 
                                     "Reported Positive Tests" = "darkcyan",
                                     "Lockdown Stringency" = "red"))
    compggp
  }, height = 600, width = 1200)
}

# Running application
shinyApp(ui = ui, server = server)

#########################################################################################################

