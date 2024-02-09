{% set amenities = {
   "Lockbox": "lockbox",
   "First aid kit": "first_aid",
   "Air conditioning": "AC"
} %}


select 
listing_id,
change_at, 
{{ dbt_utils.generate_surrogate_key(['listing_id', 'change_at']) }} as changelog_pk,
amenities,

{% for amenity, name in amenities.items() -%}

case when amenities like '%{{amenity}}%' then 1 else 0 end as has_{{name}}

{% if not loop.last -%}
    , 
{%- endif -%}

{% endfor %}

from {{ source('dbt_chenjulie10','amenities_changelog') }} 