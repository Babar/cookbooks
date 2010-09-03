# Ensure chef knows the scientific platform

service "chef-client" do
  supports :status => true, :restart => true, :reload => false
  enabled true
  running true
end

cookbook_file "/etc/selinux/targeted/modules/active/modules/chef.pp" do
  mode "0600"
  owner "root"
  group "root"
  not_if do File.exists?("/etc/selinux/targeted/modules/active/modules/chef.pp") end
  notifies :reload, resources(:service => "chef-client"), :immediately
end

cookbook_file "/usr/lib/ruby/gems/1.8/gems/chef-0.9.8/lib/chef/platform.rb" do
  owner "root"
  group "root"
  mode "0644"
  not_if "grep -q scientific /usr/lib/ruby/gems/1.8/gems/chef-0.9.8/lib/chef/platform.rb"
end
