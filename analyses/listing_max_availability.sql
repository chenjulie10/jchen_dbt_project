--Write a query to find the maximum duration one could stay in each of these listings, based on the availability and what the owner allows.
--Write a variation of the maximum duration for listings that have both a lockbox and a first aid kit listed in the amenities.

WITH consecutive_date AS (
SELECT
listing_id,
minimum_nights,
maximum_nights,
date,
lag(date) over (partition by listing_id order by date asc) previous_date,
CASE WHEN date = lag(date) over (partition by listing_id order by date asc) + 1
     THEN 1 else 0 end as consecutive_avail_yn,
FROM `julies-dbt-project.dbt_chenjulie10.int_daily_listing`
where available = 't'
-- AND has_lockbox = 1 
-- AND has_first_aid = 1 
order by date asc
)

, group_dates AS (
select
*,
CASE WHEN consecutive_avail_yn = 0 THEN 0
ELSE
ROW_NUMBER() OVER (PARTITION BY listing_id ORDER BY date)
- ROW_NUMBER() OVER (PARTITION BY listing_id, consecutive_avail_yn ORDER BY date ASC)
end AS grp
from consecutive_date
order by date asc
)


, avail_dates AS (
select
listing_id,
grp,
minimum_nights,
maximum_nights,
min(date) as min_date,
max(date) as available_end_date,
DATE_ADD(min(date), INTERVAL -1 DAY) available_start_date
from group_dates
group by 1,2,3,4
having grp > 0
order by grp
)


, int AS (
select *
, date_diff(available_end_date, available_start_date, DAY) + 1 as nights_available
from avail_dates
)


, final AS (
select *
, CASE WHEN maximum_nights <= nights_available THEN maximum_nights ELSE nights_available end as unoccupied_nights
from int
)


select
unoccupied_nights,
count(distinct listing_id) as count_listings
from final
group by 1
order by 1 desc

