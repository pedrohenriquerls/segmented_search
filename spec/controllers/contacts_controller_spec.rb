require 'spec_helper'

describe ContactsController, type: :controller do

  subject!(:sherlock){FactoryGirl.create(:sherlock)}
  before(:each) do
    FactoryGirl.create(:moriarty)
  end

  it 'GET index' do
    get :index
    assert_response :success

    contacts = assigns(:contacts)
    expect(contacts.count).to eq 2

    expect(response).to render_template('index')
  end

  it 'GET new' do
    get :new

    assert_response :success
    expect(response).to render_template('new')
  end

  it 'GET edit' do
    get :edit, id: sherlock.id

    assert_response :success
    expect(response).to render_template('edit')
  end

  describe 'POST create' do
    it 'should try save invalid model' do
      params = {
          contact: {
              name: 'teste',
              age: '66',
              state: 'ac'
          }
      }

      post :create, params
      contact = assigns(:contact)
      contact.errors.messages[:email].should include(I18n.t('errors.messages.blank'))
      contact.errors.messages[:role].should include(I18n.t('errors.messages.blank'))
    end

    it 'should save new contact' do
      expect(Contact.count).to eq(2)

      params = {
          contact: {
              name: 'teste',
              age: '66',
              state: 'ac',
              role: 'QA',
              email: 'teste@gmail.com'
          }
      }

      post :create, params
      contact = assigns(:contact)
      expect(contact.valid?).to be_truthy
      expect(Contact.count).to eq(3)
    end
  end

  describe 'PUT update' do
    it 'should try udpate invalid contact' do
      contact = {
          name: 'teste',
          age: '66',
          state: 'ac',
          email: nil,
          role: nil
      }

      put :update, {contact: contact, id: sherlock.id}
      contact = assigns(:contact)
      contact.errors.messages[:email].should include(I18n.t('errors.messages.blank'))
      contact.errors.messages[:role].should include(I18n.t('errors.messages.blank'))
    end

    it 'should save update contact' do
      contact = {
          name: 'teste',
          age: 66,
          state: 'ac'
      }

      put :update, {contact: contact, id: sherlock.id}
      sherlock.reload

      expect(sherlock.name).to eq(contact[:name])
      expect(sherlock.age).to eq(contact[:age])
      expect(sherlock.state).to eq(contact[:state])
    end
  end

  it 'DELETE destroy' do
    expect(Contact.count).to eq(2)
    delete :destroy, id: sherlock.id
    expect(Contact.count).to eq(1)
  end

end