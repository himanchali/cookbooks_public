#
# Cookbook Name:: app_php
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rs_utils_marker :begin

# == Setup PHP Database Connection
#
# Make sure config dir exists
directory File.join(node[:web_apache][:docroot], "config") do
  recursive true
  owner node[:php][:app_user]
  group node[:php][:app_user]
end

db_adapter = node[:php][:db_adapter]
# runs only on db_adapter selection
if db_adapter == "mysql"
  # Tell MySQL to fill in our connection template
  db_mysql_connect_app File.join(node[:web_apache][:docroot], "config", "db.php") do
    template "db.php.erb"
    cookbook "app_php"
    database node[:php][:db_schema_name]
    owner node[:php][:app_user]
    group node[:php][:app_user]
  end
else
  # Tell PostgreSQL to fill in our connection template
  db_postgres_connect_app File.join(node[:web_apache][:docroot], "config", "db.php") do
    template "db.php.erb"
    cookbook "app_php"
    database node[:php][:db_schema_name]
    owner node[:php][:app_user]
    group node[:php][:app_user]
  end
end

rs_utils_marker :end
