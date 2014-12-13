class SubscriptionsController < ApplicationController
  # This allows the PayPal callback to fire as expected
  skip_before_action :verify_authenticity_token

  def create
    theme      = Theme.find_by_id(params[:id])
    amount     = params[:price].to_i * 100
    user       = current_user || User.find_by_id(params[:user_id])
    logged_out = params[:logged_out] && params[:logged_out] == "true"

    # if there is a user and they didn't purchase the theme,
    # create subscription and increment
    #
    # if the user is logged out and there isn't a GuestSubscription
    # create GuestSubscription and increment
    if user && user.can_purchase?(theme)
      user.purchase_and_notify!(theme, params)

      notice = "Thanks for purchasing #{theme.name}"
      path   = theme_path(theme)
    elsif logged_out && !GuestSubscription.already_exists?(params)
      GuestSubscription.create_and_notify(theme, params)

      notice = "Thanks for purchasing #{theme.name}"
      path   = theme.file_package.url
    else
      notice = "We couldn't process that. Please email help."
      path   = theme_path(theme)
    end

    redirect_to path, notice: notice
  end
end
