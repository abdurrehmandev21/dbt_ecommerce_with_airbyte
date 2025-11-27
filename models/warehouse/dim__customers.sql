with

customers as (

    select * from {{ ref('stg__customers') }}

),

regions as (

    select * from {{ ref('stg__regions') }}

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk,
        c.customer_id,
        c.customer_name,
        c.customer_email,
        r.region_name
    
    from customers c

    left join regions r
        on c.region_id = r.region_id

)

select * from final