--Write a query to find the average price increase for each neighborhood from July 12th 2021 to July 11th 2022.

with old_year AS (
 select
neighborhood,
listing_id,
price
from  {{ ref('listing_by_day') }}
where date = '2021-07-12'
)


, new_year AS (
 select
neighborhood,
listing_id,
price
from  {{ ref('listing_by_day') }}
where date = '2022-07-11'
)


, query AS (
select
a.neighborhood,
a.listing_id,
a.price as old_price,
b.price as new_price,
b.price - a.price as price_diff
from old_year a
 left join new_year b
   on a.listing_id = b.listing_id
)


select
neighborhood,
round(avg(price_diff),2) as price_increase
from query
group by 1
order by 1 asc