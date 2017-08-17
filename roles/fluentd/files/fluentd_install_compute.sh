#!/bin/bash
#### EDIT LINES 300-301 to match the FQDN of the Kibana server!

tar -xf /home/heat-admin/fluentd_bundle.tar.gz
yum -y localinstall /home/heat-admin/fluentd_bundle/*

cat << EOF >/etc/fluentd/fluent.conf
# In v1 configuration, type and id are @ prefix parameters.
# @type and @id are recommended. type and id are still available for backward compatibility
# Nova compute
<source>
  @type tail
  path /var/log/nova/nova-compute.log
  tag nova.compute
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match nova.compute>
  type add
  <pair>
    service nova.compute
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Nova API
<source>
  @type tail
  path /var/log/nova/nova-api.log
  tag nova.api
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match nova.api>
  type add
  <pair>
    service nova.api
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Nova Cert
<source>
  @type tail
  path /var/log/nova/nova-cert.log
  tag nova.cert
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match nova.cert>
  type add
  <pair>
    service nova.cert
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Nova Conductor
<source>
  @type tail
  path /var/log/nova/nova-conductor.log
  tag nova.conductor
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match nova.conductor>
  type add
  <pair>
    service nova.conductor
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Nova Consoleauth
<source>
  @type tail
  path /var/log/nova/nova-consoleauth.log
  tag nova.consoleauth
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match nova.consoleauth>
  type add
  <pair>
    service nova.consoleauth
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Nova Scheduler
<source>
  @type tail
  path /var/log/nova/nova-scheduler.log
  tag nova.scheduler
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match nova.scheduler>
  type add
  <pair>
    service nova.scheduler
    hostname "#{Socket.gethostname}"
  </pair>
</match>
<match greped.**>
  @type forward
  heartbeat_type tcp
  <server>
    name <server URL here> 
    host <server url here> 
    port 4000
  </server>
</match>
EOF

#configure the fluent user on all nodes so it has permissions to read all the Openstack log files
echo "you may get an error on some nodes about missing groups. This is ok as not all nodes run all services."
/usr/sbin/usermod -a -G nova fluentd

#Fix Perms (RedHat)
chown -R nova: /var/log/nova

#Start and Enable Fluentd
systemctl start fluentd
systemctl enable fluentd

exit
