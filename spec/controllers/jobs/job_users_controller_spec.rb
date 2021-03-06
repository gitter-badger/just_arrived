require 'rails_helper'

RSpec.describe Api::V1::Jobs::JobUsersController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # JobUser. As you add validations to JobUser, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {}
  }

  let(:invalid_attributes) {
    {}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # JobUsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all user users as @users' do
      job = FactoryGirl.create(:job_with_users, users_count: 1)
      user = job.users.first
      get :index, {job_id: job.to_param}, valid_session
      expect(assigns(:users)).to eq([user])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user user as @user' do
      job = FactoryGirl.create(:job_with_users, users_count: 1)
      user = job.users.first
      get :show, {job_id: job.to_param, id: user.to_param}, valid_session
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns the requested user as @user' do
      job = FactoryGirl.create(:job_with_users, users_count: 1)
      user = job.users.first
      get :show, {job_id: job.to_param, id: user.to_param}, valid_session
      expect(assigns(:job)).to eq(job)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new JobUser' do
        user = FactoryGirl.create(:user)
        user1 = FactoryGirl.create(:user)
        job = FactoryGirl.create(:job, owner: user1)
        expect {
          post :create, {job_id: job.to_param, user: {id: user.to_param}}, valid_session
        }.to change(JobUser, :count).by(1)
      end

      it 'assigns a newly created user_user as @job_user' do
        user = FactoryGirl.create(:user)
        user1 = FactoryGirl.create(:user)
        job = FactoryGirl.create(:job, owner: user1)
        post :create, {job_id: job.to_param, user: {id: user.to_param}}, valid_session
        expect(assigns(:job_user)).to be_a(JobUser)
        expect(assigns(:job_user)).to be_persisted
      end

      it 'returns created status' do
        user = FactoryGirl.create(:user)
        user1 = FactoryGirl.create(:user)
        job = FactoryGirl.create(:job, owner: user1)
        post :create, {job_id: job.to_param, user: {id: user.to_param}}, valid_session
        expect(response.status).to eq(201)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved job_user as @job_user' do
        job = FactoryGirl.create(:job)
        post :create, {job_id: job.to_param, user: {}}, valid_session
        expect(assigns(:job_user)).to be_a_new(JobUser)
      end

      it 'returns unprocessable entity status' do
        job = FactoryGirl.create(:job)
        post :create, {job_id: job.to_param, user: {}}, valid_session
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'not allowed' do
      it 'does not destroy the requested job_user' do
        job = FactoryGirl.create(:job_with_users)
        user = job.users.first
        expect {
          delete :destroy, {job_id: job.to_param, id: user.to_param}, valid_session
        }.to change(JobUser, :count).by(0)
      end

      it 'returns not allowed status' do
        job = FactoryGirl.create(:job_with_users)
        user = job.users.first
        delete :destroy, {job_id: job.to_param, id: user.to_param}, valid_session
        expect(response.status).to eq(401)
      end
    end

    # TODO: Mock the user session properly, and make these tests pass
    xcontext 'allowed' do
      it 'destroys the requested job_user' do
        job = FactoryGirl.create(:job_with_users)
        user = job.users.first
        expect {
          delete :destroy, {job_id: job.to_param, id: user.to_param}, valid_session
        }.to change(JobUser, :count).by(-1)
      end

      it 'returns no content status' do
        job = FactoryGirl.create(:job_with_users, users_count: 1)
        user = job.users.first
        delete :destroy, {job_id: job.to_param, id: user.to_param}, valid_session
        expect(response.status).to eq(204)
      end
    end
  end
end
