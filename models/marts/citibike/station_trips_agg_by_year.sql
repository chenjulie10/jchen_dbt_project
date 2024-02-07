{% set users = ['Subscriber', 'Customer'] %}

select 
extract(year from trip_start_date) as trip_year,
start_station_name,
count(distinct pk) as total_trips_started,
COUNT(DISTINCT CASE WHEN start_station_id = end_station_id THEN pk end) as total_round_trips,

  {% for rider in users %}
    count(distinct CASE WHEN user_type = '{{ rider }}' THEN pk ELSE NULL end) as {{ rider}}_trips_started,
    COUNT(DISTINCT CASE WHEN start_station_id = end_station_id AND user_type = '{{ rider }}' THEN pk ELSE NULL end) as {{ rider}}_round_trips
    {% if not loop.last %}
    , 
    {% endif %}
    {% endfor %}

from {{ ref('int_citibike_trips') }} 
group by 1,2
order by 1,2
