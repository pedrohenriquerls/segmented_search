require 'spec_helper'

describe QuerySegmentsController, type: :controller do

  subject!(:segment){FactoryGirl.create(:sherlock_without_jo)}
  before(:each) do
    FactoryGirl.create(:soares)
    FactoryGirl.create(:sherlock)
    FactoryGirl.create(:moriarty)
  end

  it 'GET index' do
    get :index
    assert_response :success

    query_segments = assigns(:query_segments)
    expect(query_segments.count).to eq 1

    expect(response).to render_template('index')
  end

  it 'GET new' do
    get :new

    assert_response :success
    expect(response).to render_template('new')
  end

  it 'GET edit' do
    get :edit, id: segment.id

    assert_response :success
    expect(response).to render_template('edit')
  end

  describe 'POST create' do
    it 'should try save invalid model' do
      params = {
        query_segment: {
          name: 'teste'
        }
      }

      post :create, params
      query_segment = assigns(:query_segment)
      query_segment.errors.messages[:criteria].should include(I18n.t('errors.messages.blank'))
    end

    it 'should avoid sql injection' do
      params = {
        query_segment: {
          name: 'teste',
          criteria: "{'name': {'operator': '=', 'value': 'Sherlock Holmes';DROP TABLE query_segments''}}"
        }
      }

      post :create, params
      query_segment = assigns(:query_segment)
      query_segment.errors.messages[:criteria].should include(I18n.t('query_segment.invalid_words'))
    end

    it 'should save new query_segment' do
      expect(Contact.count).to eq(3)

      params = {
        query_segment: {
          name: 'teste',
          criteria: '{"name": {"operator": "=", "value": "Sherlock Holmes"}}'
        }
      }

      post :create, params
      query_segment = assigns(:query_segment)
      expect(query_segment.valid?).to be_truthy
      expect(QuerySegment.count).to eq(2)
      expect(query_segment.contacts.count).to eq(1)
      expect(query_segment.contacts.first.name).to eq('Sherlock Holmes')
    end
  end

  describe 'PUT update' do
    it 'should save update query_segment' do
      query_segment = {
          name: 'teste'
      }

      put :update, {query_segment: query_segment, id: segment.id}
      query_segment = assigns(:query_segment)
      expect(query_segment.name).to eq('teste')
    end
  end

  it 'DELETE destroy' do
    expect(QuerySegment.count).to eq(1)
    delete :destroy, id: segment.id
    expect(QuerySegment.count).to eq(0)
  end
end