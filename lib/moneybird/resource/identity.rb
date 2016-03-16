module Moneybird::Resource
  class Identity
    include Moneybird::Resource
    extend Moneybird::Resource::ClassMethods

    has_attributes %i(
      id
      description
      price
      tax_rate_id
      ledger_account_id
      created_at
      updated_at
    )

    class Service
      attr_reader :client, :administration_id

      def initialize(client, administration_id)
        @client = client
        @administration_id = administration_id
      end

      def all
        result = client.get("#{administration_id}/identities")

        JSON.parse(result.body).map do |invoice|
          Identity.new(self, invoice)
        end
      end
    end
  end
end

