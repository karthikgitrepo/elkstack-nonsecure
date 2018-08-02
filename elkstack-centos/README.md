# elkstack-centos
Ansible playbook for Elkstack (Elasticsearch, Logstash, Kibana) - CentOS/RH 6.x / CentOS/RH 7.x
>Logstash configuration created for Shibboleth IdP v3 audit logging

Includes:
- Elasticsearch 2.x
- Logstash 2.0
- Kibana 4.2.0
- Nginx 1.8.0
- OpenJDK 1.8.0

### Usage
Modify hosts-file --> Replace localhost with proper server name. Alter user & port if necessary.
````
[servers]
localhost ansible_ssh_user=vagrant ansible_ssh_port=2222
````
Run runansible.sh
```
[korteke@server ~]$ sh runansible.sh site
```

Tested with CentOS 6.4 / 7

### Shibboleth IdP v3 logging configuration

Add these blocks to $IDP_HOME/conf/logback.conf
```
<!-- Syslog appender -->
	<appender name="IDP_SYSLOG" class="ch.qos.logback.classic.net.SyslogAppender">
	   <SyslogHost>SERVER_NAME/IP-ADDRESS</SyslogHost>
	   <Port>5000</Port>
	   <Facility>AUDIT</Facility>
	   <SuffixPattern>[%logger:%line] %msg|%mdc{idp.jsessionid}</SuffixPattern>
	</appender>
```

```
    <logger name="net.shibboleth.idp.authn.impl.ValidateUsernamePasswordAgainstLDAP" level="INFO" additivity="false">
	<appender-ref ref="IDP_PROCESS" />
        <appender-ref ref="IDP_SYSLOG"/>
    </logger>
```

Add IDP_SYSLOG to root logger
```
    <root level="INFO">
        <appender-ref ref="IDP_PROCESS"/>
        <appender-ref ref="IDP_SYSLOG"/>
        <appender-ref ref="IDP_WARN" />
    </root>
```

### Testing
Nginx is proxying root to Kibana (http://server_name/)
user: kibana
passwd: kibana
