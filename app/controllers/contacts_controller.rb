class ContactsController < ApplicationController
  
  def create
  	@contact = Contact.new(params[:contact])
  	if @contact.save
  		flash[:success] = "Contact saved!"
  	else
  		render 'new'
  	end
  end

end
