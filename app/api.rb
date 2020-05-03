module API
  class ShipmentAPI < Grape::API
    version 'v1', using: :header, vendor: :shipment
    format :json
    prefix :api

    resource :delivery do
      desc 'Calculate delivery time', {
        params: ::Entities::Cart.documentation
      }
      post do
        result = {}
        present result, with: ::Entities::Delivery
      end
    end
  end

  class Root < Grape::API
    format :json
    mount ::API::ShipmentAPI
    add_swagger_documentation
  end
end
