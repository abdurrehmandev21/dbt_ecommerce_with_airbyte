with

raw_orders as (

    select * from {{ source('bigquery_extracted_data', 'raw_orders') }}

),

transformed as (

    select
        order_id,
        customer_id,
        product_id,
        region_id,
        order_date::date,
        cast(to_char(order_date::date, 'yyyymmdd') AS integer) as order_date_int,

        case 
            when quantity is null then 
                0
            else
                quantity

        end::integer as quantity,

        case
            when unit_price is null then 
                0
            else 
                unit_price
        
        end::numeric as unit_price,
        
        lower(trim(status))::varchar(25) as order_status

    from raw_orders

),

final as (

    select
        order_id,
        customer_id,
        product_id,
        region_id,
        order_date,
        order_date_int,
        quantity,
        unit_price,
        order_status,
        quantity * unit_price as total_amount -- data enrichment

    from transformed

)

select * from final