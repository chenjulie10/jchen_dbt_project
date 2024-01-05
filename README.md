### CITIBIKE DBT PROJECT
I have created some staging, intermediate and mart models for Citibike data to answer some questions: 
- Which citibike stations are the most popular? (In terms of trips started)
- Which citibike stations are most popular (trips to bikes enabled ratio)? 
- What is the average length of citibike trips?
- Which citibike stations need to accept more returns? (look at the # of end trips/# of docks available) 

You can find queries for the dbt models in the Analyses folder. 

Best practices that I considered in the dbt project: 
- is there a primary key? 
- deduplication
- Incorporating tests for specific columns to ensure values are not null
  
