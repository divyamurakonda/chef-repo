#
# Cookbook Name:: ark
# Attributes:: default
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['ark']['apache_mirror'] = 'http://apache.mirrors.tds.net'
default['ark']['prefix_root'] = '/usr/local'
default['ark']['prefix_bin'] = '/usr/local/bin'
default['ark']['prefix_home'] = '/usr/local'
default['ark']['tar'] = case node['platform_family']
                        when 'windows'
                          "\"#{::Win32::Registry::HKEY_LOCAL_MACHINE.open(
                            'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\7zFM.exe', ::Win32::Registry::KEY_READ).read_s('Path')}\\7z.exe\""
                        when 'mac_os_x', 'freebsd'
                          '/usr/bin/tar'
                        when 'smartos'
                          '/bin/gtar'
                        else
                          '/bin/tar'
                        end

pkgs = %w(libtool autoconf) unless platform_family?('mac_os_x')
pkgs += %w(make) unless platform_family?('mac_os_x', 'freebsd')
pkgs += %w(unzip rsync gcc) unless platform_family?('mac_os_x')
pkgs += %w(autogen) unless platform_family?('rhel', 'fedora', 'mac_os_x', 'suse')
pkgs += %w(gtar) if platform?('freebsd') || platform?('smartos')
pkgs += %w(gmake) if platform?('freebsd')
if platform_family?('rhel', 'suse')
  if node['platform_version'].to_i >= 7
    pkgs += %w(xz bzip2 tar)
  elsif node['platform_version'].to_i < 7
    pkgs += %w(xz-lzma-compat bzip2 tar)
  end
elsif platform_family?('fedora')
  pkgs += %w(xz-lzma-compat bzip2 tar)
end
pkgs += %w(shtool pkg-config) if platform_family?('debian')

default['ark']['package_dependencies'] = pkgs
