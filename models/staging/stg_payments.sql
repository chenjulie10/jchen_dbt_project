with source as (

    select * from raw.stripe.payment

),

staged as (

    select 
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    amount/100 as amount,
    created as created_date,
    _batched_at
    from source
)

select * from staged