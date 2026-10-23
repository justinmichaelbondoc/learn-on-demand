with pivoted as (

    select * from {{ ref('int_orders__pivoted') }}

),

final as (

    select
        order_id,
        bank_transfer_amount,
        credit_card_amount,
        coupon_amount,
        gift_card_amount,
        bank_transfer_amount + credit_card_amount + coupon_amount + gift_card_amount as total_amount,
        row_number() over (
            order by bank_transfer_amount + credit_card_amount + coupon_amount + gift_card_amount desc
        ) as payment_amount_rank

    from pivoted

)

select * from final
