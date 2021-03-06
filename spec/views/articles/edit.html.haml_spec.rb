require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/articles/edit.html" do

  before(:each) do
    @article = stub_model(Article,
      :new_record? => false,
      :title => "value for title",
      :body => "value for body",
      :category => "value for category",
      :name => "value for subcategory",
      :locale => "value for locale"
    )
    assign :article, @article
  end

  it "should render edit form" do
    render

    rendered.should have_selector("form[method=post]", :action => article_path(@article)) do |n|
      n.should have_selector('input#article_title', :name => "article[title]")
      n.should have_selector('textarea#article_body', :name => "article[body]")
      n.should have_selector('input#article_category', :name => "article[category]")
      n.should have_selector('input#article_name', :name => "article[name]")
    end
  end
end
