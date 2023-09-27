class TelegramMailer < ApplicationMailer
  def group_message(text)
    HTTParty.post("https://api.telegram.org/bot#{ENV['TELEGRAM']}/sendMessage",
      headers: {
        'Content-Type' => 'application/json'
      },
      body: {
        chat_id: ENV['TELEGRAM_GROUP_ID'],
        text: text
      }.to_json
    )
  end

  def private_message(text, user) 
    HTTParty.post("https://api.telegram.org/bot#{ENV['TELEGRAM']}/sendMessage",
      headers: {
        'Content-Type' => 'application/json'
      },
      body: {
        chat_id: user.telegram_id,
        text: text
      }.to_json
    )
  end
end
