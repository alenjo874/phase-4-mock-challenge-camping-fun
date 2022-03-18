class CampersController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid

    def index 
        campers = Camper.all
        render json: campers
    end

    def show
        show_camper = Camper.find_by!(id:params[:id])
        render json: show_camper, serializer: CamperActivitySerializer
    end

    def create 
        create_camper = Camper.create!(camper_params)
        render json: create_camper, status: :created
    end




private 

def handle_not_found
  render json: {error: "Camper not found"}, status: :not_found
end  

def handle_invalid(invalid)
render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
end

def camper_params
    params.permit(:name, :age)
end    

end
