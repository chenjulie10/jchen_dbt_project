select
    station_id,
    station_name,
    region_id,
    rental_methods,
    station_capacity,
    num_bikes_available,
    num_bikes_disabled,
    num_docks_available,
    num_docks_disabled,
    case
        when
            num_bikes_available
            + num_bikes_disabled
            + num_docks_available
            + num_docks_disabled
            = station_capacity
        then true
        else false
    end as accurate_capacity
from {{ ref("stg_citibike_stations") }}
