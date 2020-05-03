module Entities
  class Cart < Grape::Entity
    expose :region, documentation: { type: 'String', desc: 'Region to deliver' }
    expose :items, documentation: { type: '::Entities::ShipmentItem', is_array: true }
  end

  class Delivery < Grape::Entity
    expose :delivery_date, documentation: { type: 'String', desc: 'Delivery Date' }
    expose :shipments,  documentation: {type: '::Entities::Shipments', is_array: true }
  end

  class Shipments < Grape::Entity
    expose :supplier, documentation: { type: 'String', desc: 'Supplier' }
    expose :delivery_date, documentation: { type: 'String', desc: 'Delivery Date' }
    expose :items, documentation: { type: '::Entities::ShipmentItem', is_array: true }
  end

  class ShipmentItem < Grape::Entity
    expose :title, documentation: { type: 'String', desc: 'Title' }
    expose :count, documentation: { type: 'Integer', desc: 'Count' }
  end
end
