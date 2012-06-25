module FeatureBox
  class CommentsController < FeatureBox::ApplicationController

    load_and_authorize_resource


    def create
      suggestion =Suggestion.find(params["suggestion_id"])
      @comment.text = params["comment"]["text"]
      @comment.user = current_user
      @comment.suggestion = suggestion
        if @comment.save
          redirect_to suggestion, notice: 'Comment was successfully added.'       
        else
          redirect_to suggestion, :flash => { 
            #TODO: it can be anything, not only empty comment
            :error => 'Comment cannot be empty'
          }
        end
    end

    def edit
    end

    def show
      redirect_to @comment.suggestion
    end

    def update
      @comment.text = params[:comment][:text]
      if @comment.save
        redirect_to @comment.suggestion, notice: 'Comment was successfully updated.' 
      else
        render action: "edit" 
      end
    end

    def destroy
      @comment.destroy
      redirect_to @comment.suggestion, notice: 'Comment was successfully deleted.'     
    end


  end
end

