class QuestionsController < ApplicationController

  def index
    @questions = Question.all.order('created_at desc')
    render 'questions/index'
  end

  def new
    render 'questions/new', layout: false
  end


  def create
    @question = Question.new(title: params['title'], body: params['body'], user_id: session['user_id'])
    tags = params['tags'].split(' ')
    if @question.save
      tags.each do |tag|
        new_tag = Tag.find_or_create_by(name: tag)
        QuestionTag.find_or_create_by(question_id: @question.id, tag_id: new_tag.id)
      end
      render 'questions/_single', layout: false, locals: {question: @question}
    else
      @errors = @question.errors.full_messages
      render 'questions/new', layout: false
    end
  end

  def show
    @question = Question.find_by(id: params[:id])
    @tag = Tag.find_by(id: params[:id])
    halt(404, erb(:'404')) if @question.nil?
    @comments = @question.comments.limit(3)
    @question.views += 1
    @question.save
    render "questions/show"
  end

  def edit
    @question = Question.find_by(id: params[:id])
    if session["user_id"] == @question.user_id
      render 'questions/edit'
    else
      render '404'
    end
  end


  def update
    @question = Question.find_by(id: params[:id])
    if session["user_id"] == @question.user_id
      @question.assign_attributes(title: params['title'], body: params['body'])
      if @question.save
        if request.xhr?
          render "questions/_edited-question", layout: false, locals: {question: @question}
        else
          redirect "questions/#{@question.id}"
        end
      else
        @errors = @question.errors.full_messages
        render 'questions/edit'
      end
    else
      render '404'
    end
  end

  def destroy
    @question = Question.find_by(id: params[:id])
    if session["user_id"] == @question.user_id
      QuestionTag.where(question_id: @question.id).destroy_all
      @question.destroy
      redirect '/questions'
    else
      render '404'
    end
  end





end
