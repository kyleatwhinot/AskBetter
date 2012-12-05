class AsksController < ApplicationController

def new
	@ask = Ask.new(params[:ask])
end
end
