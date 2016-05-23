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
          coffee_id=coffee.id, 
        )
        self.data_store.add_subscription(subscription)
      end

      def pause_subscription(customer, coffee)
        subscriptions = self.data_store.subscriptions_by_customer_for_coffee(
          customer, 
          coffee, 
        )
        active_subscription = subscriptions.find { |s| s.active? }
        if active_subscription
          active_subscription.pause
        else
          raise "Customer '#{customer.full_name}'' does not have an "\
            "active subscription to cofee '#{coffee.name}'"
        end
      end

      def cancel_subscription(customer, coffee)
        subscriptions = self.data_store.subscriptions_by_customer_for_coffee(
          customer, 
          coffee,
        )
        subscription = subscriptions.find { |s| s.active? || s.paused? }
        if subscription
          if subscription.active?
            subscription.cancel
          elsif subscription.paused?
            raise "Cannot cancel a paused subscription"
          end
        else
          raise "Customer '#{customer.full_name}'' does not have an active or paused "\
            "subscription to coffee '#{coffee.name}'"
        end
      end

    end
  end
end
