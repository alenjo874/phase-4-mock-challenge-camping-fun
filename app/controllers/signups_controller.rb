class SignupsController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid

    def create 
        create_signup = Signup.create!(signup_params)
        activity = create_signup.activity
        render json: activity, status: :accepted
    end

    private 

    def signup_params
        params.permit(:time, :camper_id, :activity_id)
    end

    def handle_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end



end
