require 'spec_helper'

module QCRecipeSuite
  describe Point do
    let(:single_point) { File.open('data/spec/point/point.csv', 'r') }
    let(:datetime1) { DateTime.new(y=2011, m=8, d=27, h=0, min=24) }
    let(:parameters) do
      { :point => "1 (LAMPEXP)",
        :thick1 => "10189.16",
        :mse => "4.322",
        :gain_te => "1",
        :gain_tm => "1",
        :x => "44.985",
        :y => "-0.216" }
    end

    before(:each) do
      @point = Point.new(single_point.readlines)
    end

    it "should store the DateTime" do
      @point.datetime.should == datetime1
    end

    it "should store the Film Name" do
      @point.filmname.should == "SQC Acq-SR OCD Short2 FX"
    end

    it "should store the Stage Group" do
      @point.stagegroup.should == "4X Pad6 FX"
    end

    it "should store the Lot ID" do
      @point.lotid.should == "SQC NSTD"
    end

    it "should store the Wafer ID" do
      @point.waferid.should == "# 24"
    end

    it "should store the parameter headers and data" do
      @point.parameters.should == parameters
    end

    after(:each) do
      single_point.close
    end
  end
end