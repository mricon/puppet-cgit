require 'spec_helper'
describe 'cgit' do
  on_supported_os.each do |os, facts|
    context "on #{os} with defaults for all parameters" do
      it { should compile }
      it { should contain_class('cgit') }
      it { should contain_package('cgit') }
      it { should contain_file('/etc/cgitrc')
           .with_content(/root-title=Git Repository Browser/)
           .with_content(/cache-root=\/var\/cache\/cgit/)
      }
      it { should contain_file('/var/cache/cgit')
           .with(
             'owner' => 'apache',
             'group' => 'root',
             'mode'  => '0755',
           )
      }
    end
    context "on #{os} with virtual sites and different owners" do
      let(:params) {{
        :use_virtual_sites => true,
        :cachedir_owner => 'nginx',
        :cachedir_group => 'apache',
        :cachedir_mode  => '0750',
        :sites => { 'example.com' =>
                    {
                      'ensure' => 'present',
                      'skindir_src' => 'puppet:///modules/cgit/skins/example',
                    }
        }
      }}
      it { should compile }
      it { should contain_file('/etc/cgitrc.d') }
      it { should contain_file('/var/www/html/cgit') }
      it { should contain_file('/var/www/html/cgit/example.com') }
      it { should contain_file('/etc/cgitrc')
           .with_content(/include=\/etc\/cgitrc\.d\/\$HTTP_HOST/)
      }
      it { should contain_file('/etc/cgitrc.d/example.com')
           .with_content(/root-title=Git Repository Browser/)
           .with_content(/cache-root=\/var\/cache\/cgit\/example\.com/)
      }
      it { should contain_file('/var/cache/cgit/example.com')
           .with(
             'owner' => 'nginx',
             'group' => 'apache',
             'mode'  => '0750',
           )
      }
    end
  end
end
