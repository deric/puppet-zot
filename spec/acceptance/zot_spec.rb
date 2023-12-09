# frozen_string_literal: true

require 'spec_helper_acceptance'
require 'pry'

describe 'zot' do
  context 'basic setup' do
    it 'install zot' do
      pp = <<~EOS
        class { 'zot':
          version => '2.0.0-rc7',
        }
      EOS

      # first run seems to exit with code 6 (systemd reload)
      apply_manifest(pp, catch_failures: false)
      apply_manifest(pp, catch_changes: true)
    end

    describe file('/etc/zot') do
      it { is_expected.to be_directory }
      it { is_expected.to be_readable.by('owner') }
      it { is_expected.to be_readable.by('group') }
    end

    describe file('/etc/zot/config.json') do
      it { is_expected.to be_file }
      it { is_expected.to be_readable.by('owner') }
      it { is_expected.to be_readable.by('group') }
    end

    describe service('zot') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe command('zot verify /etc/zot/config.json') do
      its(:stderr) { is_expected.to match(%r{Config file is valid}) }
    end
  end
end
