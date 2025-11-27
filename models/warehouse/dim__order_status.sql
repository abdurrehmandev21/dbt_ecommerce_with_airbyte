with

order_statuses as (

    select
        distinct order_status
    
    from {{ ref('stg__orders') }}

),

final as (

    select
        row_number() over (order by order_status) as order_status_id,
        order_status
    
    from order_statuses

)

select * from final