# == Class: fedora_commons::solr
#
# This is the class for solr
#
#
# == Parameters
#
# Standard class parameters - Define solr web app specific settings
#
# [*install*]
#   Kind of installation to attempt:
#     - package : Installs solr using the OS common packages
#     - source  : Installs solr downloading and extracting a specific tarball or zip file
#     - puppi   : Installs solr tarball or file via Puppi, creating the "puppi deploy solr" command
#
# [*install_source*]
#   The URL from where to retrieve the source tarball/zip. Used if install => "source" or "puppi"
#   Default is from upstream developer site. Update the version when needed.
#
#
#
# == Examples
#
# See README
#
#
# == Author
#   James R. Griffin III <griffinj@lafayette.edu/>
#
class fedora_commons::solr (

  $war_path = params_lookup( 'war_path' ),

  
  ) inherits fedora_commons::solr::params {

  # Work-around
  # @todo Override catalina_home for the ::tomcat Class
  $catalina_home = '/var/lib/tomcat'

  $install_destination = '/opt/solr/solr-4.2.0/dist/solr-4.2.0.war' # @todo Resolve this issue
  $deployment_path = '/var/lib/tomcat/webapps'

  $war_path = '/opt/solr/solr-4.2.0/dist/solr-4.2.0.war' # @todo Resolve this issue
  $install_dir_path = '/usr/share/solr'

  $host = 'localhost'
  $port = '8080'

  # Islandora/Fedora Generic Search is documented as supporting Solr 4.2.0
  # For Solr 4.2.0
#  class { "::solr":

#    install_source => 'http://archive.apache.org/dist/lucene/solr/4.2.0/solr-4.2.0.tgz',
#    require => Tomcat::Instance['default']
#  }


}
