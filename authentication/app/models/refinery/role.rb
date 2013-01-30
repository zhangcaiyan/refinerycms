module Refinery
  class Role < Refinery::Core::BaseModelWithDomain

    default_scope lambda{where(:domain_id=>@@domain_id) if @@domain_id}

    has_and_belongs_to_many :users, :join_table => :refinery_roles_users

    before_validation :camelize_title
    validates :title,:uniqueness => {:scope => :domain_id}

    def camelize_title(role_title = self.title)
      self.title = role_title.to_s.camelize
    end

    def self.[](title)
      find_or_create_by_title(title.to_s.camelize)
    end

  end
end
