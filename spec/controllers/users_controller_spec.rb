require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
    before { get :new }

    it { should respond_with(200) }
    it { should render_template('new') }
  end
end
