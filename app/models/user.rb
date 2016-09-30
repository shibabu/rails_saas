class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable # :async

  with_options on: :create do
    validates_uniqueness_of :email
    validates :subdomain, presence: true, uniqueness: true
    validate :forbidden_subdomain?
    after_validation :create_tenant
  end

  after_create :create_account
  after_create :add_user_role


  private

  # Overwriting devise_mailer to send asynchronous emails, using ActiveJob
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def forbidden_subdomain?
    errors.add :subdomain, "Forbidden Subdomain" if Apartment::Elevators::Subdomain.excluded_subdomains.include? subdomain
  end

  def create_account
    account = Account.new email: email, subdomain: subdomain
    account.save!
  end

  def create_tenant
    # after_validation runs even when validations don't pass
    if self.errors.empty?
      Apartment::Tenant.create subdomain
      Apartment::Tenant.switch! subdomain
    end
  end

  def add_user_role
    if created_by_invite?
      add_role :app_user
    else
      add_role :app_admin
    end
  end

end
