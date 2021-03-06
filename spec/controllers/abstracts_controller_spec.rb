require 'spec_helper'

describe AbstractsController do

  def valid_attributes
    {title: "test", authors: "a", summary: "ab", :license => "lic",
      body: "test", change_summary: "123",
      conference_id: @conference.id, author_id: @user.id, user_ids: [@user.id]}
  end

  before do
    @user = User.new(:first_name => "Test1", :last_name => "Test2")
    @user.save(:validate => false)
    login_as @user
    @conference = Conference.new(:name => "test")
    @conference.save!(:validate => false)
    @conference_registration = ConferenceRegistration.new(user_id: @user.id,
                                                          conference_id: @conference.id)
    @conference_registration.save!(:validate => false)
  end

  describe "GET index" do
    it "assigns all abstracts as @abstracts" do
      abstract = Abstract.create!(valid_attributes.merge(:ready_for_review => true),
                                  :without_protection => true)
      get :index
      assigns(:abstracts).should eq([abstract])
    end
  end

  describe "GET show" do
    it "assigns the requested abstract as @abstract" do
      abstract = Abstract.create!(valid_attributes, :without_protection => true)
      get :show, :id => abstract.id.to_s
      assigns(:abstract).should eq(abstract)
    end
  end

  describe "GET edit" do
    it "assigns the requested abstract as @abstract" do
      abstract = Abstract.create!(valid_attributes, :without_protection => true)
      get :edit, :id => abstract.id.to_s
      assigns(:abstract).should eq(abstract)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Abstract" do
        expect {
          post :create, :abstract => valid_attributes
        }.to change(Abstract, :count).by(1)
      end

      it "assigns a newly created abstract as @abstract" do
        post :create, :abstract => valid_attributes
        assigns(:abstract).should be_a(Abstract)
        assigns(:abstract).should be_persisted
      end

      it "redirects to the created abstract" do
        post :create, :abstract => valid_attributes
        response.should redirect_to(Abstract.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved abstract as @abstract" do
        # Trigger the behavior that occurs when invalid params are submitted
        Abstract.any_instance.stub(:save).and_return(false)
        post :create, :abstract => {}
        assigns(:abstract).should be_a_new(Abstract)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Abstract.any_instance.stub(:save).and_return(false)
        post :create, :abstract => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before do
        @reg = stub_model(ConferenceRegistration, :user_id => @user.id)
        Abstract.any_instance.stub(:conference_registration).and_return(@reg)
      end

      it "updates the requested abstract" do
        abstract = Abstract.create!(valid_attributes, :without_protection => true)
        # Assuming there are no other abstracts in the database, this
        # specifies that the Abstract created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Abstract.any_instance.should_receive(:update_attributes).with({'these' => 'params',
                                                                        "author" => @user})
        put :update, :id => abstract.id, :abstract => {'these' => 'params'}
      end

      it "assigns the requested abstract as @abstract" do
        abstract = Abstract.create!(valid_attributes, :without_protection => true)
        put :update, :id => abstract.id, :abstract => valid_attributes
        assigns(:abstract).should eq(abstract)
      end

      it "redirects to the abstract" do
        abstract = Abstract.create!(valid_attributes, :without_protection => true)
        put :update, :id => abstract.id, :abstract => valid_attributes
        response.should redirect_to(Abstract.last)
      end
    end

    describe "with invalid params" do
      it "assigns the abstract as @abstract" do
        abstract = Abstract.create!(valid_attributes, :without_protection => true)
        # Trigger the behavior that occurs when invalid params are submitted
        Abstract.any_instance.stub(:save).and_return(false)
        put :update, :id => abstract.id.to_s, :abstract => {}
        assigns(:abstract).should eq(abstract)
      end

      it "re-renders the 'edit' template" do
        abstract = Abstract.create!(valid_attributes, :without_protection => true)
        abstract.users << @user
        # Trigger the behavior that occurs when invalid params are submitted
        Abstract.any_instance.stub(:save).and_return(false)
        put :update, :id => abstract.id.to_s, :abstract => {}
        response.should render_template("edit")
      end
    end
  end

  #describe "DELETE destroy" do
  #  it "destroys the requested abstract" do
  #    abstract = Abstract.create!(valid_attributes, :without_protection => true)
  #    expect {
  #      delete :destroy, :id => abstract.id.to_s
  #    }.to change(Abstract, :count).by(-1)
  #  end
  #
  #  it "redirects to the abstracts list" do
  #    abstract = Abstract.create!(valid_attributes, :without_protection => true)
  #    delete :destroy, :id => abstract.id.to_s
  #    response.should redirect_to(abstracts_url)
  #  end
  #end

end
