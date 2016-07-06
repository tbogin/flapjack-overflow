class CommentsController < ApplicationController

  def new_question_comment 
    @question = Question.find_by(id: params[:id])
    erb :'comments/question-comments'
  end


  def create_question_comment
    @question = Question.find_by(id: params[:id])
    @comment = @question.comments.new(body: params[:body], user_id: session["user_id"])
    if @question.save
      redirect "/questions/#{@question.id}"
    else
      @errors = @comment.errors.full_messages
      erb :'comments/question-comments'
    end
  end

  def new_answer_comment 
    @answer = Answer.find_by(id: params[:id])
    erb :'comments/answer-comments'
  end

  def create_answer_comment
    @answer = Answer.find_by(id: params[:id])
    @question = @answer.question
    @comment = @answer.comments.new(body: params[:body], user_id: session["user_id"])
    if @answer.save
      redirect "/questions/#{@question.id}"
    else
      @errors = @comment.errors.full_messages
      erb :'comments/question-comments'
    end
  end

end
