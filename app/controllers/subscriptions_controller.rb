class SubscriptionsController < ApplicationController
  def new

  end

  def create
    puts 'Params hash of Create action in Subscriptions controller:'
    ap params
  end
end
