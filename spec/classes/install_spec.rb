require 'spec_helper'

describe 'fedora_commons_solr::install' do

  context 'on CentOS 6.4' do

    let :facts do
      {
        :osfamily => 'RedHat',
        :operatingsystem => 'CentOS',
        :operatingsystemrelease => '6.4',
        :concat_basedir => '/var/lib/puppet'
      }
    end

    # @todo Resolve
#    it { should compile }
#    it { should compile.with_all_deps }

    it do

      should contain_package('tomcat')
        .with_ensure('present')
    end

    it do

      should contain_service('tomcat')
        .with_ensure('running')
    end

    it do

      should contain_exec('deploy_solr')
        .that_requires("Service[tomcat]")
    end
  end
end
