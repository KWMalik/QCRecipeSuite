require 'spec_helper'

module QCRecipeSuite
  describe Dataset do
    let(:file1) { File.open('data/spec/dataset/points1.csv', 'r') }
    let(:file2) { File.open('data/spec/dataset/points2.csv', 'r') }
    let(:file3) { File.open('data/spec/dataset/points3.csv', 'r') }
    let(:set1) { Dataset.new(file1) }
    let(:set2) { Dataset.new(file2) }
    let(:set3) { Dataset.new(file3) }
    let(:mean_delta) { 0.01 }
    let(:stdev_delta) { 0.000001 }

    describe "new dataset" do
      it "should have the correct number of points" do
        set1.should have(2).points
      end
    end

    describe "#similar_to?" do
      it "should return true for a similar set" do
        set1.similar_to?(set2).should be_true
      end

      it "should return false for a dissimilar set" do
        set1.similar_to?(set3).should be_false
        set2.similar_to?(set3).should be_false
      end
    end

    describe "#within_limits_of?" do
      it "should return true for a set within limits of another set" do
        set1.within_limits_of?(set2).should be_true
      end

      it "should return false for a set not within limits of another set" do
        set3.within_limits_of?(set1).should be_false
      end
    end
    
    describe "statistical methods" do
      it "should calculate the mean of the points" do
        set1.mean.should be_within(mean_delta).of(10189.24)
        set2.mean.should be_within(mean_delta).of(10189.51)
        set3.mean.should be_within(mean_delta).of(10187.74)
      end

      it "should calculate the stdev of the points" do
        set1.stdev.should be_within(stdev_delta).of(0.113137)
        set2.stdev.should be_within(stdev_delta).of(0.205061)
        set3.stdev.should be_within(stdev_delta).of(0.59397)
      end

      it "should calculate the lower limit of the points" do
        set1.lowerlimit.should be_within(mean_delta).of(10188.9)
        set2.lowerlimit.should be_within(mean_delta).of(10188.89)
        set3.lowerlimit.should be_within(mean_delta).of(10185.96)
      end

      it "should calculate the upper limit of the points" do
        set1.upperlimit.should be_within(mean_delta).of(10189.58)
        set2.upperlimit.should be_within(mean_delta).of(10190.12)
        set3.upperlimit.should be_within(mean_delta).of(10189.52)
      end
    end
    
    after(:each) do
      file1.close
      file2.close
      file3.close
    end
  end
end
