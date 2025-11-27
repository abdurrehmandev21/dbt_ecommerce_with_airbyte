with

raw_products as (

    select * from {{ source('bigquery_extracted_data', 'raw_products') }}

),

final as (

    select
        product_id,
        trim(name)::varchar(100) as product_name,
        trim(category)::varchar(100) as category,
        
        case price 

            when null then 0

            else price
        
        end::numeric as price

    from raw_products

)

select * from final