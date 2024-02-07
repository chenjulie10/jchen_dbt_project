### CITIBIKE 
I created a few staging, intermediate and mart models for Citibike data to answer the following questions. See Models and Analyses folder.
- What top 10 stations were most popular YoY? (Based on the # of trips started)
- For these popular stations, which months had the most trips initiated?
  
### Rental Properties 
I created a few staging, intermediate and mart models using rental property data from csv files. I created a mart model at the listing ID and day grain to answer a few questions in the Analyses folder. 
- What is the total revenue and percentage of revenue by month segmented by whether or not air conditioning exists on the listing?
- What is the average price increase for each neighborhood from July 12th 2021 to July 11th 2022?
- What is the maximum duration one could stay in each of these listings, based on the availability and what the property owner allows?


Some practices I incorporated across my models: 
- Estabishing primary key
- Ensuring deduplication
- Using jinja templating to establish reusable code
- Adding tests on columns
- Using seeds for mapping
