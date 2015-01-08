# Class: solr::params
#
# This class defines default parameters used by the main module class solr
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to solr class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class fedora_commons_solr::params {

  $solr_release = 'solr-4.2.0'
  $download_url = 'http://archive.apache.org/dist/lucene/solr/4.2.0/solr-4.2.0.tgz'
  $install_dir_path = '/usr/share/solr'
  $install_lib_path = '/usr/share/java/solr'

  $servlet_engine = 'tomcat'
  $servlet_webapps_dir_path = '/var/lib/tomcat/webapps'
  $servlet_context_dir_path = '/etc/tomcat/Catalina/localhost'
  $servlet_config_path = '/etc/tomcat/tomcat.conf'
  $servlet_host = 'localhost'
  $servlet_port = '8080'

  $fedora_core_name = 'fedora'
}
