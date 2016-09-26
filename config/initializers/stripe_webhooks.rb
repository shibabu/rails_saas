StripeEvent.configure do |events|

  # Subscription-deleted Event
  # => In case an automatic renewal-payment is declined, the subscription will be deleted by Stripe
  events.subscribe 'customer.subscription.deleted' do |event|

    # Print log for the console
    ap customer.subscription.deleted

    # Retrieve the subscription object from the event
    subscription  = event.data.object
    customer_id   = subscription.customer

    # Update Account with the new changes
    account                 = Account.find_by_customer_id customer_id
    account.stripe_plan_id  = nil
    account.active_until    = nil
    account.save!
  end

  # Subscription-updated Event
  # => In case an automatic renewal-payment is processed by Stripe, active_until field will be updated in the Model
  events.subscribe 'customer.subscription.updated' do |event|

    # Print log for the console
    ap customer.subscription.deleted

    # Retrieve the subscription object from the event
    subscription = event.data.object

    # Update Account with the new changes
    account                 = Account.find_by_customer_id customer_id
    account.stripe_plan_id  = subscription.plan.id
    account.active_until    = subscription.current_period_end
    account.save!
  end


  # events.all do |event|
  #   # Handle all event types - logging, etc.
  # end
end