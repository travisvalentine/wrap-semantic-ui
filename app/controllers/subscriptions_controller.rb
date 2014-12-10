class SubscriptionsController < ApplicationController
  # This allows the PayPal callback to fire as expected
  skip_before_action :verify_authenticity_token

  def create
    theme = Theme.find_by_id(params[:id])

    amount = params[:price].to_i * 100

    user = current_user || User.find_by_id(params[:user_id])

    if user
      subscription = user.subscriptions.create!(
        theme_id: params[:id],
        price_tier: params[:price]
      )
      theme.sales_tracker.increment!(params[:count].to_sym) if params[:paypal]
      notice = "Thanks for purchasing #{theme.name}"
    else
      notice = "We couldn't process that. Please email help."
    end

    redirect_to theme_path(theme), notice: notice
  end
end
