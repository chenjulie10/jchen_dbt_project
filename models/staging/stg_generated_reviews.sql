SELECT 
id,
listing_id,
coalesce(id, listing_id|| review_score) as review_pk, -- if id is null, then return combination of listing ID and review score (assumes that there are no multiple rows with null ID and same listing ID and review score)
review_score,
review_date
FROM `julies-dbt-project.dbt_chenjulie10.generated_reviews`