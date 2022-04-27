# PSY6422_Project

&nbsp;

## Running this code yourself

If you'd like to run this code on your device, you will need to do a bit of set up beforehand. Create a new folder in your PC and store the R code there. Within that same folder, create folders called "Data" and "Figures" (the capitalisation is important). The CSV documents located in the corresponding "Data" folders of this project should then be stored in the "Data" folder on your device. From there, you just need to run the code - the static graphs will be stored in the "Figures" folder you created and the Shiny graph will be opened in your browser. 

&nbsp;

## Research Question 

&nbsp;

How effective is self testing for measuring the extent of infection in a population? Over the course of the pandemic, the UK Government relied heavily (although not entirely) on individuals to test themselves and report the result. Data on new positive tests was documented and used in public messaging. The Office for National Statistics (ONS), meanwhile, sent out a standard number of PCR tests to a random sample of the population every week and used this data to create a predictive model, estimating what the total prevalence of Covid-19 was in the population. 

There are several key differences in how the two organisations collected this data; as mentioned the ONS sent a consistent test to a consistent sample. The Government's positive test data, on the other hand, relied heavily on self report, varied which tests were accepted as a positive result (i.e deciding whether to accept lateral flow results or not), and was less sensitive to asymptomatic cases as individuals usually only ordered a test if they thought they were infectious. The difference in methodology here is key; the ONS used a consistent method in order to estimate the total population prevalence, whereas the government effectively relied on individuals taking a test and self reporting the result. I was interested to see just how different the results for these metrics might be.

I was also interested to see how the two metrics behaved over the different stages of the lockdown, for this reason only the data from England was analysed as the different nations of the UK had differing responses to the pandemic. Data from the Institute for Government was used to plot this, as they had compiled a timeline of the Government's response to the pandemic. This was used in alongside data from the government's own announcements archive, in order to confirm the IfG timeline and fill in missing data. 

In summary, the aim of this project was to visualise the estimated proportion of people in England who had Covid (aymptomatic or not), the proportion of those people actually testing positive (and reporting it!), and how both of these metrics varied over the stages of the response to the pandemic.
