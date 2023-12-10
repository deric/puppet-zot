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

    it {
      is_expected.to contain_archive('/usr/bin/zot-1.4.3')
        .with(source: 'https://github.com/project-zot/zot/releases/download/v1.4.3/zot-linux-amd64')
    }
    it { is_expected.to contain_file('/usr/bin/zot').with_ensure('link').with(target: '/usr/bin/zot-1.4.3') }
    it {
      is_expected.to contain_archive('/usr/bin/zli-1.4.3')
        .with(source: 'https://github.com/project-zot/zot/releases/download/v1.4.3/zli-linux-amd64')
    }
    it { is_expected.to contain_file('/usr/bin/zli').with_ensure('link').with(target: '/usr/bin/zli-1.4.3') }
    it { is_expected.to contain_file('/etc/zot').with_ensure('directory') }
    it { is_expected.to contain_file('/var/lib/zot').with_ensure('directory') }
    it { is_expected.to contain_file('/var/log/zot').with_ensure('directory') }
    it {
      is_expected.to contain_service('zot')
        .with_ensure('running')
        .that_subscribes_to('File[/etc/zot/config.json]')
        .that_subscribes_to('File[/usr/bin/zot]')
    }
    it { is_expected.to contain_user('zot').with_ensure('present') }
    it { is_expected.to contain_group('zot').with_ensure('present') }
    it {
      is_expected.to contain_file('/etc/zot/config.json').with_ensure('file')
                                                         .with_content(%r{"distSpecVersion":\s+"1.0.1"})
                                                         .with_content(%r{"rootDirectory":\s+"/var/lib/zot"})
    }
    it { is_expected.to contain_systemd__unit_file('zot.service').with_ensure('present') }
  end

  context 'with custom service name' do
    let(:params) do
      {
        service_name: 'registry',
      }
    end

    it { is_expected.to contain_service('registry').with_ensure('running').that_subscribes_to('File[/etc/zot/config.json]') }
    it { is_expected.to contain_systemd__unit_file('registry.service').with_ensure('present') }
  end

  context 'without managed service' do
    let(:params) do
      {
        manage_service: false,
      }
    end

    it { is_expected.not_to contain_service('registry') }
    it { is_expected.not_to contain_systemd__unit_file('registry.service') }
  end

  context 'with custom user and uid' do
    let(:params) do
      {
        user: 'registry',
        group: 'www-data',
        uid: 1002,
        gid: 500,
      }
    end

    it { is_expected.to contain_user('registry').with_ensure('present').with(uid: 1002) }
    it { is_expected.to contain_group('www-data').with_ensure('present').with(gid: 500) }
  end

  context 'without zli' do
    let(:params) do
      {
        version: '1.4.3',
        manage_zli: false,
      }
    end

    it { is_expected.not_to contain_archive('/usr/bin/zli-1.4.3') }
    it { is_expected.not_to contain_file('/usr/bin/zli') }
  end

  context 'without managed config' do
    let(:params) do
      {
        manage_config: false,
      }
    end

    it { is_expected.not_to contain_file('/etc/zot/config.json').with_ensure('file') }
  end

  context 'with arch=arm64' do
    let(:params) do
      {
        version: '1.4.3',
        arch: 'arm64',
      }
    end

    it {
      is_expected.to contain_archive('/usr/bin/zot-1.4.3')
        .with(source: 'https://github.com/project-zot/zot/releases/download/v1.4.3/zot-linux-arm64')
    }
    it { is_expected.to contain_file('/usr/bin/zot').with_ensure('link').with(target: '/usr/bin/zot-1.4.3') }
    it {
      is_expected.to contain_archive('/usr/bin/zli-1.4.3')
        .with(source: 'https://github.com/project-zot/zot/releases/download/v1.4.3/zli-linux-arm64')
    }
  end
end
