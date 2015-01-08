# Class: solr::install
#
# This class installs solr
#
# == Variables
#
# Refer to solr class for the variables defined here.
#
# == Usage
#
# Do not use directly
#
class fedora_commons::solr::install inherits fedora_commons::solr {

  $fedora_commons::solr::download_url
  $fedora_commons::solr::install_dir_path
  $fedora_commons::solr::servlet_context_dir_path
  $fedora_commons::solr::fedora_core_name

  $fedora_commons::solr::solr_release

  exec { 'download_solr':

    command => "/usr/bin/wget ${fedora_commons::solr::download_url} -O /tmp/solr.tgz",
    unless => '/usr/bin/stat /tmp/solr.tgz'
  }

  exec { 'decompress_solr':

    command => "/usr/bin/tar -xf /tmp/solr.tgz -C /tmp",
    unless => "/usr/bin/stat /tmp/${fedora_commons::solr::solr_release}",
    require => Exec['download_solr']
  }

  exec { 'install_solr':

    command => "/bin/cp -r /tmp/${fedora_commons::solr::solr_release}/example/solr ${fedora_commons::solr::install_dir_path}",
    unless => "/usr/bin/stat ${fedora_commons::solr::install_dir_path}",
    require => Exec['decompress_solr']
  }

  file { "${fedora_commons::solr::servlet_context_dir_path}/solr.xml":

    content => template('solr-fedora-commons/solr-context.xml.erb'),
    require => Exec['install_solr']
  }

  file { "${fedora_commons::solr::install_dir_path}/solr.xml":

    path => '',
    content => template('solr-fedora-commons/solr.xml.erb'),
    require => Exec['install_solr']
  }

  file { "${fedora_commons::solr::install_dir_path}/${fedora_commons::solr::fedora_core_name}":

    ensure => "directory",
    owner  => "tomcat",
    group  => "tomcat",
    require => Exec['install_solr']
  }

  # Copy the /collection1/conf into fedora/conf
  

  # Deploy Solr and restart Tomcat
  exec { 'deploy_solr':

    command => "/bin/cp /tmp/solr/${fedora_commons::solr::solr_release}/dist/${fedora_commons::solr::solr_release}.war ${fedora_commons::solr::servlet_webapps_dir_path}/solr.war",
    unless => "/usr/bin/stat ${fedora_commons::solr::servlet_webapps_dir_path}/solr.war",
    require => Exec['solr_add_core_fedora']
  }
}
