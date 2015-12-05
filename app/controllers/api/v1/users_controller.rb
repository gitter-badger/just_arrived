class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :matching_jobs]

  api :GET, '/users', 'List users'
  description 'Returns a list of users.'
  formats ['json']
  def index
    @users = User.all
    render json: @users
  end

  api :GET, '/users/:id', 'Show user'
  description 'Returns user.'
  formats ['json']
  def show
    render json: @user
  end

  api :POST, '/users/', 'Create new user'
  description 'Creates and returns a new user.'
  formats ['json']
  param :user, Hash, desc: 'User attributes', required: true do
    param :skills, Array, of: Integer, desc: 'List of skill ids', required: true
    param :name, String, desc: 'Name', required: true
    param :description, String, desc: 'Description', required: true
    param :email, String, desc: 'Email', required: true
    param :phone, String, desc: 'Phone', required: true
  end
  def create
    @user = User.new(user_params)
    if @user.save
      @user.skills = Skill.where(id: params[:user][:skills])
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  api :PATCH, '/users/', 'Update new user'
  description 'Updates and returns the updated user.'
  formats ['json']
  param :user, Hash, desc: 'User attributes', required: true do
    param :name, String, desc: 'Name'
    param :description, String, desc: 'Description'
    param :email, String, desc: 'Email'
    param :phone, String, desc: 'Phone'
  end
  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/users/:id', 'Delete user'
  description 'Deletes user.'
  formats ['json']
  def destroy
    @user.destroy
    render json: {}
  end

  api :GET, '/users/:id/matching_jobs', 'Show matching jobs for user'
  description 'Returns the matching jobs for user.'
  formats ['json']
  def matching_jobs
    render json: Job.matches_user(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :phone, :description, :address)
    end
end
