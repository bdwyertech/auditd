# Encoding: utf-8
# Cookbook Name:: auditd
# Provider:: auditd_ruleset
#
# Copyright 2012, Heavy Water Operations, LLC.
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

# provider for installing audit rules from a template
action :create do
  rulefile = '/etc/audit/audit.rules'
  rulefile = '/etc/audit/rules.d/audit.rules' if platform_family?('rhel') && node['platform_version'].to_i == 7
  template rulefile do
    source "#{new_resource.name}.erb"
    notifies :restart, resources(service: 'auditd')
  end
end
