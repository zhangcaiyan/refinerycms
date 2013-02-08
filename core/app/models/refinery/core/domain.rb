require 'active_record'

module Refinery
  module Core
    class Domain < ActiveRecord::Base

      has_many :users, class_name: "Refinery::User", foreign_key: :domain_id

      def user
        role = ::Refinery::Role.find_by_title_and_domain_id("Superuser", id)
        role.users.first
      end

    end
  end
end
