# frozen_string_literal: true

require 'spec_helper'

describe 'zot' do
  _, os_facts = on_supported_os.first
  let(:facts) { os_facts }

  context 'with default parameters' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('zot') }
    it { is_expected.to contain_class('zot::config') }
    it { is_expected.to contain_class('zot::install') }
    it { is_expected.to contain_class('zot::service') }

    it { is_expected.to contain_archive('/usr/bin/zot') }
    it { is_expected.to contain_file('/etc/zot').with_ensure('directory') }
    it { is_expected.to contain_file('/var/lib/zot').with_ensure('directory') }
    it { is_expected.to contain_file('/var/log/zot').with_ensure('directory') }
    it { is_expected.to contain_service('zot').with_ensure('running') }
    it { is_expected.to contain_user('zot').with_ensure('present') }
    it { is_expected.to contain_group('zot').with_ensure('present') }
  end
end
