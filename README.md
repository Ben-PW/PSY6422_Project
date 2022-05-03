# PSY6422_Project

&nbsp;  

[Link to published Markdown](https://ben-pw.github.io/PSY6422_Project/).  
[Link to final Shiny visualisation](https://ben-pw.shinyapps.io/PSY6422_Project/).  

&nbsp;

## Running this code yourself

If you'd like to run this code on your device, you will need to do a bit of set up beforehand. Create a new folder in your PC and store the R code and Rproj file there. Within that same folder, create folders called "Data" and "Figures" (the capitalisation is important). The CSV documents located in the corresponding "Data" folders of this project should then be stored in the "Data" folder on your device. From there, you just need to run the code - the static graphs will be stored in the "Figures" folder you created and the Shiny graph will be opened in your browser. 

&nbsp;

## Research Question 

&nbsp;

How effective is self testing for measuring the extent of infection in a population? Over the course of the pandemic, the UK Government relied heavily (although not entirely) on individuals to test themselves and report the result. Data on new positive tests was documented and used in public messaging. The Office for National Statistics (ONS), meanwhile, sent out a standard number of PCR tests to a random sample of the population every week and used this data to create a predictive model, estimating what the total prevalence of Covid-19 was in the population. Whilst it is never wise to assume a prediction is 100% accurate, the ONS estimates were (in my opinion) the closest approximation there is likely to be of what the actual Covid prevalence in the population was (i.e including aysmptomatic cases or cases where people did not test themselves). With this in mind, by comparing the government's positive test data with the ONS population estimates, I hoped to visualise how effective self testing and self reporting was at indicating the extent of the pandemic. 

There may also be time-rcontingent variances in the reliability of the government data; as mentioned the ONS sent a consistent test to a consistent sample, and did not vary this method. The Government's positive test data, on the other hand, was vulnerable to changing biases over time. By relying on self report, the data may have been biased by whether a positive test was beneficial for someone to report. For example, during furlough there was little reason not to report a positive test, however when a positive test meant people may have to isolate from work and subsequently lose money, there was now an incentive to not report. Which tests were accepted as a positive result (i.e deciding whether to accept lateral flow results or not) also varied. In summary, the ONS consistently used a consistent method on a consistent sample, whereas the government relied on self report over periods with varying incentives to report, with varying tests being used. Therefore, I wanted to visualise any differences in variance between the two metrics - whilst differences in scale were a given, did both metrics report peaks and troughs in the same periods, of similar sizes?

I was also interested to see how the two metrics behaved over the different stages of the lockdown, for this reason only the data from England was analysed as the different nations of the UK had differing responses to the pandemic. This meant that if I used Covid data from the entire UK, when trying to factor in the impact of lockdown measures I would have had to factor separate lockdown measures from all four nations. I felt that this undermine the validity of the comparison and, therefore, decided to use the data from the largest population (England). Data from the Institute for Government was used to plot this, as they had compiled a timeline of the Government's response to the pandemic. This was used in alongside data from the government's own announcements archive, in order to confirm the IfG timeline and fill in missing data. 

TLDR: the aim of this project was to visualise the estimated proportion of people in England who had Covid (asymptomatic or not) compared to the proportion of those people actually testing positive (and reporting it!), and how both of these metrics varied over the stages of the response to the pandemic.

&nbsp;

## Data Origins

&nbsp;

[Government positive test data](https://coronavirus.data.gov.uk/details/cases).  
[ONS modelled estimates](https://www.ons.gov.uk/peoplepopulationandcommunity/healthandsocialcare/conditionsanddiseases/bulletins/coronaviruscovid19infectionsurveypilot/18march2022).  
[Covid response timeline](https://www.instituteforgovernment.org.uk/charts/uk-government-coronavirus-lockdowns).  
[Covid response announcements](https://www.gov.uk/search/news-and-communications)

&nbsp;

## Further information

&nbsp;

For futher information on how the data was prepared and visualised, please refer to the published [Markdown document](https://github.com/Ben-PW/PSY6422_Project)
