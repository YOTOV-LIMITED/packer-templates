describe 'memcached installation' do
  describe package('memcached') do
    it { should be_installed }
  end

  describe command('memcached -h') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match(/^memcached \d/) }
  end

  describe 'memcached commands', sudo: true do
    before :all do
      sh('sudo service memcached start')
      sleep 5
    end

    describe service('memcached') do
      it { should be_running }
    end

    describe command('echo \'stats\' | nc 127.0.0.1 11211') do
      its(:stdout) { should match 'version' }
    end
  end
end
