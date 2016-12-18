class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new,:create,:edit,:update,:destory]
  before_action :find_group_and_check_permission,only: [:edit,:update,:destory]
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @post = @group.posts
  end

  def edit
  end

  def update
    if @group.update(group_parames)
      redirect_to groups_path,notice:"update success"
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    flash[:alert] = "Group delete"
    redirect_to groups_path
  end


  def create
    @group = Group.new(group_parames)
    @group.user =current_user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  private

  def find_group_and_check_permission
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def group_parames
    params.require(:group).permit(:title,:description)
  end
end
