with

raw_regions as (

    select * from {{ source('bigquery_extracted_data', 'raw_regions') }}

),

final as (

    select
        region_id,
        trim(region_name)::varchar(25) as region_name

    from raw_regions

)

select * from final