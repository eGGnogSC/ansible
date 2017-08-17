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
# Neutron Openvswitch Agent
<source>
  @type tail
  path /var/log/neutron/openvswitch-agent.log
  tag neutron.openvswitch
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match neutron.openvswitch>
  type add
  <pair>
    service neutron.openvswitch
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Neutron Server
<source>
  @type tail
  path /var/log/neutron/server.log
  tag neutron.server
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match neutron.server>
  type add
  <pair>
    service neutron.server
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Neutron DHCP Agent
<source>
  @type tail
  path /var/log/neutron/dhcp-agent.log
  tag neutron.dhcp
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match neutron.dhcp>
  type add
  <pair>
    service neutron.dhcp
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Neutron L3 Agent
<source>
  @type tail
  path /var/log/neutron/l3-agent.log
  tag neutron.l3
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match neutron.l3>
  type add
  <pair>
    service neutron.l3
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Neutron Metadata Agent
<source>
  @type tail
  path /var/log/neutron/metadata-agent.log
  tag neutron.metadata
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match neutron.metadata>
  type add
  <pair>
    service neutron.metadata
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Keystone
<source>
  @type tail
  path /var/log/keystone/keystone.log
  tag keystone
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match keystone>
  type add
  <pair>
    service keystone
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Glance API
<source>
  @type tail
  path /var/log/glance/api.log
  tag glance.api
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match glance.api>
  type add
  <pair>
    service glance.api
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Glance Registry
<source>
  @type tail
  path /var/log/glance/registry.log
  tag glance.registry
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match glance.registry>
  type add
  <pair>
    service glance.registry
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Cinder API
<source>
  @type tail
  path /var/log/cinder/api.log
  tag cinder.api
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match cinder.api>
  type add
  <pair>
    service cinder.api
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Cinder Scheduler
<source>
  @type tail
  path /var/log/cinder/scheduler.log
  tag cinder.scheduler
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match cinder.scheduler>
  type add
  <pair>
    service cinder.scheduler
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Cinder Volume
<source>
  @type tail
  path /var/log/cinder/volume.log
  tag cinder.volume
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match cinder.volume>
  type add
  <pair>
    service cinder.volume
    hostname "#{Socket.gethostname}"
  </pair>
</match>
<match greped.**>
  @type forward
  heartbeat_type tcp
  <server>
    name <server URL here> 
    host <server URL here>
    port 4000
  </server>
</match>
# Heat API
<source>
  @type tail
  path /var/log/heat/heat-api.log
  tag heat.api
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match heat.api>
  type add
  <pair>
    service heat.api
    hostname "#{Socket.gethostname}"
  </pair>
</match>
# Heat Engine Log
<source>
  @type tail
  path /var/log/heat/heat-engine.log
  tag heat.engine
  format multiline
  format_firstline /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  format /(?<time>[^ ]* [^ ]*) (?<pid>[^ ]*) (?<loglevel>[^ ]*) (?<class>[^ ]*) \[(?<context>[^\]]*)\] (?<message>.*)/
  time_format %F %T.%L
</source>
<match heat.engine>
  type add
  <pair>
    service heat.engine
    hostname "#{Socket.gethostname}"
  </pair>
</match>
EOF

#configure the fluent user on all nodes so it has permissions to read all the Openstack log files
echo "you may get an error on some nodes about missing groups. This is ok as not all nodes run all services."
for user in {keystone,heat,nova,neutron,cinder,glance}; do  /usr/sbin/usermod -a -G $user fluentd; done

#Fix Perms (RedHat)
chown -R heat: /var/log/heat
chown -R ceilometer: /var/log/ceilometer
chown -R cinder: /var/log/cinder
chown -R glance: /var/log/glance
chown -R keystone: /var/log/keystone
chown -R manila: /var/log/manila
chown -R mongodb: /var/log/mongodb
chown -R neutron:/var/log/neutron
chown -R nova: /var/log/nova

#Start and Enable Fluentd
systemctl start fluentd
systemctl enable fluentd

exit
