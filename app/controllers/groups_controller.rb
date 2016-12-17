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

  def edit
    @group =Group.find(params[:id])
  end

  def update
    @group =Group.find(params[:id])
    @group.update(group_parames)

    redirect_to groups_path,notice:"update success"
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:alert] = "Group delete"
    redirect_to groups_path
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
