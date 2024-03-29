class ContactsController < ApplicationController
  before_filter :secure_with_digest, :only => [:index]
  before_filter :verify_authenticity_token
  def index
    @contacts = Contact.all(order: "created_at DESC")
    @hourly_contacts, @daily_contacts = Contact.statistics
    render :layout => 'contacts'
  end

  def create

    if params[:contact].blank? || params[:contact][:email].blank?
      flash.now[:error] = "Missing contact email!"
      render json: { message: "Missing contact email" }, status: :bad_request and return
    end

    contact_attr = params[:contact]
    if Contact.where(email: contact_attr[:email]).exists?
      flash.now[:notice] = "The email #{contact_attr[:email]} has already subscribed!"
      render json: { message: "You have subscribed!" }, status: :accepted, notice: "You have subscribed!" and return
    end

    contact = Contact.create contact_attr.merge( user_agent: request.user_agent, ip: request.ip )

    if contact.errors.any?
      Rails.logger.error contact.errors.inspect
      message = "An error occurred please try again later."
      flash.now[:error] = contact.errors.full_messages
      render json: { message: message }, error: message, status: :unprocessable_entity
    else
      message = "Thank you for subscribing! You'll be notified at launch date."
      flash.now[:notice] = message
      render json: { message: message }, status: :created
    end
  end
end
