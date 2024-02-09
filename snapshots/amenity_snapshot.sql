{% snapshot amenity_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key= 'changelog_pk',

      strategy='timestamp',
      updated_at='change_at',
    )
}}

select * from {{ source("dbt_chenjulie10", "amenities_changelog") }}

{% endsnapshot %}