--Write a query to find the maximum duration one could stay in each of these listings, based on the availability and what the owner allows.
--Write a variation of the maximum duration for listings that have both a lockbox and a first aid kit listed in the amenities.

WITH consecutive_date AS (
SELECT
listing_id,
minimum_nights,
maximum_nights,
calendar_date,
CASE WHEN calendar_date = lag(calendar_date) over (partition by listing_id order by calendar_date asc) + 1
     THEN 1 else 0 end as consecutive_avail_yn
FROM {{ ref('listing_by_day') }} 
where available = 't' 
-- AND has_lockbox = 1 
-- AND has_first_aid = 1 
)

, group_dates AS (
select
listing_id,
minimum_nights,
maximum_nights,
calendar_date,
consecutive_avail_yn,
CASE WHEN consecutive_avail_yn = 0 THEN 0
    ELSE
        ROW_NUMBER() OVER (PARTITION BY listing_id ORDER BY calendar_date)
        - ROW_NUMBER() OVER (PARTITION BY listing_id, consecutive_avail_yn ORDER BY calendar_date ASC)
    end AS grp
from consecutive_date
)


, avail_dates AS (
select
listing_id,
minimum_nights,
maximum_nights,
grp,
min(calendar_date) as min_date,
max(calendar_date) as available_end_date,
DATE_ADD(min(calendar_date), INTERVAL -1 DAY) as available_start_date
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
-- taking into consideration the max # of nights property owner allows 
from int
)


select
unoccupied_nights,
count(distinct listing_id) as count_listings
from final
group by 1
order by 1 desc

