#
# Cookbook Name:: kamailio
# Recipe:: default
#
# Copyright 2013, Lee Azzarello <lee@guardianproject.info>
#
# GPLv3
#

# Add Kamailio package source to the system's database
execute "apt-get-update" do
  command "apt-get update"
  action :nothing
end

template "/etc/apt/sources.list.d/kamailio.list" do
  source "kamailio.list.erb"
  creates "/etc/apt/sources.list.d/kamailio.list"
  notifies :run, "execute[apt-get-update]", :immediately
end

# install kamailio and friends

package "kamailio"
package "kamailio-tls-modules" #essential
package "kamailio-utils-modules" # some non-SIP related utility functions
package "kamailio-presence-modules" # might as well support SIP presence
package "kamailio-xmpp-modules" # support an XMPP gateway
package "rtpproxy" # default configuration is fine

# there are two configuration files required for kam
