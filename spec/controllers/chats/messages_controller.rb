require 'rails_helper'

RSpec.describe Api::V1::ChatsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Chat. As you add validations to Chat, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    first = FactoryGirl.create(:user)
    second = FactoryGirl.create(:user)
    { user_ids: [first, second] }
  }

  let(:invalid_attributes) {
    { user_ids: [] }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ChatsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #messages' do
    context 'with valid params' do
      let(:valid_attributes) do
        chat_user = FactoryGirl.create(:chat_user)
        chat = chat_user.chat
        user = chat_user.user
        FactoryGirl.create(:message, chat: chat, author: user)
        { id: chat.to_param }
      end

      it 'assigns all messages as @messages' do
        get :messages, valid_attributes, valid_session
        expect(assigns(:messages).first).to be_a(Message)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        language = FactoryGirl.create(:language)
        chat_user = FactoryGirl.create(:chat_user)
        chat = chat_user.chat
        {
          id: chat.to_param,
          message: { body: 'Some test text.', language_id: language }
        }
      end

      it 'creates a new Message' do
        expect {
          post :create, valid_attributes, valid_session
        }.to change(Message, :count).by(1)
      end

      it 'assigns chat as @chat' do
        post :create, valid_attributes, valid_session
        expect(assigns(:chat)).to be_a(Chat)
        expect(assigns(:chat)).to be_persisted
      end

      it 'assigns a newly created message as @message' do
        post :create, valid_attributes, valid_session
        expect(assigns(:message)).to be_a(Message)
        expect(assigns(:message)).to be_persisted
      end

      it 'returns created status' do
        post :create, valid_attributes, valid_session
        expect(response.status).to eq(201)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        chat_user = FactoryGirl.create(:chat_user)
        chat = chat_user.chat
        { id: chat.to_param, message: { body: '' } }
      end

      it 'assigns chat as @chat' do
        post :create, invalid_attributes, valid_session
        expect(assigns(:chat)).to be_a(Chat)
      end

      it 'returns @message errors' do
        post :create, invalid_attributes, valid_session
        expect(assigns(:message).errors[:body]).to eq(["can't be blank"])
      end
    end
  end
end
