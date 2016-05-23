module BlueBottle
  class DataStore

    def initialize
      @store = {
        customers: [],
        coffees: [],
        subscriptions: [], 
      }
    end

    def customers
       @store[:customers]
    end

    def subscriptions
      @store[:subscriptions]
    end

    def active_subscriptions
      @store[:subscriptions].select { |s| s.active? }
    end

    def add_coffee(coffee)
      @store[:coffees] << coffee
    end

    def add_customer(customer)
      @store[:customers] << customer
    end

    def add_subscription(subscription)
      @store[:subscriptions] << subscription
    end

    def active_subscriptions_for_customer(customer)
      active_subscriptions.select { |s| s.customer_id == customer.id }
    end

  end
end
