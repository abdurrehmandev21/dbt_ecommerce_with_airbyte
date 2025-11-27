with

raw_customers as (

    select
        id,
        name,
        email,
        region_id

    from {{ source('bigquery_extracted_data','raw_customers') }}

),

final as (

    select 
        id as customer_id,
        trim(name)::varchar(100) as customer_name,
        trim(email)::varchar(255) as customer_email,
        region_id as region_id

    from raw_customers

)

select * from final