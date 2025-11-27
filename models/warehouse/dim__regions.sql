with

regions as (

    select * from {{ ref('stg__regions') }}

),

final as (

    select
        region_id,
        region_name
    
    from regions

)

select * from final