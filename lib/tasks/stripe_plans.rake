# Run "rake stripe_plans" to populate the Plan Model with our plans from Stripe API
# The " => :environment" tells rake to load the rails environment before running the "stripe_plans" task
task :stripe_plans => :environment do
  Stripe::Plan.list.each do |plan|
    Plan.create stripe_id: plan.id, name: plan.name, amount: plan.amount, interval: plan.interval unless Plan.exists? stripe_id: plan.id
  end
end