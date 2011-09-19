# Ensure SElinux permissions are OK
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
  notifies :restart, resources(:service => "chef-client")
end
