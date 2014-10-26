STRIPE_PUBLISHABLE_KEY = APP_CONFIG["stripe"]["publishable_key"] || ENV["stripe_publishable_key"]
STRIPE_SECRET_KEY = APP_CONFIG["stripe"]["secret_key"] || ENV["stripe_secret_key"]

Rails.configuration.stripe = {
  :publishable_key => STRIPE_PUBLISHABLE_KEY,
  :secret_key      => STRIPE_SECRET_KEY
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]