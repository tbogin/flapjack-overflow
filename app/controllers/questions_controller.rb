class QuestionsController < ApplicationController

  def index
    @qs = Question.all.order('created_at desc')
    render 'questions/index'
  end

  def new
    render 'questions/new', layout: false
  end


  def create
    @q = Question.new(title: params['title'], body: params['body'], user_id: session['user_id'])
    tags = params['tags'].split(' ')
    if @q.save
      tags.each do |tag|
        new_tag = Tag.find_or_create_by(name: tag)
        QuestionTag.find_or_create_by(question_id: @q.id, tag_id: new_tag.id)
      end
      render 'questions/_single', layout: false, locals: {q: @q}
    else
      @errors = @q.errors.full_messages
      render 'questions/new', layout: false
    end
  end

  def show
    @q = Question.find_by(id: params[:id])
    @tag = Tag.find_by(id: params[:id])
    halt(404, erb(:'404')) if @q.nil?
    @comments = @q.comments.limit(3)
    @q.views += 1
    @q.save
    render "questions/show"
  end

  def edit
    @q = Question.find_by(id: params[:id])
    if session["user_id"] == @q.user_id
      render 'questions/edit'
    else
      render '404'
    end
  end


  def update
    @q = Question.find_by(id: params[:id])
    if session["user_id"] == @q.user_id
      @q.assign_attributes(title: params['title'], body: params['body'])
      if @q.save
        if request.xhr?
          render "questions/_edited-question", layout: false, locals: {q: @q}
        else
          redirect "questions/#{@q.id}"
        end
      else
        @errors = @q.errors.full_messages
        render 'questions/edit'
      end
    else
      render '404'
    end
  end

  def destroy
    @q = Question.find_by(id: params[:id])
    if session["user_id"] == @q.user_id
      QuestionTag.where(question_id: @q.id).destroy_all
      @q.destroy
      redirect '/questions'
    else
      render '404'
    end
  end





end
