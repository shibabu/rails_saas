class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validate :email_is_unique, on: :create
  after_create :create_account

  private

  def create_account
    account = Account.new email: email
    account.save!
  end

  # Make sure the email is a unique ID
  # def email_is_unique
  #   unless Account.find_by_email(email).nil?
  #     errors.add :email, ' is already used!'
  #   end
  # end

end
