UTLAPPS_maven_init(){
   alias maven-env="UTLAPPS_maven_env"
   alias maven-proxy="UTLAPPS_maven_proxy"
}

UTLAPPS_maven_checkpom(){
  for fname in `find . -path "*/pom.xml" ` ;  do {
    echo "-----${fname}";
    git log --date=local --abbrev-commit --oneline --since='Mar 2 13:13:30 2017' \
      --pretty=format:'|---%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd, %an)%Creset' ${fname}
  } done
}

UTLAPPS_maven_env(){
   export MAVEN_DIR="${HOME}/.m2"
   export MAVEN_ROOT="${UTL3RDP_DEV}/maven"

   export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=512m"
   export MAVEN_HOME="${MAVEN_ROOT}/apache-maven-3.5.0"
   
   export PATH=${MAVEN_HOME}/bin:${PATH}

}

UTLAPPS_maven_proxy(){
   mkdir -p ${MAVEN_DIR}
   cat > ${MAVEN_DIR}/settings.xml << E_O_F
<settings>
  <localRepository>${MAVEN_REP}</localRepository>
  <proxies>
   <proxy>
      <active>true</active>
      <protocol>http</protocol>
      <port>${UTL_PROXY_HTTP_PORT}</port>
      <host>${UTL_PROXY_HTTP_HOST}</host>
    </proxy>
  </proxies>
</settings>
E_O_F
}
