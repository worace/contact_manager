require 'rails_helper'

RSpec.describe EmailAddressesController, :type => :controller do
  let(:person) { Person.create(first_name: "horace", last_name: "worace") }
  let(:company) { Company.create(:name => "Shinra Corp") }
  let(:valid_attributes) {
    {address: "worace@worace.com", contact_id: person.id, contact_type: "Person"}
  }

  let(:invalid_attributes) {
    {address: nil, contact_type: nil, contact_id: nil}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EmailAddressesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all email_addresses as @email_addresses" do
      email_address = EmailAddress.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:email_addresses)).to eq([email_address])
    end
  end

  describe "GET show" do
    it "assigns the requested email_address as @email_address" do
      email_address = EmailAddress.create! valid_attributes
      get :show, {:id => email_address.to_param}, valid_session
      expect(assigns(:email_address)).to eq(email_address)
    end
  end

  describe "GET new" do
    it "assigns a new email_address as @email_address" do
      get :new, {}, valid_session
      expect(assigns(:email_address)).to be_a_new(EmailAddress)
    end

    it "links the email address to a contact_id and type provided in the url" do
      get :new, {:contact_id => person.id, :contact_type => "Person"}, valid_session
      expect(assigns(:email_address).contact_id).to eq(person.id)
      expect(assigns(:email_address).contact_type).to eq("Person")
    end
  end

  describe "GET edit" do
    it "assigns the requested email_address as @email_address" do
      email_address = EmailAddress.create! valid_attributes
      get :edit, {:id => email_address.to_param}, valid_session
      expect(assigns(:email_address)).to eq(email_address)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new EmailAddress" do
        expect {
          post :create, {:email_address => valid_attributes}, valid_session
        }.to change(EmailAddress, :count).by(1)
      end

      it "assigns a newly created email_address as @email_address" do
        post :create, {:email_address => valid_attributes}, valid_session
        expect(assigns(:email_address)).to be_a(EmailAddress)
        expect(assigns(:email_address)).to be_persisted
      end

      it "redirects to the address's person" do
        post :create, {:email_address => valid_attributes}, valid_session
        expect(response).to redirect_to(EmailAddress.last.contact)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved email_address as @email_address" do
        post :create, {:email_address => invalid_attributes}, valid_session
        expect(assigns(:email_address)).to be_a_new(EmailAddress)
      end

      it "re-renders the 'new' template" do
        post :create, {:email_address => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {:address => "new@new.com", :contact_id => person.id, :contact_type => "Person"}
      }

      it "updates the requested email_address" do
        email_address = EmailAddress.create! valid_attributes
        put :update, {:id => email_address.to_param, :email_address => new_attributes}, valid_session
        email_address.reload
      end

      it "assigns the requested email_address as @email_address" do
        email_address = EmailAddress.create! valid_attributes
        put :update, {:id => email_address.to_param, :email_address => valid_attributes}, valid_session
        expect(assigns(:email_address)).to eq(email_address)
      end

      it "redirects to the email_address's owner" do
        email_address = EmailAddress.create! valid_attributes
        put :update, {:id => email_address.to_param, :email_address => valid_attributes}, valid_session
        expect(response).to redirect_to(email_address.contact)
      end
    end

    describe "with invalid params" do
      it "assigns the email_address as @email_address" do
        email_address = EmailAddress.create! valid_attributes
        put :update, {:id => email_address.to_param, :email_address => invalid_attributes}, valid_session
        expect(assigns(:email_address)).to eq(email_address)
      end

      it "re-renders the 'edit' template" do
        email_address = EmailAddress.create! valid_attributes
        put :update, {:id => email_address.to_param, :email_address => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested email_address" do
      email_address = EmailAddress.create! valid_attributes
      expect {
        delete :destroy, {:id => email_address.to_param}, valid_session
      }.to change(EmailAddress, :count).by(-1)
    end

    it "redirects to the email_addresses list" do
      email_address = EmailAddress.create! valid_attributes
      delete :destroy, {:id => email_address.to_param}, valid_session
      expect(response).to redirect_to(email_address.contact)
    end
  end
end
