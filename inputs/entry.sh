#!/bin/sh

rsyslogd -f /etc/rsyslog/rsyslog.conf
touch /etc/dhcp/dhcpd.leases
dhcpd -lf /etc/dhcp/dhcpd.leases -user pcs-dhcp -group pcs-dhcp eth0
tail -f /dev/null