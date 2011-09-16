case platform 
when "ubuntu","debian"
  default[:ntp][:service] = "ntp"
when "redhat","centos","fedora","scientific"
  default[:ntp][:service] = "ntpd"
end

default[:ntp][:is_server] = false
default[:ntp][:servers] = ["ip-time-1.cern.ch", "ip-time-2.cern.ch", "ip-time-3.cern.ch", "ip-time-4.cern.ch", "0.pool.ntp.org", "1.pool.ntp.org", "2.pool.ntp.org"]
