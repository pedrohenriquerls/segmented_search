module RedirectMessage
  def redirect(url, action, model_name)
    redirect_to url, notice: I18n.t("activerecord.messages.#{action}_success", model: model_name)
  end
end