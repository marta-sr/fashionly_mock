view: sql_derived_table {
  derived_table: {
    sql: SELECT
          order_items.user_id  AS order_items_user_id,
          COALESCE(SUM(CASE WHEN ( order_items.STATUS  NOT IN ('Cancelled', 'Returned') OR ( order_items.STATUS ) IS NULL) THEN order_items.sale_price  ELSE NULL END), 0) AS order_items_total_revenue,
          COUNT(DISTINCT order_items.order_id ) AS order_items_total_orders
      FROM `thelook.order_items`
           AS order_items
      GROUP BY
          1
      ORDER BY
          2 DESC
      LIMIT 500
       ;;
  #remove limit
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_items_user_id {
    type: number
    sql: ${TABLE}.order_items_user_id ;;
  }

  dimension: order_items_total_revenue {
    type: number
    sql: ${TABLE}.order_items_total_revenue ;;
  }

  dimension: order_items_total_orders {
    type: number
    sql: ${TABLE}.order_items_total_orders ;;
  }

  set: detail {
    fields: [order_items_user_id, order_items_total_revenue, order_items_total_orders]
  }
}
