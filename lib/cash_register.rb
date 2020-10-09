require 'pry'
class CashRegister
    attr_accessor :total, :discount
    @@prices = []
    @@items  = []
    @@quantities = []
    
    def initialize(discount=0)
        @total      = 0.0
        @discount   = discount  
        @@prices    = []
        @@items     = []
        @@quantities = []
    end

    def add_item(title, price, quantity = 1)
        @total += (price * quantity)
        track_prices(price, quantity)
        track_items(title, quantity)
        track_quantities(quantity)
    end

    def track_items(title, quantity)
        idx=0
        while idx < quantity
            @@items << title
            idx+=1
        end
    end

    def track_prices(price, quantity)
        idx=0
        while idx < quantity
            @@prices << price
            idx+=1
        end
    end

    def track_quantities(quantity)
        @@quantities << quantity
    end

    def items
        @@items
    end

    def apply_discount
        if @discount == 20
            @total -= self.total.to_f * (@discount.to_f/100.0)
            return "After the discount, the total comes to $#{@total.to_i}."
        elsif @discount == 0
            return "There is no discount to apply."
        end
    end

    def void_last_transaction
        if @@items.length == 0
            @total=0.0
            
            return @total
        end

        last_quantity = @@quantities.pop()
        idx=0
        while idx < last_quantity
            @@items.pop()
            item_price=@@prices.pop()
            @total-=item_price
            idx+=1
        end
    end
end

