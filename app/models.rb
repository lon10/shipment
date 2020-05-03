module Models
  class Product
    def self.get_all
      YAML.load_file('db/products.yml')
    end
  end
end
