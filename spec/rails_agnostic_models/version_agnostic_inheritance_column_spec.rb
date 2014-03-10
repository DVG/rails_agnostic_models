require 'spec_helper'
class Rails2Class < ActiveRecord::Base
end
class Rails3Class < ActiveRecord::Base
end
describe "#version_agnostic_inheritance_column" do
  context "Rails 2" do
    before { stub_const("Rails::VERSION::MAJOR", 2) }
    it "set_inheritance_column for rails 2" do
      Rails2Class.should_receive(:set_inheritance_column).with("type_inheritance")
      Rails2Class.should_not_receive(:inheritance_column=).with("type_inheritance")
      Rails2Class.send(:version_agnostic_inheritance_column, "type_inheritance")
    end
  end
  context "Rails 3" do
    before { stub_const("Rails::VERSION::MAJOR", 3) }
    it "inheritance_column= for rails 3" do
      Rails2Class.should_not_receive(:set_inheritance_column).with("type_inheritance")
      Rails2Class.should_receive(:inheritance_column=).with("type_inheritance")
      Rails2Class.send(:version_agnostic_inheritance_column, "type_inheritance")
    end
  end
end