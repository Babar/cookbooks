#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2008, OpsCode
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

case node[:platform]
when "Debian", "Ubuntu"
  package "git-core"
else 
  package "git"
end

package "gitk"
package "git-svn"
package "git-email"