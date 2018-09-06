class QuestionsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:show]
  load_resource :question, only: [:new, :show, :index]
  load_resource :question, through: :current_user, only: [:create]

  # GET  '/questions'
  def index
    @questions = @questions.filter(params[:tag])
                           .sort_by_column(params[:sort_by], params[:sequence])
                           .paginate(page: params[:page])

  	respond_to do |format|
  		format.html 
  	end
  end

  # GET  '/questions/new'
  def new
    respond_to do |format|
      format.html 
    end
  end

  # POST  '/questions'
  def create
    respond_to do |format|
      if @question.valid? && @question.save_with_categories(params[:category_ids])
        flash[:success] = "Your question is recorded and is now active on site."
        format.html { redirect_to @question }
      else
        flash[:warning] = "There are a few errors, please fix them to start receiving answers to your question."
        format.html { render 'new' }
      end 
    end
  end

  # GET  '/questions/:id'
  def show
    @answers = @question.answers
                        .joins("LEFT OUTER JOIN votes on answers.id = votes.voteable_id AND votes.voteable_type = 'Answer'")
                        .group("answers.id")
                        .order("accepted DESC, count(votes.id) DESC")
    
    respond_to do |format|
      format.html
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
