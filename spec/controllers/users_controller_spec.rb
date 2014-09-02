require "rails_helper"

describe UsersController do
  describe "GET index" do
    it "assigns the users variable" do
      user = Fabricate(:user)
      get :index
      expect(assigns(:users)).to_not be_empty
    end
  end

  describe "GET new" do
    it "assigns the @user variable" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "redirects to the users index page" do
        expect(response).to redirect_to users_path
      end
      
      it "saves a new user to the database" do
        expect(User.count).to eq(1)
      end

      it "sets the success notice" do
        expect(flash[:success]).to_not be_blank
      end
    end

    context "with invalid input" do
      before { post :create, user: { first_name: nil, last_name: nil, email: nil } }
      it "renders the new users template" do
        expect(response).to render_template :new
      end

      it "flashes the error notice" do
        expect(flash[:error]).to_not be_blank
      end
    end
  end

  describe "GET edit" do
    it "assigns the @user variable" do
      maria = Fabricate(:user)
      get :edit, id: maria.id
      expect(assigns(:user)).to eq(maria)
    end
  end

  describe "PATCH update" do
    let(:maria) { Fabricate(:user, email: "maria@example.com") }

    context "with valid input" do
      before {  patch :update, id: maria.id, user: { first_name: maria.first_name, last_name: maria.last_name, email: "maria@test.com"} }
      
      it "assigns the @user variable" do
        expect(assigns(:user)).to eq(maria)
      end

      it "updates the users attributes" do
        expect(maria.reload.email).to eq("maria@test.com")
      end
    
      it "redirects to the user show page" do
        expect(response).to redirect_to users_path
      end
    end

    context "with invalid input" do
      before {  patch :update, id: maria.id, user: { first_name: maria.first_name, last_name: maria.last_name, email: "mariatest.com"} }
      
      it "render the edit page" do
        expect(response).to render_template :edit
      end

      it "sends the error message" do
        expect(flash[:error]).to_not be_blank
      end
    end
  end

  describe "DELETE destroy" do
    let(:sarah)  { Fabricate(:user) }
    before { delete :destroy, id: sarah.id }

    it "deletes the user" do
      expect(User.count).to eq(0)
    end

    it "redirects to the user index page" do
      expect(response).to redirect_to users_path
    end
  end
end






