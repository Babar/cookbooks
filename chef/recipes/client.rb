#
# Author:: Joshua Timberman <joshua@opscode.com>
# Author:: Joshua Sierles <joshua@37signals.com>
# Author:: Olivier Raginel <babar@cern.ch>
# Cookbook Name:: chef
# Recipe:: client
#
# Copyright 2008-2010, Opscode, Inc
# Copyright 2009, 37signals
# Copyright 2010, MIT
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

root_group = value_for_platform(
  "openbsd" => { "default" => "wheel" },
  "freebsd" => { "default" => "wheel" },
  "default" => "root"
)

ruby_block "reload_client_config" do
  block do
    Chef::Config.from_file("/etc/chef/client.rb")
  end
  action :nothing
end

group "stomp" do
  gid 171
end

group "chef" do
  gid 172
end

user "stomp" do
  uid 171
  gid "stomp"
  comment "StompServer User"
  home "/var/lib/stompserver"
  password "!!"
end

user "chef" do
  uid 172
  gid "chef"
  comment "Chef user"
  home "/var/lib/chef"
  password "!!"
end

package "chef"

template "/etc/chef/client.rb" do
  source "client.rb.erb"
  owner "root"
  group root_group
  mode "644"
  notifies :create, resources(:ruby_block => "reload_client_config")
end

log "Add the chef::delete_validation recipe to the run list to remove the #{Chef::Config[:validation_key]}." do
  only_if { File.exists?(Chef::Config[:validation_key]) }
end
