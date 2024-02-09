select
    id,
    listing_id,
    coalesce(id, listing_id || review_scores) as review_pk,  -- if id is null, then return combination of listing ID and review date (assumes that there are no multiple rows with null ID and same listing ID and review score)
    review_score,
    review_date
from {{ source("dbt_chenjulie10", "generated_reviews") }}
