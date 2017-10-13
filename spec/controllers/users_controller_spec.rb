require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
    before do
      get :new
    end

    it { should respond_with(200) }
    it { should render_template('new') }
  end

  describe 'POST #create' do
    let(:valid_params) {{
      username: "johndoe",
      email:"johndoe@example.com",
      first_name:"John",
      last_name:"Doe",
      password: "ruby123",
      password_confirmation:"ruby123"
      }}
      let(:invalid_params) {{
        username: "janedoe",
        email:"janedoeexample.com",
        first_name:"Jane",
        last_name:"Doe",
        password: "123",
        password_confirmation:"123"
        }}
        # happy_path
        context "valid_params" do

          it "creates new user if params are correct" do
            expect {post :create, params: {user: valid_params}}.to change(User, :count).by(1)
          end

          it 'redirects to root path and displays flash success after user created successfully' do
            post :create, params: {user: valid_params}
            expect(response).to redirect_to '/'
            expect(flash[:success]).to include 'Account successfully created!'
          end
        end

        # unhappy_path
        context "invalid_params" do
          before do
            post :create, params: {user: invalid_params}
          end

          it "displays flash alert message" do
            expect(flash[:error]).to include "There was an error creating your account."
          end

          it "renders new template again" do
            expect(response).to render_template("new")
          end
        end

      end
    end
