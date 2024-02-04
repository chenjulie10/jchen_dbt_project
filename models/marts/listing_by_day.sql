{% set amenities = {
   "Lockbox": "lockbox",
   "First aid kit": "first_aid",
   "Air conditioning": "AC"
} %}


SELECT 
listing_id,
reservation_id,
calendar_date,
listing_date,
available,
price, 
minimum_nights,
maximum_nights,
avg_review_score,
neighborhood,
amenities,
{% for amenity, name in amenities.items() -%}
    has_{{name}}
{% if not loop.last -%}
    , 
{%- endif -%}
{% endfor %}

FROM {{ ref('int_daily_listing')}}