class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end
  
  def show
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_parames)
    @group.save

      redirect_to groups_path
  end

  private

  def group_parames
    params.require(:group).permit(:title,:description)
  end



end
