require 'spec_helper'

class MyClass < ActiveRecord::Base
end

class OtherClass < ActiveRecord::Base
  NUMBER = 1
end

module MyModule
  class MyClass < ActiveRecord::Base
  end
end

describe "#self.safe_constant" do
  it "accepts strings" do
    MyClass.send(:safe_constant, "OtherClass").should eq OtherClass
  end
  it "accepts symbols" do
    MyClass.send(:safe_constant, :OtherClass).should eq OtherClass
  end
  it "does not return the constant if it's not defined" do
    MyClass.send(:safe_constant, :SomeOtherClass).should be_nil
  end
  it "returns the constant if it's defined" do
    MyClass.send(:safe_constant, :OtherClass).should eq OtherClass
  end
  context "namespaced constants" do
    it "returns namedspaced constants" do
      MyClass.send(:safe_constant, "MyModule::MyClass").should eq MyModule::MyClass
    end 
    it "returns nil if it doesn't exist" do
      MyClass.send(:safe_constant, "MyModule::SOMETHING_FAKE").should be_nil
    end 
  end
end
