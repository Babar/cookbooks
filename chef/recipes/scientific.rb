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

# Ensure RBEL repository is there, and nothing else
package "elff-release-5.3" do
  action :purge
end

bash "install_rbel" do
  user "root"
  cwd "/"
  code "rpm -Uvh http://rbel.co/rbel5"
  not_if do File.exist?("/etc/yum.repos.d/rbel5.repo") end
end
