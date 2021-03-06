require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    lang_id = FactoryGirl.create(:language).id
    {
      skill_ids: [FactoryGirl.create(:skill).id],
      email: 'someone@example.com',
      name: 'Some user name',
      phone: '123456789',
      description: 'Some user description',
      language_id: lang_id,
      language_ids: [lang_id],
      address: 'Stora Nygatan 36, Malmö'
    }
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all users as @users' do
      user = User.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:users)).to eq([user])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user as @user' do
      user = User.create! valid_attributes
      get :show, {user_id: user.to_param}, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect {
          post :create, {user: valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, {user: valid_attributes}, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it 'returns created status' do
        post :create, {user: valid_attributes}, valid_session
        expect(response.status).to eq(201)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user as @user' do
        post :create, {user: invalid_attributes}, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it 'returns unprocessable entity status' do
        post :create, {user: invalid_attributes}, valid_session
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { phone: '987654321' }
      }

      it 'updates the requested user' do
        user = User.create! valid_attributes
        put :update, {user_id: user.to_param, user: new_attributes}, valid_session
        user.reload
        expect(user.phone).to eq('987654321')
      end

      it 'assigns the requested user as @user' do
        user = User.create! valid_attributes
        put :update, {user_id: user.to_param, user: valid_attributes}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it 'returns success status' do
        user = User.create! valid_attributes
        put :update, {user_id: user.to_param, user: valid_attributes}, valid_session
        expect(response.status).to eq(200)
      end
    end

    context 'with invalid params' do
      it 'assigns the user as @user' do
        user = User.create! valid_attributes
        put :update, {user_id: user.to_param, user: invalid_attributes}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it 'returns unprocessable entity status' do
        user = User.create! valid_attributes
        put :update, {user_id: user.to_param, user: invalid_attributes}, valid_session
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'does not destroy the requested user' do
      user = User.create! valid_attributes
      delete :destroy, {user_id: user.to_param}, valid_session
      user.reload
      expect(user.name).to eq('Ghost')
    end

    it 'returns 200 status' do
      user = User.create! valid_attributes
      delete :destroy, {user_id: user.to_param}, valid_session
      expect(response.status).to eq(204)
    end
  end
end
