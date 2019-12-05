class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.new(review_params)

    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Review not created - Please complete required fields"
      render :new
    end
  end

  def edit
    @shelter = params[:shelter_id]
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])
    @review.update(review_params)

    if @review.save
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:notice] = "Please enter a Title, Rating, and Content"
      @shelter = params[:shelter_id]
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:review_id])
    review.destroy

    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private
    def review_params
      params.permit(:title, :rating, :content, :opt_pic)
    end
end
