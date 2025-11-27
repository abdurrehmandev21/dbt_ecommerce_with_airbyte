with

products as (

    select * from {{ ref('stg__products') }}

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_sk,
        product_id,
        product_name,
        category,
        price
    
    from products

)

select * from final



