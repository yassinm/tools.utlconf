#/bin/bash

UTLAPPS_neo4j_init(){
   alias neo4j-3-0="UTLAPPS_neo4j_3_0"
   alias neo4j-alias='alias | grep neo4j'
}

UTLAPPS_neo4j_3_0(){
    NEO4J_VERSION="community-3.0.1"
    NEO4J_HOME="${UTL3RDP_APPS}/neo4j/neo4j-${NEO4J_VERSION}"
    export PATH=${NEO4J_HOME}/bin:${PATH}
}


UTLAPPS_neo4j_conf(){

    #neo4j-server.conf
    org.neo4j.server.webserver.address=0.0.0.0

    #neo4j-wrapper.conf
    wrapper.java.additional=-Dneo4j.ext.udc.source=tarball
    wrapper.java.additional=-Djava.net.preferIPv4Stack=true

    #bolt ... not working (((
    metrics.bolt.messages.enabled=true
    dbms.connector.boltlocal.type=bolt
    dbms.connector.boltlocal.enabled=true
    dbms.connector.boltlocal.tls_level=DISABLED
    dbms.connector.boltlocal.address=0.0.0.0:7688

}

UTLAPPS_neo4j_tuning(){

    #/etc/security/limits.conf
    neo4j   soft    nofile  40000
    neo4j   hard    nofile  40000

    #/etc/pam.d/su
    session    required   pam_limits.so

    #/conf/neo4j-server.properties
    org.neo4j.server.webserver.maxthreads=4

    #neo4j-wrapper.conf
    wrapper.java.additional=-XX:+UseG1GC
    wrapper.java.additional=-server
    wrapper.java.additional=-XX:+AggressiveOpts
    wrapper.java.additional=-Xms512m
    wrapper.java.additional=-Xmx2048m
    wrapper.java.additional=-XX:+UseParallelGC

    tmpfs /mnt/data1 tmpfs defaults,noatime,nosuid,nodev,noexec,mode=1777,size=2G 0 0

}
