# frozen_string_literal: true

class TelegramController < ApplicationController
  def telegram_auth
    current_user.update(telegram_id: params[:id]) if params[:id].present?

    redirect_back_or_to root_path, notice: 'Telegram уведомления успешно поключены!'
  end

  def telegram_destroy
    current_user.update(telegram_id: nil) if current_user.telegram_id.present?

    redirect_back_or_to root_path, notice: 'Telegram уведомления успешно отключены!'
  end
end
