class ContactsController < ApplicationController
	def create
    if params[:contact].blank? || params[:contact][:email].blank?
      flash.now[:error] = "Missing contact email!"
      render json: { message: "Missing contact email" }, status: :bad_request, error: "Missing contact email" and return
    end

    contact_attr = params[:contact]
    if Contact.where(email: contact_attr[:email]).exists?
      flash.now[:error] = "You have subscribed!"
      render json: { message: "You have subscribed!" }, status: :accepted, notice: "You have subscribed!" and return
    end


    contact = Contact.create contact_attr.merge( user_agent: request.user_agent, ip: request.ip )
    if contact.errors.any?
      Rails.logger.error contact.errors.inspect
      message = "An error occurred please try again later."
      flash.now[:error] = message
      render json: { message: message }, error: message, status: :unprocessable_entity
    else
      message = "Thank you for subscribing!"
      flash.now[:error] = message
      render json: { message: message }, status: :created
    end
	end

end
