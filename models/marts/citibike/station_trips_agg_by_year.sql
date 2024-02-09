{% set users = ["Subscriber", "Customer"] %}

select
    extract(year from trip_start_date) as trip_year,
    start_station_name,
    count(distinct pk) as total_trips_started,
    count(
        distinct case when start_station_id = end_station_id then pk end
    ) as total_round_trips,

    {% for rider in users %}
        count(
            distinct case when user_type = '{{ rider }}' then pk else null end
        ) as {{ rider }}_trips_started,
        count(
            distinct case
                when start_station_id = end_station_id and user_type = '{{ rider }}'
                then pk
                else null
            end
        ) as {{ rider }}_round_trips
        {% if not loop.last %}, {% endif %}
    {% endfor %}

from {{ ref("int_citibike_trips") }}
group by 1, 2
order by 1, 2
