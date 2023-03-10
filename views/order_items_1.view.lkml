view: order_items {
  sql_table_name: `thelook.order_items`
    ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }


  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }



  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }


  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }


  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.STATUS;;
  }

  measure: count {
    type: count
  }

  ###### las q orders ######
  dimension_group: since_created {
    type: duration
    intervals: [
      day,
      week,
      month
    ]
    sql_start: ${created_date} ;;
    sql_end: current_date() ;;
  }

  dimension: is_new_campaign_order {
    type: yesno
    sql: ${months_since_created} < 4 ;;
  }

  measure: total_revenue_new_campaign_orders{
    type: sum
    sql: ${sale_price} ;;
    filters: [status: "-Cancelled,-Returned", is_new_campaign_order: "Yes"]
    value_format: "$0.00"
  }

  measure: total_orders {
    type: count_distinct
    sql: ${order_id} ;;
  }

  measure: total_revenue{
    type: sum
    sql: ${sale_price} ;;
    filters: [status: "-Cancelled,-Returned"]
    value_format: "$0.00"
  }

}
