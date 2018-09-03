class QuestionsController < ApplicationController
  include Vote

  skip_before_action :require_login, only: [:show]

  # GET  '/questions'
  def index
    remember_tag(params[:tag])

    @questions = Question.sort_by(params[:sort_by], params[:sequence])
                         .paginate(page: params[:page])
                         .filter(session[:tag])

  	respond_to do |format|
  		format.html { render 'index', locals: {sort_by: params[:sort_by], sequence: params[:sequence]} }
  	end
  end

  # GET  '/questions/new'
  def new
    @question = Question.new
  end

  # POST  '/questions'
  def create
    @question = current_user.questions.build(question_params)
    redirect_url = new_question_url

    if @question.valid?
      @question.save
      @question.categories.create(tag: params[:tags])
      redirect_url = question_url(@question.id)
    end

    render 'new'
  end

  # GET  '/questions/:id'
  def show
    @question = Question.find_by(id: params[:id])

    respond_to do |format|
      format.html do
        if @question.nil?
          flash[:warning] = "Question you are searching for does not exist."
          redirect_to questions_path
        else
          @answers = @question.answers.order("accepted DESC, votes DESC")
        end
      end
    end
  end

  # GET  '/questions/upvote/:question_id'
  def upvote
  	update_vote(Question, params[:question_id], 1)
  end

  # GET  '/questions/downvote/:question_id'
  def downvote
    update_vote(Question, params[:question_id], -1)
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end

  def remember_tag(tag=nil)
    if tag.present?
      session[:tag] = tag
      
      if tag == "all"
        session[:tag] = nil
      end
    end
  end
end
