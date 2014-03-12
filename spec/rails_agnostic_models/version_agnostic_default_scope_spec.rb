require 'spec_helper'

class Rails2Class < ActiveRecord::Base
end
class Rails3Class < ActiveRecord::Base
end

describe "#version_agnostic_default_scope" do
  context "Rails 2" do
    before { stub_const("Rails::VERSION::MAJOR", 2) }
    let(:hash) { {order: "my_column desc"} }
    it "passes the options hash to Rails2 classes" do
      Rails2Class.should_receive(:default_scope).with(hash)
      Rails2Class.send(:version_agnostic_default_scope, hash)
    end
  end
  context "Rails 3" do
    before { stub_const("Rails::VERSION::MAJOR", 3) }
    describe "order" do
      let(:hash) { {order: "my_column desc"} }
      let(:arel) { "default_scope order('#{hash[:order]}')" }
      it "converts options hash to arel calls" do
        Rails3Class.should_receive(:instance_eval).with(arel)
        Rails3Class.send(:version_agnostic_default_scope, hash)
      end
    end
    describe "where" do
      context "hash" do
        context "single value" do
          let(:hash) { {:conditions => {active: true} } }
          let(:arel) { "default_scope where(active: true)" }
          it "converts options hash to arel calls" do
            Rails3Class.should_receive(:instance_eval).with(arel)
            Rails3Class.send(:version_agnostic_default_scope, hash)
          end
        end
        context "Multiple values" do
          let(:hash) { {:conditions => {active: true, deleted: false} } }
          let(:arel) { "default_scope where(active: true, deleted: false)" }
          it "converts options hash to arel calls" do
            Rails3Class.should_receive(:instance_eval).with(arel)
            Rails3Class.send(:version_agnostic_default_scope, hash)
          end
        end
      end
      context "String" do
        let(:string) { {:conditions => "active = 1"} }
        let(:code) { "default_scope where(\"active = 1\")"}
        it "puts string in where method" do
          Rails3Class.should_receive(:instance_eval).with(code)
          Rails3Class.send(:version_agnostic_default_scope, string)
        end
      end
      context "Array" do
        let(:array) { {:conditions => ["active = ?", 1]} }
        let(:code) { "default_scope where(\"active = ?\", 1)"}
        it "puts string in where method" do
          Rails3Class.should_receive(:instance_eval).with(code)
          Rails3Class.send(:version_agnostic_default_scope, array)
        end
      end
    end
  end
end