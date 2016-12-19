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
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
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

  def join
    @group =Group.find(params[:id])

      if !current_user.is_member_of?(@group)
        current_user.join!(@group)
        flash[:notice] = "加入成功"
      else
        flash[:warning] = "你已经是你讨论版成员了"
      end

      redirect_to group_path(@group)
    end


    def quit
      @group = Group.find(params[:id])

      if current_user.is_member_of?(@group)
        current_user.quit!(@group)
        flash[:notice] = "退出成功"
      else
        flash[:warning] = "你不是你讨论版成员，怎么退出 XD"
      end

      redirect_to group_path(@group)
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
