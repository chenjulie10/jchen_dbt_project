

select 
listing_id,
reservation_id,
date as calendar_date,
listing_id||' | '||date as listing_date,
available,
price, 
minimum_nights,
maximum_nights
from `julies-dbt-project.dbt_chenjulie10.calendar`






