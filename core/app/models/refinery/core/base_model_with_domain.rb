require 'active_record'

module Refinery
  module Core
    class BaseModelWithDomain < BaseModel
      cattr_accessor :domain_id



      before_create :append_domain_id

      belongs_to :domain,
                 :class_name => '::Refinery::Core::Domain'

      attr_accessible :domain


      self.abstract_class = true

      def domain_id
        read_attribute :domain_id
      end

      private
      def append_domain_id

        self.domain = Domain.find(@@domain_id) if @@domain_id.present?
      end
    end
  end
end

