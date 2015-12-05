class Api::V1::JobSkillsController < ApplicationController
  before_action :set_job_skill, only: [:show, :edit, :update, :destroy]

  api :GET, '/job_skills/:id', 'Show job skills'
  description 'Returns a list of job skills.'
  formats ['json']
  def index
    @job_skills = JobSkill.all
    render json: @job_skills
  end

  api :GET, '/job_skills/:id', 'Show job skill'
  description 'Returns job skill.'
  formats ['json']
  def show
    render json: @job_skill
  end

  api :POST, '/job_skills/', 'Create new job skill'
  description 'Creates and returns a new job skill.'
  formats ['json']
  param :job_skill, Hash, desc: 'Job skill attributes', required: true do
    param :job_id, Integer, desc: 'Job id', required: true
    param :skill_id, Integer, desc: 'Skill id', required: true
  end
  def create
    @job_skill = JobSkill.new(job_skill_params)

    if @job_skill.save
      render json: @job_skill, status: :created
    else
      render json: @job_skill.errors, status: :unprocessable_entity
    end
  end

  api :PATCH, '/job_skills/:id', 'Update job skill'
  description 'Updates and returns the updated job skill.'
  formats ['json']
  param :job_skill, Hash, desc: 'Job skill attributes', required: true do
    param :job_id, Integer, desc: 'Job id'
    param :skill_id, Integer, desc: 'Skill id'
  end
  def update
    if @job_skill.update(job_skill_params)
      render json: @job_skill, status: :ok
    else
      render json: @job_skill.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/job_skills/:id', 'Delete job skill'
  description 'Deletes job skill.'
  formats ['json']
  def destroy
    @job_skill.destroy
    render json: {}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_skill
      @job_skill = JobSkill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_skill_params
      params.require(:job_skill).permit(:job_id, :skill_id)
    end
end