module Builders
  class DeliveryBuilder
    def initialize(products, items, region)
      @products = products
      @items = items
      @region = region.to_s
    end

    def build
      {
        delivery_date: delivery_date(@products),
        shipments: shipments
      }
    end

    private

    def shipments
      @products.group_by { |product| product['supplier']}.map do |supplier, products| 
        {
          supplier: supplier,
          delivery_date: delivery_date(products),
          items: delivery_items(products)
        }
      end
    end

    def delivery_items(delivery_products)
      delivery_products.group_by { |product| product['product_name']}.map do |name, products|
        {
          title: name,
          count: products.count
        }
      end
    end

    def delivery_date(delivery_products)
      max_delivery = @products.map { |product| product['delivery_times'][@region] }.max

      (Date.today + max_delivery.days).strftime('%m-%d-%Y')
    end
  end
end
