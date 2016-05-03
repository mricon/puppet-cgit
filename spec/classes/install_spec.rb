require 'spec_helper'
describe 'cgit' do
  on_supported_os.each do |os, facts|
    context "on #{os} with defaults for all parameters" do
      it { should compile }
      it { should contain_class('cgit::install') }
    end
  end
end
