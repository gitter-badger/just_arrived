class Skill < ActiveRecord::Base
  belongs_to :language

  has_many :job_skills
  has_many :jobs, through: :job_skills

  has_many :user_skills
  has_many :users, through: :user_skills

  validates :name, length: { minimum: 3 }, allow_blank: false
  validates_uniqueness_of :name
  validates_presence_of :language
end

# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  language_id :integer
#
# Indexes
#
#  index_skills_on_language_id  (language_id)
#
