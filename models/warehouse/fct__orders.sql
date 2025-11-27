{{ config(materialized='incremental', unique_key='order_id') }}

with

orders as (
    
    select * from {{ ref('stg__orders') }}

),

payments as (
    
    select * from {{ ref('stg__payments') }}

),

dim__customers as (

    select * from {{ ref('dim__customers') }}

),

dim__products as (

    select * from {{ ref('dim__products') }}

),

dim__dates as (

    select * from {{ ref('dim__dates') }}

),

dim__order_status as (

    select * from {{ ref('dim__order_status') }}

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['o.order_id']) }} as order_sk,
        o.order_id,
        c.customer_sk,
        prd.product_sk,
        o.region_id,
        o.quantity,
        o.unit_price,
        o.total_amount,

        p.amount_paid,
        os.order_status_id,

        dd1.date_id as order_date_id,
        dd2.date_id as payment_date_id

    from orders o

    left join dim__customers c
        on o.customer_id = c.customer_id

    left join dim__products prd
        on o.product_id = prd.product_id

    left join dim__order_status os
        on o.order_status = os.order_status

    left join dim__dates dd1
        on o.order_date_int = dd1.date_id

    left join payments p
        on o.order_id = p.order_id

    left join dim__dates dd2
        on p.payment_date_int = dd2.date_id

)

select * from final

{% if is_incremental() %}
    where order_date_id > (select max(order_date_id) from {{ this }})
{% endif %}