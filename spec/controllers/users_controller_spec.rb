require 'spec_helper'

describe UsersController do

	before{FactoryGirl.create_list(:user,30)
}
	describe "sign up" do
		context "given valid information" do
			it "create user account" do
				get :new
				expect(response).to render_template("users/new")
				expect{post :create,params: { user:{  name:  "UserCreate",
	                       email: "user@example.com",
	                       password:              "foobar",
	                       password_confirmation: "foobar" } }
	      }.to change{User.count}.by(1)
	                      
	    end
	  end

    context 'given valid information' do
      let(:user_params) do
        {
          user: {
            name: 'UserCreate',
            email: 'user@example.com',
            password: 'foobar',
            password_confirmation: 'foobar'
          }
        }
      end

      it 'renders user/new' do
        subject
        expect(response).to render_template('users/new')
      end

      it 'creates user account' do
        expect{ subject }.to change{User.count}.from(0).to(1)
      end
    end

    context 'given invalid information' do
      let(:user_params) do
        {
          user: {
            name: '',
            email: '',
            password: 'fooba',
            password_confirmation: 'fooba'
          }
        }
      end

      it 'renders sessions/new' do
        subject
        expect(response).to render_template('sessions/new')
      end

      it 'does nothing' do
        expect{ subject }.not_to change{ User.count }.by(1)
      end
    end
  end
end
