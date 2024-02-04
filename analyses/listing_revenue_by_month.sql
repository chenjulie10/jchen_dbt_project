
With revenue AS (
select
extract(year from calendar_date) ||'-'|| extract(month from calendar_date) as year_month,
sum(price) as total_monthly_revenue,
SUM(CASE WHEN has_AC = 1 THEN price else null end) as total_revenue_has_AC,
SUM(CASE WHEN has_AC = 0 THEN price else null end) as total_revenue_no_AC
from {{ ref('listing_by_day') }}
where available = 'f' --if availability is false, then it means listing is booked for that day
group by 1
)


select
year_month,
total_monthly_revenue,
total_revenue_has_AC,
total_revenue_no_AC,
ROUND((total_revenue_has_AC/total_monthly_revenue)*100,0)||'%' as pct_revenue_has_AC,
ROUND((total_revenue_no_AC/total_monthly_revenue)*100,0)||'%' as pct_revenue_no_AC
from revenue
order by year_month ASC
