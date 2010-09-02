require 'spec_helper'

describe List do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    List.create!(@valid_attributes)
  end
end
