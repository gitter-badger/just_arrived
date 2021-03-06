class Api::V1::SkillsController < Api::V1::BaseController
  before_action :set_skill, only: [:show, :edit, :update, :destroy]

  resource_description do
    short 'API for managing skills'
    name 'Skills'
    description ''
    formats [:json]
    api_versions '1.0'
  end

  api :GET, '/skills', 'List skills'
  description 'Returns a list of skills.'
  formats ['json']
  def index
    page_index = params[:page].to_i
    @skills = Skill.all.page(page_index)
    render json: @skills
  end

  api :GET, '/skills/:id', 'Show skill'
  description 'Returns skill.'
  formats ['json']
  example Doxxer.example_for(Skill)
  def show
    render json: @skill, include: ['language']
  end

  api :POST, '/skills/', 'Create new skill'
  description 'Creates and returns the new skill if the user is allowed to.'
  formats ['json']
  param :skill, Hash, desc: 'Skill attributes', required: true do
    param :name, String, desc: 'Name', required: true
    param :language_id, Integer, desc: 'Langauge id of the text content', required: true
  end
  example Doxxer.example_for(Skill)
  def create
    unless current_user.admin?
      render json: { error: 'Not authed.' }, status: 401
      return
    end

    @skill = Skill.new(skill_params)

    if @skill.save
      render json: @skill, status: :created
    else
      render json: @skill.errors, status: :unprocessable_entity
    end
  end

  api :PATCH, '/skills/:id', 'Update skill'
  description 'Updates and returns the updated skill.'
  formats ['json']
  param :skill, Hash, desc: 'Skill attributes', required: true do
    param :name, String, desc: 'Name'
    param :language_id, Integer, desc: 'Langauge id of the text content'
  end
  example Doxxer.example_for(Skill)
  def update
    unless current_user.admin?
      render json: { error: 'Not authed.' }, status: 401
      return
    end

    if @skill.update(skill_params)
      render json: @skill, status: :ok
    else
      render json: @skill.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/skills/:id', 'Delete skill'
  description 'Deletes skill.'
  formats ['json']
  def destroy
    unless current_user.admin?
      render json: { error: 'Not authed.' }, status: 401
      return
    end

    @skill.destroy
    head :no_content
  end

  private

    def set_skill
      @skill = Skill.find(params[:id])
    end

    def skill_params
      params.require(:skill).permit(:name, :language_id)
    end
end
