class SubscriptionsController < ApplicationController

  before_action :authenticate_user!

  def index
    @account = Account.find_by_email current_user.email
  end

  def new
  end

  def create
    # Get the credit card token submitted by the form
    token             = params[:stripeToken]
    # Get the subscription plan submitted by the form
    stripe_plan_id    = params[:plan][:stripe_id]

    current_account   = Account.find_by_email current_user.email
    customer_id       = current_account.customer_id
    # Get current Stripe Plan
    current_plan      = current_account.stripe_plan_id

    if customer_id.nil?
      # Create new Stripe customer
      @customer = Stripe::Customer.create(
          source: token,
          plan: stripe_plan_id,
          email: current_user.email
      )

      subscriptions = @customer.subscriptions
      @subscribed_plan = subscriptions.data.find {|o| o.plan.id == stripe_plan_id}
    else
      # Retrieve customer object from Stripe
      @customer = Stripe::Customer.retrieve customer_id

      # Create or Update Subscription
      @subscribed_plan = create_or_update_subscription @customer, current_plan, stripe_plan_id
    end


    # Convert the subscription's period end-date from UNIX timestamp to datetime
    active_until       = Time.at(@subscribed_plan.current_period_end).to_datetime

    # Update current_user's Account with the subscription plan
    update_current_user_account current_user, stripe_plan_id, @customer.id, active_until

    redirect_to :root, notice: "Successfully subscribed to #{Plan.find_by(stripe_id: stripe_plan_id).name}!"

  rescue => e
    redirect_to :back, flash: {alert: e.message}
  end

  def edit
    @account = Account.find params[:id]
  end


  # CANCEL SUBSCRIPTION
  def cancel
    # Fetch Customer from Stripe
    current_account = Account.find_by_email(current_user.email)
    customer_id = current_account.customer_id
    customer = Stripe::Customer.retrieve customer_id

    # Get Customer's subscriptions
    subscriptions = customer.subscriptions

    # Find the Subscription in question
    subscription = subscriptions.data.find {|o| o.plan.id == current_account.stripe_plan_id}
    if subscription.blank?
      raise 'Susbcription not found!'
    end


    # Cancel it
    subscription.delete

    # Update Account Model
    current_account.stripe_plan_id  = nil
    current_account.active_until    = nil
    current_account.save!

    @message = "Subscription successfully canceled!"

  rescue => e
    redirect_to '/subscriptions', flash: {alert: e.message}
  end


  # <!------- Update Credit Card -------!>
  def update_credit_card

  end

  # Update Stripe Customer Object with the new Token
  def update_credit_card_post
    # get the StripeToken from the Update Credit Card form
    token             = params[:stripeToken]

    # Get Stripe Customer ID
    customer_id = Account.find_by_email(current_user.email).customer_id

    # Get Stripe Customer Object using customer_id
    cx = Stripe::Customer.retrieve customer_id

    # Set the Payment Source with the new Token and update Customer Object
    cx.source = token
    cx.save

    redirect_to '/subscriptions', flash: {notice: 'Credit Card successfully updated!'}
  end



  private

  def create_or_update_subscription customer, current_plan, new_plan
    current_subscription = customer.subscriptions.data.find {|o| o.plan.id == current_plan}

    if current_subscription.blank?
      # No current subscription
      # Create subscription
      subscription = customer.subscriptions.create plan: new_plan
    else
      # Update existing subscription
      current_subscription.plan == new_plan
      subscription = current_subscription.save
    end

    return subscription
  end

  def update_current_user_account current_user, stripe_plan_id, customer_id, active_until
    account                 = Account.find_by_email current_user.email
    account.stripe_plan_id  = stripe_plan_id
    account.customer_id     = customer_id
    account.active_until    = active_until
    account.save!
  end

end
