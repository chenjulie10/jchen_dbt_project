{% set amenities = {
    "Lockbox": "lockbox",
    "First aid kit": "first_aid",
    "Air conditioning": "AC",
} %}

select
    id as listing_id,
    name,
    host_id,
    host_name,
    host_since,
    host_location,
    host_verifications,
    neighborhood,
    property_type,
    room_type,
    accommodates,
    bathrooms_text as num_baths,
    bedrooms as num_bedrooms,
    beds as num_beds,
    amenities,
    price,
    number_of_reviews,
    first_review as first_review_date,
    last_review as last_review_date,
    review_scores_rating,

    {% for amenity, name in amenities.items() -%}

        case when amenities like '%{{amenity}}%' then 1 else 0 end as has_{{ name }}

        {% if not loop.last -%}, {%- endif -%}

    {% endfor %}

from {{ source("dbt_chenjulie10", "listings") }}
