#/bin/bash

UTLAPPS_ttale_init(){
   export JBOSSTATTLETALE_HOME="${UTL3RDP_APPS}/jboss/tattletale-1.2.0.Beta2"
   alias ttale-cpbapi="UTLAPPS_ttale_cpbapi"
}

UTLAPPS_ttale_cpbapi(){
   UTLAPPS_ttale_showdep ../cpbapi13/lib
}

UTLAPPS_ttale_showdep(){
   #local jarFile="${1}"
   #local pkgList="${2}"
   
   local inputDir="${1}"
   local outputDir="./build/report"
   
   if [ -e  ${outputDir}  ] ; then
      rm -rf ${outputDir}/*
   else
      mkdir -p ${outputDir}/
   fi

   local filterFile="./build/filter.properties"
cat <<E_O_F> ${filterFile}
dependson
transitivedependson
circulardependency
#archive=[class|package](,[class|package])*;
E_O_F

   local reportFile="./build/report.properties"
cat <<E_O_F> ${reportFile}
excludes=**/lb*.jar,**/*tn_*jar
reports=dependson,transitivedependson,circulardependency
E_O_F
   
   java -Xmx1024m \
      -Djboss-tattletale.properties=${reportFile} \
      -Djboss-tattletale-filter.properties=${filterFile} \
      -jar ${JBOSSTATTLETALE_HOME}/tattletale.jar ${inputDir} ${outputDir}
}


