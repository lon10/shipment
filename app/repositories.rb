module Repositories
  class Product
    def initialize(region, items)
      @region = region.to_sym
      @items = items
    end

    def find_optimized
      optimized_by_supplier = get_optimized_by_supplier

      if optimized_by_supplier.present?
        optimized_by_supplier
      else
        get_optimized_by_region
      end
    end

    private

    def products_by_names
      @products_by_names ||= ::Models::Product.get_all.select { |product|
        @items.map { |item| item[:title] }.include?(product['product_name'])
      }
    end

    def get_optimized_by_supplier
      products_by_names.group_by { |product|
        product['supplier']
      }.map { |supplier, grouped_products|
        @items.flat_map { |item|
          grouped_products.find { |grouped_product|
            grouped_product['product_name'] == item[:title] && grouped_product['in_stock'] >= item[:count]
          }
        }
      }.select(&:all?).flatten.flat_map do |product|
        item = @items.find { |item|
          item[:title] == product['product_name']
        }

        item.dig(:count).times.collect { [product] }.flatten
      end
    end

    def get_optimized_by_region
      plain_products = products_by_names.map { |product|
        product['in_stock'].times.collect { [product] }
      }.flatten.sort_by {|product|
        product['product_name'] &&
        product['supplier'] &&
        product['delivery_times'][@region]
      }.group_by{ |product|
        product['product_name']
      }

      @items.flat_map { |item|
        plain_products[item[:title]].take(item[:count])
      }
    end
  end
end
