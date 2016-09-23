class SubscriptionsController < ApplicationController

  before_action :authenticate_user!

  def new

  end

  def create
    # Get the credit card details submitted by the form
    token = params[:stripeToken]
    stripe_plan_id = params[:plan][:stripe_id]

    # Create a Customer
    customer = Stripe::Customer.create(
        source: token,
        plan: stripe_plan_id,
        email: current_user.email
    )

    # Find an Object "o" (a subscription) in customer.subscriptions.data such that o.plan.id is equal to stripe_plan_id
    # Retrieves the UNIX timestamp of the end of subscription in question (strip_plan_id)
    current_period_end = customer.subscriptions.data.find {|o| o.plan.id == stripe_plan_id}.current_period_end
    active_until = Time.at(current_period_end).to_datetime

    # Update current_user's Account with the subscription plan id
    account = Account.find_by_email current_user.email
    account.stripe_plan_id = stripe_plan_id
    account.customer_id = customer.id
    account.active_until = active_until
    account.save!

    redirect_to :root, notice: "Successfully subscribed to #{Plan.find_by(stripe_id: stripe_plan_id).name}!"

  rescue => e
    redirect_to :new_subscription, flash: {alert: e.message}

  end

end
