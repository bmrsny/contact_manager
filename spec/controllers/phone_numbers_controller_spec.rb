require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe PhoneNumbersController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # PhoneNumber. As you add validations to PhoneNumber, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { number: "MyString", person_id: 1}
  }

  let(:invalid_attributes) {
    { number: nil, person_id: nil}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PhoneNumbersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all phone_numbers as @phone_numbers" do
      phone_number = PhoneNumber.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:phone_numbers)).to eq([phone_number])
    end
  end

  describe "GET show" do
    it "assigns the requested phone_number as @phone_number" do
      phone_number = PhoneNumber.create! valid_attributes
      get :show, {:id => phone_number.to_param}, valid_session
      expect(assigns(:phone_number)).to eq(phone_number)
    end
  end

  describe "GET new" do
    it "assigns a new phone_number as @phone_number" do
      get :new, {}, valid_session
      expect(assigns(:phone_number)).to be_a_new(PhoneNumber)
    end
  end

  describe "GET edit" do
    it "assigns the requested phone_number as @phone_number" do
      phone_number = PhoneNumber.create! valid_attributes
      get :edit, {:id => phone_number.to_param}, valid_session
      expect(assigns(:phone_number)).to eq(phone_number)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      let(:alice) { Person.create(first_name: 'Alice', last_name: 'Smith') }
      let(:valid_attributes) { {number: '555-1234', person_id: alice.id} }

      it "creates a new PhoneNumber" do
        expect {
          post :create, {:phone_number => valid_attributes}, valid_session
        }.to change(PhoneNumber, :count).by(1)
      end

      it "assigns a newly created phone_number as @phone_number" do
        post :create, {:phone_number => valid_attributes}, valid_session
        expect(assigns(:phone_number)).to be_a(PhoneNumber)
        expect(assigns(:phone_number)).to be_persisted
      end

      it "redirects to the phone_number's person" do
        alice = Person.create(first_name: "Alice", last_name: "Wonder")
        valid_attributes = { number: '555-8888', person_id: alice.id }

        post :create, {:phone_number => valid_attributes}, valid_session
        expect(response).to redirect_to(alice)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved phone_number as @phone_number" do
        post :create, {:phone_number => invalid_attributes}, valid_session
        expect(assigns(:phone_number)).to be_a_new(PhoneNumber)
      end

      it "re-renders the 'new' template" do
        post :create, {:phone_number => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do

      let(:bob) {Person.create(first_name: 'Bob', last_name: "Jones")}

      let(:valid_attributes) { {number: '555-5678', person_id: bob.id}}
      let(:new_attributes) {
        { number: 'MyNewString', person_id: bob.id}
      }

      it "updates the requested phone_number" do
        phone_number = PhoneNumber.create! valid_attributes
        put :update, {:id => phone_number.to_param, :phone_number => new_attributes}, valid_session
        phone_number.reload
        expect(phone_number.number).to eq('MyNewString')
        expect(phone_number.person_id).to eq(bob.id)
      end

      it "assigns the requested phone_number as @phone_number" do
        phone_number = PhoneNumber.create! valid_attributes
        put :update, {:id => phone_number.to_param, :phone_number => valid_attributes}, valid_session
        expect(assigns(:phone_number)).to eq(phone_number)
      end

      it "redirects to the phone_number" do
        vailid_attributes = { number: '555-5678', person_id: bob.id }
        phone_number = PhoneNumber.create! valid_attributes
        put :update, {:id => phone_number.to_param, :phone_number => valid_attributes}, valid_session
        expect(response).to redirect_to(bob)
      end
    end

    describe "with invalid params" do
      it "assigns the phone_number as @phone_number" do
        phone_number = PhoneNumber.create! valid_attributes
        put :update, {:id => phone_number.to_param, :phone_number => invalid_attributes}, valid_session
        expect(assigns(:phone_number)).to eq(phone_number)
      end

      it "re-renders the 'edit' template" do
        phone_number = PhoneNumber.create! valid_attributes
        put :update, {:id => phone_number.to_param, :phone_number => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
      let(:bob) {Person.create(first_name: 'Bob', last_name: 'Jones')}
      let(:valid_attributes) { {number: '555-5678', person_id: bob.id}}
      
    it "destroys the requested phone_number" do
      phone_number = PhoneNumber.create! valid_attributes
      expect {
        delete :destroy, {:id => phone_number.to_param}, valid_session
      }.to change(PhoneNumber, :count).by(-1)
    end

    it "redirects to the phone_numbers list" do
      phone_number = PhoneNumber.create! valid_attributes
      delete :destroy, {:id => phone_number.to_param}, valid_session
      expect(response).to redirect_to(bob)
    end
  end

end
