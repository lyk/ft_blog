class MessagesController < ApplicationController
	def index
		@messages = Message.all.order("id desc").limit(5)
		@message = Message.new
	end

	def create
		@message = Message.new(message_params)
		if @message.valid?
			@message.save
			@messages = Message.all.order("id desc").limit(5)
			render json: {success: "Message #{@message.title} saved.", messages: @messages.to_json}
		else
			render json: {error: "Message can't created", errors: @message.errors}
		end
	end

  def update
  end

  def delete
  end

  private

  def message_params
  	params.require(:message).permit(:title, :content)
  end
end
