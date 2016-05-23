module BlueBottle
  module Services
    class SubscriptionService

      attr_accessor :data_store

      def initialize(data_store)
        @data_store = data_store
      end

      def subscribe(customer, coffee)
        subscription = BlueBottle::Models::Subscription.new(
          id=rand(1..99999), 
          customer_id=customer.id, 
          coffee_ids=[coffee.id], 
        )
        self.data_store.add_subscription(subscription)
      end

    end
  end
end
