with

raw_payments as (

    select 
        payment_id,
        order_id,
        payment_date,
        payment_method,
        amount
    
    from {{ source('bigquery_extracted_data', 'raw_payments') }}

),

final as (

    select
        payment_id,
        order_id,
        payment_date::date,
        cast(to_char(payment_date::date, 'yyyymmdd') AS integer) as payment_date_int,

        case upper(trim(payment_method))

            when 'BANK TRANSFER' then 'bank transfer'

            when 'PAYPAL' then 'paypal'

            when 'DEBIT CARD' then 'card'

            when 'CREDIT CARD' then 'card'

            when 'CASH' then 'cash'

            else lower(trim(payment_method))

        end::varchar(50) as payment_method,

        case amount
            
            when null then 0

            else amount
        
        end::numeric as amount_paid

    from raw_payments

)

select * from final