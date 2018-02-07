#Load the dataset from CPSData.csv into a data frame called CPS, and view the dataset with the summary() and str() commands.

#How many interviewees are in the dataset?
#131302
CPS = read.csv("CPSData.csv")
str(CPS)
summary(CPS)

#Among the interviewees with a value reported for the Industry variable, what is the most common industry of employment?
Educational and health services
sort(table(CPS$Industry))

#Which state has the fewest interviewees?
#New Mexico
#Which state has the largest number of interviewees?
#California
names(CPS)
sort(table(CPS$State))

#What proportion of interviewees are citizens of the United States?
#123712/131302=0.942
sort(table(CPS$Citizenship))

#The CPS differentiates between race and ethnicity. 
#A number of interviewees are of Hispanic ethnicity, as captured by the Hispanic variable. 
#For which races are there at least 250 interviewees in the CPS dataset of Hispanic ethnicity? 
table(CPS$Race, CPS$Hispanic)

#Which variables have at least one interviewee with a missing (NA) value?
summary(CPS)

#Determine if there is a pattern in the missing values of the Married variable
#The CPS does not ask about marriage status for interviewees 14 and younger.
table(CPS$Region, is.na(CPS$Married))
table(CPS$Sex, is.na(CPS$Married))
table(CPS$Age, is.na(CPS$Married))
table(CPS$Citizenship, is.na(CPS$Married))

#How many states had all interviewees living in a non-metropolitan area?
# 2 Alaska and Wyoming 
#How many states had all interviewees living in a metropolitan area?
# 3 District of Columbia, New Jersey, and Rhode Island
table(CPS$State, is.na(CPS$MetroAreaCode))


#Which region of the United States has the largest proportion of interviewees living in a non-metropolitan area?
#Midwest
table(CPS$Region, is.na(CPS$MetroAreaCode))


#Which state has a proportion of interviewees living in a non-metropolitan area closest to 30%?
#Wisconsin
#Which state has the largest proportion of non-metropolitan interviewees, ignoring states where all interviewees were non-metropolitan?
#Montana
sort(tapply(is.na(CPS$MetroAreaCode), CPS$State, mean))

#Read two dictionaries into data frames MetroAreaMap and CountryMap
#How many observations (codes for metropolitan areas) are there in MetroAreaMap?
#271
#How many observations (codes for countries) are there in CountryMap?
#149
MetroAreaMap = read.csv("MetroAreaCodes.csv")
CountryMap = read.csv("CountryCodes.csv")
str(MetroAreaMap)
nrow(MetroAreaMap)
str(CountryMap)
nrow(CountryMap)

#To merge in the metropolitan areas, we want to connect the field MetroAreaCode from the CPS data frame with the field Code in MetroAreaMap.
CPS = merge(CPS, MetroAreaMap, by.x="MetroAreaCode", by.y="Code", all.x=TRUE)

#What is the name of the variable that was added to the data frame by the merge() operation
#MetroArea
#How many interviewees have a missing value for the new metropolitan area variable? 
#Note that all of these interviewees would have been removed from the merged data frame if we did not include the all.x=TRUE parameter.
#34238
str(CPS)
summary(CPS$MetroArea)
summary(CPS)

#Which of the following metropolitan areas has the largest number of interviewees?
which.max(table(CPS$MetroArea))

#Which metropolitan area has the highest proportion of interviewees of Hispanic ethnicity?
#Laredo, TX
sort(tapply(CPS$Hispanic, CPS$MetroArea, mean))


#Determine the number of metropolitan areas in the United States from which at least 20% of interviewees are Asian.
#Honolulu, HI; San Francisco-Oakland-Fremont, CA; San Jose-Sunnyvale-Santa Clara, CA; and Vallejo-Fairfield, CA 
sort(tapply(CPS$Race == "Asian", CPS$MetroArea, mean))


#Determine which metropolitan area has the smallest proportion of interviewees who have received no high school diploma.
#Iowa City, IA
sort(tapply(CPS$Education == "No high school diploma", CPS$MetroArea, mean, na.rm=TRUE))


#Integrating Country of Birth Data
CPS = merge(CPS, CountryMap, by.x="CountryOfBirthCode", by.y="Code", all.x=TRUE)
str(CPS)

#What is the name of the variable added to the CPS data frame by this merge operation?
#Country

#How many interviewees have a missing value for the new country of birth variable?
# 176
summary(CPS)


#Among all interviewees born outside of North America, which country was the most common place of birth?
#Philippines
sort(table(CPS$Country))


#Which metropolitan area has the largest number (note -- not proportion) of interviewees with a country of birth in India?
sort(tapply(CPS$Country == "India", CPS$MetroArea, sum, na.rm=TRUE))
#New York
sort(tapply(CPS$Country == "Brazil", CPS$MetroArea, sum, na.rm=TRUE))
#Boston
sort(tapply(CPS$Country == "Somalia", CPS$MetroArea, sum, na.rm=TRUE))
#Minneapolis

