require 'active_support/all'

module BlueBottle
  module Models
    class Subscription
      attr_accessor :id,
                    :status,
                    :customer_id,
                    :coffee_id

      ACTIVE_STATUS = 'active'
      PAUSED_STATUS = 'paused'
      VALID_STATUSES = [ACTIVE_STATUS, PAUSED_STATUS]

      # Predicate methods for each status
      VALID_STATUSES.each do |status|
        define_method "#{status}?" do 
          self.status == status
        end
      end

      def initialize(id, customer_id, coffee_id, status=ACTIVE_STATUS)
        @id = id
        @customer_id = customer_id
        @coffee_id = coffee_id
        @status = status
        validate_status
      end

      def pause
        self.status = PAUSED_STATUS
      end

      private

      def validate_status
        unless VALID_STATUSES.include?(self.status)
          raise "'#{status}' is not a valid subscription status. "\
            "Valid statuses are #{VALID_STATUSES.join(', ')}."
        end
      end

    end
  end
end
