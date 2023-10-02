# frozen_string_literal: true

class TelegramMailer < ApplicationMailer
  def group_message(text)
    HTTParty.post("https://api.telegram.org/bot#{ENV['TELEGRAM']}/sendMessage",
                  headers: {
                    'Content-Type' => 'application/json'
                  },
                  body: {
                    chat_id: ENV['TELEGRAM_GROUP_ID'],
                    text: text
                  }.to_json)
  end

  def notice_time(program)
    @program = program

    HTTParty.post("https://api.telegram.org/bot#{ENV['TELEGRAM']}/sendMessage",
                  headers: {
                    'Content-Type' => 'application/json'
                  },
                  body: {
                    chat_id: program.child.user.telegram_id,
                    parse_mode: 'HTML',
                    text: (render 'notice_time')
                  }.to_json)
  end

  def new_training_program(program)
    @program = program

    HTTParty.post("https://api.telegram.org/bot#{ENV['TELEGRAM']}/sendMessage",
                  headers: {
                    'Content-Type' => 'application/json'
                  },
                  body: {
                    chat_id: program.child.user.telegram_id,
                    parse_mode: 'HTML',
                    text: (render 'new_training_program')
                  }.to_json)
  end

  def repeat_training_program(program)
    @program = program

    HTTParty.post("https://api.telegram.org/bot#{ENV['TELEGRAM']}/sendMessage",
                  headers: {
                    'Content-Type' => 'application/json'
                  },
                  body: {
                    chat_id: program.child.user.telegram_id,
                    parse_mode: 'HTML',
                    text: (render 'repeat_training_program')
                  }.to_json)
  end
end
