with

order_dates as (

    select  
        distinct order_date

    from {{ ref('stg__orders') }}

    where 
        order_date is not null

),

payment_dates as (

    select
        distinct payment_date

    from {{ ref('stg__payments') }}

    where
        payment_date is not null

),

all_dates as (

    select  
        order_date as date_day

    from order_dates

    union

    select  
        payment_date as date_day

    from payment_dates

),

final as (

    select 
        cast(to_char(date_day, 'yyyymmdd') AS integer) as date_id,
        date_day,

        extract(year from date_day) as year,
        extract(quarter from date_day) as quarter,
        extract(month from date_day) as month,
        extract(day from date_day) as day,
        extract(week from date_day) as week,
        extract(dow from date_day) as day_of_week,

        to_char(date_day, 'Day') as day_name,
        to_char(date_day, 'Month') as month_name,

        case
            when extract(dow from date_day) in (6,0) then true
            else false
        end as is_weekend,

        date_trunc('month', date_day) as first_day_of_month,
        (date_trunc('month', date_day) + interval '1 month - 1 day')::date as last_day_of_month,
        date_trunc('quarter', date_day) as first_day_of_quarter,
        (date_trunc('quarter', date_day) + interval '3 month - 1 day')::date as last_day_of_quarter,
        date_trunc('year', date_day) as first_day_of_year,
        (date_trunc('year', date_day) + interval '1 year - 1 day')::date as last_day_of_year,
        
        -- Fiscal year example (starts in July)
        case
            when extract(month from date_day) >= 7
            then extract(year from date_day) + 1
            else extract(year from date_day)
        end as fiscal_year,

        case
            when extract(month from date_day) between 7 and 9 then 1
            when extract(month from date_day) between 10 and 12 then 2
            when extract(month from date_day) between 1 and 3 then 3
            when extract(month from date_day) between 4 and 6 then 4
        end as fiscal_quarter

    from all_dates

    order by date_day

)

select * from final