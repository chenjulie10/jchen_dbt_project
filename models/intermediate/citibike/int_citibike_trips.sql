with
    stg_trips as (
        select
            pk,
            start_station_id,
            start_station_name,
            trip_start_ts,
            trip_start_date,
            trip_start_month,
            end_station_id,
            end_station_name,
            trip_end_ts,
            trip_end_date,
            trip_length_mins,
            user_type,
            date_diff(trip_end_date, trip_start_date, day) as trip_length_days,
            case
                when start_station_id = end_station_id then 1 else 0
            end as round_trip_yn
        from {{ ref("stg_citibike_trips") }}
    )

    -- dedupe rows 
    {{
        dbt_utils.deduplicate(
            relation="stg_trips",
            partition_by="pk",
            order_by="trip_end_ts",
        )
    }}
