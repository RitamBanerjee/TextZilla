require 'uri'
require "net/http"

class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    return if invalid_number?(params[:to_number]) #invalid phone number

    message = Message.create!(message: params[:message])
    callback_url = ENV['ngrok_address'] + '/messages/' + message.id.to_s + '/number=' + params[:to_number]
    options = {
      to_number: params[:to_number],
      message: params[:message],
      callback_url: callback_url
    }

    provider = Texts::ProvidersService.provider

    uri = URI.parse(provider)
    response = Net::HTTP.post(uri, options.to_json, 'Content-Type' => 'application/json')

    if (response.kind_of? Net::HTTPServerError)
      uri = URI.parse(Texts::ProvidersService.fail_over_provider(provider))
      Net::HTTP.post(uri, options.to_json, 'Content-Type' => 'application/json')
    end

  end

  def update
    Message.find(params[:id]).update(status: params[:status], message_id: params[:message_id])

    if params[:status] == 'invalid'
      PhoneNumber.where(number: params[:number]).first.update(invalid: true)
    end
  end

  def invalid_number?(number) #todo move this to service, only CRUD should be in controller
    number_to_validate = PhoneNumber.find_or_create_by!(number: number)

    return number_to_validate.not_valid
  end
end
#todo add strong params
