module FeatureBox
  class SuggestionsController < FeatureBox::ApplicationController
    load_and_authorize_resource :except => [:my_suggestions, :my_comments, :my_votes, :search, :create, :vote]

    def index
      authorize! :read, Suggestion

      redirect = get_and_validate_params
      if redirect != false
        return redirect
      end

      pages_helper do |limit, offset|
        @suggestions, @total = Suggestion.find_those_with(
          :category =>@active_category, 
          :order_type =>@active_order_type, 
          :limit => limit, 
          :offset => offset  
          )
      end

      @show_search=true
      @show_nav_bar=true
    end

    def search
      authorize! :read, Suggestion
      q="%"+params[:q].to_s+"%"
      limit=Settings.max_suggestions_on_page;
      @suggestions = Suggestion.where("title LIKE ? OR description LIKE ?",q,q).order("created_at DESC").limit(limit)
      @show_search=true
      render action: "index" 
    end
    
    def my_suggestions
      impact_helper :suggestions
    end

    def my_votes
      impact_helper :votes
    end

    def my_comments
      impact_helper :comments
    end
    

    def vote #json method
      @suggestion = Suggestion.find(params[:id])
      authorize! :create, Vote
      if !user_signed_in?
        {
          :error=>"Sign in to vote"
        }
      elsif can?(:read, @suggestion)
        @suggestion.vote current_user
        votes=@suggestion.user_votes current_user
        render :json => {
          :total_votes=>@suggestion.votes.size,
          :user_votes=>votes,
          :votes_left=>current_user.votes_left
        }
      else
        render :json => {
          :error=>"You are not allowed to vote"
        }
      end
       
    end

    def show
      @active_category = @suggestion.category
      pages_helper do |limit, offset|
        @comments = @suggestion.comments.order("created_at DESC").limit(limit).offset(offset)
        @total = @suggestion.comments.order("created_at DESC").size
      end 
    end

    def new
      if current_user.votes_left<=0 then 
        return redirect_to suggestions_listing_path, :flash => { 
          :error => 'You need at least one vote to add suggestions'
        }
      end
    end

    def edit
    end

    def create
      @suggestion = Suggestion.new
      authorize! :create, @suggestion
      if current_user.votes_left<=0 then 
        return redirect_to suggestions_listing_path, :flash => { 
          :error => 'You need at least one vote to add suggestions'
        }
      end
      @suggestion.title = params[:suggestion][:title]
      @suggestion.description = params[:suggestion][:description]
      @suggestion.category_id = params[:suggestion][:category_id]
      if current_user.admin?
        @suggestion.status = params[:suggestion][:status]
      end
      @suggestion.user = current_user
        if @suggestion.save
          redirect_to @suggestion, notice: 'Suggestion was successfully created.' 
        else
          render action: "new" 
        end
    end

    def update
      @suggestion.title = params[:suggestion][:title]
      @suggestion.description = params[:suggestion][:description]
      @suggestion.category_id = params[:suggestion][:category_id]
      if current_user.admin?
        @suggestion.status = params[:suggestion][:status]
      end
      if @suggestion.save
        redirect_to @suggestion, notice: 'Suggestion was successfully updated.' 
      else
        render action: "edit" 
      end
    end

    def destroy
      @suggestion.destroy
      redirect_to suggestions_listing_url, notice: 'Suggestion was successfully deleted.'     
    end

    private  #helper methods  

    # helper for my_votes, my_suggestions, my_comments
    def impact_helper type_of_impact
      authorize! :read_protected, Suggestion    

      pages_helper do |limit, offset|
        @suggestions, @total = Suggestion.find_my type_of_impact, :user => @current_user, :limit => limit, :offset => offset
      end

      @show_nav_bar=true
      render action: "index" 
    end

    def get_and_validate_params

      @active_category = Category.find_by_name(params[:category]) || if Category.default.name == params[:category] then Category.default end
      @active_order_type = ["newest","most_popular","in_progress","complete"].include?(params[:order])?(params[:order].to_sym):(nil)

      if(@active_category == nil && @active_order_type == nil)
        return redirect_to suggestions_listing_path(:category=>Category.default.name, :order=>:newest), :flash => flash
      elsif(@active_category == nil)
        return redirect_to suggestions_listing_path(:category=>Category.default.name), :flash => flash
      elsif(@active_order_type == nil)
        return redirect_to suggestions_listing_path(:order=>:newest), :flash => flash
      end

      return false
    end
  end
end