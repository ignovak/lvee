require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news/edit" do
  before(:each) do
    @news = stub_model(News,
      :new_record? => false,
      :id => 1234
      )
    assign :news, @news
  end

  it "should render edit form" do
    render

    rendered.should have_selector("form[method=post]", :action => news_item_path(@news)) do
    end
  end
end
