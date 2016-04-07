class AuthorSessionsController < ApplicationController





	def new
	end

	def create 
		if login(params[:email], params[:password])
			redirect_back_or_to(articles_path, notice: 'Logged in succesfully.')
		else
			flash.now.alert = "Login failed."
			render action: :new
		end
	end

	def destroy
		logout
		redirect_to(:authors, notice: 'Logged out!')
	end

	before_filter :zero_authors_or_authenticated, only: [:create, :new]
	def zero_authors_or_authenticated
		unless Author.count == 0 || current_user
			redirect_to root_path
			return false
		end
	end


end
