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

  $fedora_commons_solr::solr_release = params_lookup( 'solr_release' ),
  $fedora_commons_solr::download_url = params_lookup( 'download_url' ),
  $fedora_commons_solr::install_dir_path = params_lookup( 'install_dir_path' ),

  $fedora_commons_solr::servlet_engine = params_lookup( 'servlet_engine' ),
  $fedora_commons_solr::servlet_webapps_dir_path = params_lookup( 'servlet_webapps_dir_path' ),
  $fedora_commons_solr::servlet_context_dir_path = params_lookup( 'servlet_context_dir_path' ),
  $fedora_commons_solr::servlet_host = params_lookup( 'servlet_host' ),
  $fedora_commons_solr::servlet_port = params_lookup( 'servlet_port' ),

  $fedora_commons_solr::fedora_core_name = params_lookup( 'fedora_core_name' )

  ) inherits fedora_commons_solr::params {

    # @todo Implement support for Jetty

    # Install the service
    require 'fedora_commons_solr::install'
  }
