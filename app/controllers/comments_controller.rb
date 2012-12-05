class CommentsController < ApplicationController
  respond_to :html
  
  before_filter :login_required, :only=>['new','create']

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    
    @review = Review.find(params[:review_id])
    @user = current_user
    @comment = @review.comments.build
    @comment.user = @user
    @comment.build_like
    respond_with(@comment)
  end

  def create
    
    @review = Review.find(params[:review_id])
    @user = current_user
    @comment = @review.comments.build(params[:comment])
    @comment.user = @user
    @comment.save
    #send email to remind the user whose review is commented
    
    commenter = @user
    if commenter!=@review.user
      @review.user.delay.comment_remind( commenter)
    end
    redirect_to phone_review_path(@review.phone, @review)
  end

  def destroy
    @comment = Comment.find(:all, :from => "Comments", :conditions => ['id = ? AND review_id = ?', params[:id], params[:review_id]])
    @comment[0].destroy
    flash[:message] = "Comment deleted."
    redirect_to phone_review_path(@phone, @review)
  end


end
