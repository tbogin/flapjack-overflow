class VotesController < ApplicationController

  def create_question_upvote
    question = Question.find_by(id: params[:id])
    question.votes.create(user_id: session['user_id'])
    redirect "/questions/#{question.id}"
  end

  def create_question_downvote
    question = Question.find_by(id: params[:id])
    vote = question.votes.find_by(user_id: session[:user_id])
    vote.destroy if vote
    redirect "/questions/#{question.id}"
  end

  def create_answer_upvote
    answer = Answer.find_by(id: params[:id])
    answer.votes.create(user_id: session['user_id'])
    redirect "/question/#{question.id}"
  end

  def create_answer_downvote
    answer = Answer.find_by(id: params[:id])
    vote answer.votes.find_by(user_id: session[:user_id])
    vote.destroy if vote
    redirect "/questions/#{question.id}"
  end
  
end
