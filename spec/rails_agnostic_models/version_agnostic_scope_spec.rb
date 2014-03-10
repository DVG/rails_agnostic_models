require 'spec_helper'

describe "#version_agnostic_scope" do
  context "Rails 2" do
    class Rails2Class < ActiveRecord::Base
    end
    before { stub_const("Rails::VERSION::MAJOR", 2) }
    let(:where) { Proc.new {where(active: true)} }
    it "proxies to named scope for Rails 2" do
      Rails2Class.should_receive(:named_scope).with(:active, where)
      Rails2Class.should_not_receive(:scope).with(:active, where)
      Rails2Class.send(:version_agnostic_scope, :active, where)
    end
  end
  context "Rails 3" do
    class Rails3Class < ActiveRecord::Base
    end

    before { stub_const("Rails::VERSION::MAJOR", 3) }
    let(:where) { Proc.new {where(active: true)} }
    it "proxies to scope for Rails 3" do
      Rails3Class.should_not_receive(:named_scope).with(:active, where)
      Rails3Class.should_receive(:scope).with(:active, where)
      Rails3Class.send(:version_agnostic_scope, :active, where)
    end
  end
end