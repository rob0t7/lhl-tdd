require 'rails_helper'

RSpec.describe BreweriesController, type: :controller do

  describe "GET #index" do
    let(:brewery1) { FactoryBot.create(:brewery) }
    let(:brewery2) { FactoryBot.create(:brewery) }

    let(:brewery_results) { [brewery1, brewery2] }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'fetches all the records by ascending name' do
      expect(Brewery).to receive(:all_in_ascending_order)
                           .with(no_args)
                           .and_return(brewery_results)
      get :index
    end
  end

  describe 'GET #new' do
    before do
      allow(Brewery).to receive(:new)
      get :new
    end

    it 'returns a 200 response' do
      expect(response).to have_http_status(:ok)
    end

    it 'generates a new Brewery instance for the form' do
      expect(Brewery).to have_received(:new)
    end
  end

  describe 'POST #create' do
    let(:params) { {brewery: {name: Faker::Company.name} } }

    context 'with valid params' do
      it "redirects to the index action" do
        post :create, params: params
        expect(response).to redirect_to(breweries_path)
      end

      it "displays a success message" do
        post :create, params: params
        expect(flash.notice).to eq("Successfully added new Brewery.")
      end

      it "inserts the brewery into the DB" do
        expect {
          post :create, params: params
        }.to change { Brewery.count }.by(1)
        expect(Brewery.last.name).to eq(params[:brewery][:name])
      end
    end

    context 'with invalid params' do
      before do
        params[:brewery][:name] = ''
      end

      it "does not insert a new DB record" do
        expect {
          post :create, params: params
        }.to_not change { Brewery.count }
      end

      it "re-render the input form" do
        post :create, params: params
        expect(response).to have_http_status(:ok)
      end

      it "display an error message" do
        post :create, params: params
        expect(flash.alert).to eq("There was an error adding a brewery.")
      end
    end
  end

end
