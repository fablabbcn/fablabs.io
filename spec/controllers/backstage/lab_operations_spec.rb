require 'spec_helper'

class DummyController < ApplicationController
  include LabsOperations
  attr_accessor :lab
end

describe LabsOperations do
  let(:controller) { DummyController.new }
  let(:creator) { FactoryBot.create(:user) }
  let(:lab) { FactoryBot.create(:lab, creator: creator, referee_id: nil) }
  let(:admin) { FactoryBot.create(:user) }
  let(:employee) { FactoryBot.create(:employee, user: admin, lab: lab) }

  before do
    allow(lab).to receive(:direct_admins).and_return([admin])
    controller.lab = lab
    allow(UserMailer).to receive(:send).and_return(double(deliver_now: true))
  end

  it "notifies the creator and admins" do
    controller.send(:lab_send_action, "updated")

    expect(UserMailer).to have_received(:send).with("lab_updated", lab.id, admin.id)
    expect(UserMailer).to have_received(:send).with("lab_updated", lab.id, creator.id)
  end
end
