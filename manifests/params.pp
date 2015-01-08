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

  $fedora_commons_solr::solr_release = 'solr-4.2.0'
  $fedora_commons_solr::download_url = 'http://archive.apache.org/dist/lucene/solr/4.2.0/solr-4.2.0.tgz'
  $fedora_commons_solr::install_dir_path = '/usr/share/solr'

  $fedora_commons_solr::servlet_engine = 'tomcat'
  $fedora_commons_solr::servlet_webapps_dir_path = '/var/lib/tomcat/webapps'
  $fedora_commons_solr::servlet_context_dir_path = '/etc/tomcat/Catalina/localhost'
  $fedora_commons_solr::servlet_host = 'localhost'
  $fedora_commons_solr::servlet_port = '8080'

  $fedora_commons_solr::fedora_core_name = 'fedora'
}
