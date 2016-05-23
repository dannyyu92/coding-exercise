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

    def paused_subscriptions
      @store[:subscriptions].select { |s| s.paused? }
    end

    def cancelled_subscriptions
      @store[:subscriptions].select { |s| s.cancelled? }
    end 

    def subscriptions_with_status(status=nil)
      case status
      when BlueBottle::Models::Subscription::ACTIVE_STATUS
        active_subscriptions
      when BlueBottle::Models::Subscription::PAUSED_STATUS
        paused_subscriptions
      when BlueBottle::Models::Subscription::CANCELLED_STATUS
        cancelled_subscriptions
      else
        subscriptions
      end
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

    def subscriptions_for_customer(customer, status=nil)
      subscriptions_with_status(status).select { |s| s.customer_id == customer.id }
    end

    def subscriptions_for_coffee(coffee, status=nil)
      subscriptions_with_status(status).select { |s| s.coffee_id == coffee.id }
    end

    def subscriptions_by_customer_for_coffee(customer, coffee, status=nil)
      subscriptions = self.subscriptions_for_customer(customer, status)
      subscriptions.select! { |s| s.coffee_id == coffee.id }
      subscriptions.first
    end

  end
end
