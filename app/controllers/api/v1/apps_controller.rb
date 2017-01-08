module Api::V1
  class AppsController < ApiController
    PER_PAGE = 20.freeze

    def index
      @apps = App.order(created_at: :desc)
      @apps = paginate @apps, per_page: PER_PAGE
      render status: :partial_content
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