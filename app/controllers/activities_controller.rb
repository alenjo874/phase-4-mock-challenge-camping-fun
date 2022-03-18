class ActivitiesController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid
    def index
        activities = Activity.all
        render json: activities
    end

    def destroy
        destroy_activity = Activity.find_by!(id:params[:id])
        destroy_activity.signups.destroy_all
        destroy_activity.destroy
    end

    private 

    def handle_not_found
        render json: {error: "Activity not found"}, status: :not_found
    end  

end
