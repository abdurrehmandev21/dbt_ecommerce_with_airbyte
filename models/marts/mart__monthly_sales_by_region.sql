with

fct__orders as (

    select * from {{ ref('fct__orders') }}

),

dim__dates as (

    select * from {{ ref('dim__dates') }}

),

dim__order_status as (

    select * from {{ ref('dim__order_status') }}

),

dim__regions as (

    select * from {{ ref('dim__regions') }}

),

final as (

    select
        r.region_name,
        dd.year,
        dd.month_name,
        sum(o.total_amount) as total_sales,
        sum(o.amount_paid) as total_paid,
        sum(coalesce(o.total_amount, 0) - coalesce(o.amount_paid, 0)) as pending_amount

    from fct__orders o

    left join dim__regions r
        on o.region_id = r.region_id

    left join dim__dates dd
        on o.order_date_id = dd.date_id

    left join dim__order_status os
        on o.order_status_id = os.order_status_id

    group by region_name, year, month_name

)

select * from final

