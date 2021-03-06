class Product < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :product_category
  has_many :product_invoice_lines

# Validations on inputs
  validates_presence_of :supplier, :description, :cost_price, :manufacturer, :model, :sell_price, :our_sku, :supplier_sku
  validates_uniqueness_of :our_sku
  validates_numericality_of :qty_allocated, :cost_price, :disc_amount, :disc_percent, :qty_available, :qty_on_hand, :qty_ordered, :sell_price, :tax_rate
  validates_numericality_of :disc_percent, :tax_rate, :less_than_or_equal_to => 100
  
# Define Active value to 1 on creation of new product
  before_create :create_product
  def create_product
    self.active ||= "1"
  end

# Search by 
  def self.search_products(search_products, sort_column, sort_direction)
      Product.where('description LIKE  ?', "%#{search_products}%").order(sort_column+ " "+sort_direction)

  end

  def product_category_name
    product_category.name if product_category
  end
  def product_category_name=(name)
    self.product_category_id = ProductCategory.find_or_create_by_name(name) unless name.blank?

  end


  def product_lookup
     # mytodo - Add currency symbol if possible.....
     "[#{our_sku}] - #{description} -#{I18n.t 'number.currency.format.unit'}#{sell_price}"
  end
end
