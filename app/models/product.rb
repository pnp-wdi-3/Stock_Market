class Product < ApplicationRecord
    belongs_to :brunch
    validates :name , :brand , :category ,:quantity , :exp_date, :price , presence: true
    validates :quantity, numericality: {greater_than_or_equal_to: 0}
    validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/}, numericality: {greater_than_or_equal_to: 0 }

    before_save :calculate_receipt_tax
    # after_save :calculate_receipt_tax
    before_save :define_state
    before_save :define_Q

def calculate_receipt_tax
  if new_record? || price_changed?
    #  if self.price == 0
    @tax ||= self.price * 0.05 + self.price # Whatever you need to do here to calculate
    self.price = @tax.round(2)
    
  end
  
end

def define_state
  
    if self.exp_date < Date.today
       self.state = "Expierd" 
    elsif
      self.exp_date - Date.today >=  0 &&  self.exp_date - Date.today < 3
      self.state = "Almost expierd" 
    else
      self.state = "Good" 
    end

  
  end

  def define_Q
    if self.quantity == 0
      self.state = "Out of stock!" 
    end
  end


end
