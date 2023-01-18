# If necessary, uncomment the line below to include explore_source.
# include: "fashionly_mock.model.lkml"

view: orders_and_revenue {
  derived_table: {
    explore_source: order_items {
      column: total_revenue {}
      column: total_orders {}
      column: user_id {}
    }
  }
  dimension: total_revenue {
    description: ""
    value_format: "$0.00"
    type: number
  }
  dimension: total_orders {
    description: ""
    type: number
  }
  dimension: user_id {
    primary_key: yes
    description: ""
    type: number
  }

  dimension: total_revenue_tiers {
    type: tier
    tiers: [0, 5, 20,50,100, 500, 1000]
    style: integer
    sql: ${total_revenue} ;;
  }

  dimension: customer_lifetime_orders_tiers {
    type: tier
    tiers: [0, 1, 2, 3, 6, 9, 10]
    style: integer
    sql: ${total_orders} ;;
  }

  measure: average_lifetime_orders {
    type: average
    sql: ${total_orders} ;;
  }

  measure: count {
    type: count
  }

}
