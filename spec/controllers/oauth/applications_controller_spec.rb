require 'spec_helper'


describe Oauth::ApplicationsController, type: :controller do
        
     
    describe 'GET #index' do
        render_views
   
    
        it "will redirect to login if not logged in" do
            get :index
            path = signin_path
            expect(response).to redirect_to("/signin?goto=%2Foauth%2Fapplications")
        end

        it "will show an application list if logged in" do
            user = FactoryBot.create(:user)
    
            session[:user_id] = user.id
            app = FactoryBot.create(:oauth_application, owner: user)

            get :index
            status, headers, body = *response
            expect(response).to be_success
            expect(response).to render_template(:index)
            expect(response.body).to include("Your applications")
            expect(response.body).to include(app.name)
        end



    end


    describe 'GET #show' do
        render_views

        before do
            @user = FactoryBot.create(:user)
            @anotherUser = FactoryBot.create(:user)
            @app = FactoryBot.create(:oauth_application, owner: @user)
    
        end
   
        it "will redirect if not logged in" do

            get :show, params: { id: @app.id }
            path = signin_path
            expect(response).to redirect_to("/signin?goto=%2Foauth%2Fapplications%2F#{@app.id}")
        end
        it "will show an application detail if logged in" do

            session[:user_id] = @user.id
            get :show, params: { id: @app.id }

            status, headers, body = *response

            expect(response).to render_template(:show)
            expect(assigns(:token)).to be_a(Doorkeeper::AccessToken)
        end 
        it "will not show the app if logged in as another user" do


            session[:user_id] = @anotherUser.id
            expect {
              get :show, params: { id: @app.id }
            }.to raise_error(ActiveRecord::RecordNotFound)
            #unauthorized
        end

    end

    describe 'POST #create' do

    end

end
