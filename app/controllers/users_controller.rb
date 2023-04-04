class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create, :bio_length]
def index
  users = User.all
  render json: users, include: :reviews
end

    def create
        
      user = User.create(user_params)
      if user.valid?
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    
    def show
        user = User.find_by(id: session[:user_id])
        if user
          render json: user, include: :reviews
        else
          render json: { errors: ["Not authorized"] }, status: :unauthorized
        end
      end

      # Create a custom dynamic route that renders all the users that have bios with less than or equal to the number of characters given in the dynamic portion of the URL.  If no bios are found, render the error message "No users who have bios of less than ______ characters in length."

      def bio_length
        number = params[:length].to_i

        users = User.all.filter {|user| user.bio.length <= number }
  
        if users.length < 1
            render json: {errors: "No users who have bios of less than #{number} characters in length."};
        else
            render json: users
        end
      end
    private

   
    def user_params
      params.permit(:username, :password, :password_confirmation, :bio)
    end
end
