module Api::V1
  class AppsController < ApiController
    def index
      @apps = App.limit(100)
    end

    def create
      @app = App.create app_params

      if @app.save
        render status: :created
      else
        render status: :unprocessable_entity
      end
    end

    def destroy
      App.find(params[:id]).destroy
      head :no_content
    end

    private

    def app_params
      params.require(:app).permit(:name, :image, :link, :category, :rank)
    end
  end
end