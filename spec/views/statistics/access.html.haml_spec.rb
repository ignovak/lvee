require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/statistics/access" do
  helper :application

  before(:each) do
    assign :report_os, [
      OpenStruct.new(:operating_system => "Linux", :visits => 1234),
      OpenStruct.new(:operating_system => "Windows", :visits => 1132),
    ]
    assign :report_browser, [
      OpenStruct.new(:browser => "Firefox", :visits => 1234),
      OpenStruct.new(:browser => "IE", :visits => 1132),
    ]
    assign :report_country, [
      OpenStruct.new(:country => "Belarus", :visits => 1234),
      OpenStruct.new(:country => "Russia", :visits => 1132),
    ]
  end

  it "should render properly" do
    controller.stub!(:cache_result_for).and_yield()
    view.stub! :fetch_statistics
    Conference.create!(:name => "abc", :start_date => 1.year.ago, :finish_date => 1.year.ago)
    render
  end
end
