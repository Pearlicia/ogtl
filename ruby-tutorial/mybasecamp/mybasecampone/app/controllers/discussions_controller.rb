class DiscussionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_project
  
    def create
      @discussion = @project.discussions.create(discussion_params)
      @discussion.user = current_user
  
      if @discussion.save
        redirect_to project_path(@project), notice: 'Discussion has been created'
      else
        redirect_to project_path(@project), alert: 'Discussion has not been created'
      end
    end
  
    def destroy
      @discussion = @project.discussions.find(params[:id])
      @discussion.destroy
      redirect_to project_path(@project)
    end
  
    def update
      @discussion = @project.discussions.find(params[:id])
  
      respond_to do |format|
        if @discussion.update(discussion_params)
          format.html { redirect_to project_url(@project), notice: 'Discussion has been updated' }
        else
          format.html { redirect_to project_url(@project), alert: 'Discussion was not updated!' }
        end
      end
    end
  
    private
  
    def set_project
      @project = Project.find(params[:project_id])
    end
  
    def discussion_params
      params.require(:discussion).permit(:body, :image, pictures: [])
    end
end



