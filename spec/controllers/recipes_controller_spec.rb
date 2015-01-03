require 'spec_helper'

describe RecipesController do
  render_views

  describe "index" do
    before do
      Recipe.create!(name: 'Baked Potato w/ Cheese')
      Recipe.create!(name: 'Fried Salmon')
      Recipe.create!(name: 'Peperoni Pizza')
      
      xhr :get, :index, format: :json, keywords: keywords
    end
    
    subject(:results) { JSON.parse(response.body) }
    
    def extract_name
      -> (object) { object["name"] } 
    end

    context "when the search finds the results" do
      let(:keywords) { 'baked' }
      
      it "should 200" do
        expect(response.status).to eq(200)
      end
      it "should return 1 results" do
        expect(results.size).to eq(1)
      end
      it "should include 'baked potato w/ cheese'" do
        expect(results.map(&extract_name)).to include('Baked Potato w/ Cheese')
      end
    end
    
    context "when search doesnt find results" do
      let(:keywords) { 'foo' }
      it "should return no results" do
        expect(results.size).to eq(0)
      end
    end

  end

end
