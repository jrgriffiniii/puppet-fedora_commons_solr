# == Class: fedora_commons_solr
#
# Class for managing Apache Solr 4.x (integrated with Fedora Generic Search)
#
#
# == Parameters
#
# @todo Draft
#
# == Examples
#
# See README
#
#
# == Author
#   James R. Griffin III <griffinj@lafayette.edu/>
#
class fedora_commons_solr (

  $solr_release = params_lookup( 'solr_release' ),
  $download_url = params_lookup( 'download_url' ),
  $install_dir_path = params_lookup( 'install_dir_path' ),

  $servlet_engine = params_lookup( 'servlet_engine' ),
  $servlet_webapps_dir_path = params_lookup( 'servlet_webapps_dir_path' ),
  $servlet_context_dir_path = params_lookup( 'servlet_context_dir_path' ),
  $servlet_host = params_lookup( 'servlet_host' ),
  $servlet_port = params_lookup( 'servlet_port' ),

  $fedora_core_name = params_lookup( 'fedora_core_name' )

  ) inherits fedora_commons_solr::params {

    # @todo Implement support for Jetty

    # Install the service
    require 'fedora_commons_solr::install'
  }
