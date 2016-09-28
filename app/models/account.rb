class Account < ActiveRecord::Base

  after_destroy :remove_tenant


  private

  def remove_tenant
    Apartment::Tenant.drop subdomain
  end
end
