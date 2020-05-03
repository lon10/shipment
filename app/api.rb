module API
  class ShipmentAPI < Grape::API
    version 'v1', using: :header, vendor: :shipment
    format :json
    prefix :api

    resource :delivery do
      post 'Calculate delivery time', {
        params: ::Entities::Cart.documentation
      }
      params do
         requires :region, type: String
         requires :items, type: Array
      end
      post do
        repository = ::Repositories::Product.new(params[:region], params[:items])
        products = repository.find_optimized
        present products, with: ::Entities::Delivery
      end
    end
  end

  class Root < Grape::API
    format :json
    mount ::API::ShipmentAPI
    add_swagger_documentation
  end
end
