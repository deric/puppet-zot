# frozen_string_literal: true

require 'spec_helper_acceptance'
require 'pry'

describe 'zot' do
  context 'basic setup' do
    it 'install zot' do
      pp = <<~EOS
        class { 'zot': }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe file('/etc/zot') do
      it { is_expected.to be_directory }
      it { is_expected.to be_readable.by('owner') }
      it { is_expected.to be_readable.by('group') }
    end

    describe service('zot') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe command('zot verify /etc/zot/config.json') do
      its(:stdout) { is_expected.to match 'Config file is valid' }
    end
  end
end
