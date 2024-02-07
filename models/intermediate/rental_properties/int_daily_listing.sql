{% set amenities = {
   "Lockbox": "lockbox",
   "First aid kit": "first_aid",
   "Air conditioning": "AC"
} %}


with scores AS (
select 
a.calendar_date,
a.listing_id,
round(AVG(review_score),1) as avg_review_score
from {{ ref('stg_calendar')}}  a 
left join {{ ref('stg_generated_reviews')}} b
  on a.listing_id = b.listing_id
  AND b.review_date <= a.calendar_date     -- in this dataset, all review_dates occurred before. Doing this join to include reviews that may occur on the same calendar date. 
group by 1,2 
) 


SELECT 
c.listing_id,
c.reservation_id,
c.calendar_date,
c.listing_date,
c.available,
c.price, 
c.minimum_nights,
c.maximum_nights,
scores.avg_review_score,
l.neighborhood,
l.amenities,
{% for amenity, name in amenities.items() -%}
    l.has_{{name}}
{% if not loop.last -%}
    , 
{%- endif -%}
{% endfor %}

FROM {{ ref('stg_calendar')}} c 
left join {{ ref('stg_listings')}} l 
  on c.listing_id = l.listing_id
left join scores
  on c.listing_id = scores.listing_id 
  and c.calendar_date = scores.calendar_date