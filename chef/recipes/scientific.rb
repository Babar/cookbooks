# Ensure chef knows the scientific platform

cookbook_file "/usr/lib/ruby/gems/1.8/gems/chef-0.9.8/lib/chef/platform.rb" do
  user "root"
  group "root"
  mode "0644"
  not_if "grep -q scientific /usr/lib/ruby/gems/1.8/gems/chef-0.9.8/lib/chef/platform.rb"
end
