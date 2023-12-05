SELECT 
station_id,
name as station_name,
short_name,
latitude,
longitude,
region_id,
rental_methods,
--ARRAY_TO_STRING(PARSE_JSON(rental_methods), ',') AS rental_options,
capacity,
eightd_has_key_dispenser,
num_bikes_available,
num_bikes_disabled,
num_docks_available,
num_docks_disabled,
is_installed,
is_renting,
is_returning,
eightd_has_available_keys,
last_reported as last_reported_ts
FROM `bigquery-public-data.new_york_citibike.citibike_stations`
WHERE is_installed = TRUE -- filter for stations that are currently on the streets 