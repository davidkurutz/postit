class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Your category has been created"
      redirect_to root_path
    else
      flash.now[:alert] = "testing flash alert"
      render :new
    end
  end

  def show
    @category = Category.find_by(slug: params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end