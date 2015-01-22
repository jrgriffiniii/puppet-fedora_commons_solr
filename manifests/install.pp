# Class: fedora_commons_solr::install
#
# Class for the installation of Apache Solr 4.x (deployed for integrated with Fedora Generic Search)
#
# == Variables
#
# Inherited from fedora_commons_solr
#
# == Usage
#
# Do not use directly
#
class fedora_commons_solr::install inherits fedora_commons_solr {

  exec { 'download_solr':

    command => "/usr/bin/wget ${fedora_commons_solr::download_url} -O /tmp/solr.tgz",
    timeout => 0,
    unless => '/usr/bin/stat /tmp/solr.tgz'
  }

  exec { 'decompress_solr':

    command => '/usr/bin/tar -xf /tmp/solr.tgz -C /tmp',
    unless => "/usr/bin/stat /tmp/${fedora_commons_solr::solr_release}",
    require => Exec['download_solr']
  }

  exec { 'install_solr':

    command => "/bin/cp -r /tmp/${fedora_commons_solr::solr_release}/example/solr ${fedora_commons_solr::install_dir_path}",
    unless => "/usr/bin/stat ${fedora_commons_solr::install_dir_path}",
    require => Exec['decompress_solr']
  }

  exec { 'install_solr_libs':
    
    command => "/bin/cp -r /tmp/${fedora_commons_solr::solr_release}/dist ${fedora_commons_solr::install_lib_path}",
    unless => "/usr/bin/stat ${fedora_commons_solr::install_dir_path}",
    require => Exec['decompress_solr']
  }

  file { "${fedora_commons_solr::servlet_context_dir_path}/solr.xml":

    content => template('fedora_commons_solr/solr-context.xml.erb'),
    require => Exec['install_solr']
  }

  file { "${fedora_commons_solr::install_dir_path}/solr.xml":

    path => '',
    content => template('fedora_commons_solr/solr.xml.erb'),
    require => Exec['install_solr']
  }
  
  file { "${fedora_commons_solr::install_dir_path}/${fedora_commons_solr::fedora_core_name}":

    ensure => 'directory',
    owner  => 'tomcat',
    group  => 'tomcat',
    require => Exec['install_solr']
  }

  # Copy the /collection1/conf into fedora/conf

  # Ensure that the servlet engine is installed
  # @todo Refactor
  #
  case $fedora_commons_solr::servlet_engine {

    'jetty': {


      } # @todo Implement for jetty
      
    'resin': {


      } # @todo Implement for resin
      
    'jboss': {


      } # @todo Implement for jboss

    default: { # Default handling; Originally implemented for Apache Tomcat 7

      if !defined(Package[$fedora_commons_solr::servlet_engine_package]) {

        # For Red Hat family distributions, EPEL (and the related Java release) are integrated from external Puppet Modules
        # @todo Abstract for Debian family distributions
        package { $fedora_commons_solr::servlet_engine_package:

          ensure => 'present',
          require => Class['::java', 'epel']
        }

        # Ensure that the Apache Tomcat service is running
        
        if !defined( Service[$fedora_commons_solr::servlet_engine_service] ) {
    
          service { $servlet_engine_package:
    
            ensure => 'running',
            require => Package[$fedora_commons_solr::servlet_engine_package]
          }

          # Insert the firewall rule for the servlet engine
          # Add an iptables rule to permit traffic over the HTTP and HTTPS
          # ensure_resource('firewall', '001 allow http and https access for Apache HTTP Server', {
          firewall { '001 allow http and https access for the Java Servlet Engine':
            
            port   => [8080, 8443],
            proto  => 'tcp',
            action => 'accept',
            require => Service[$fedora_commons_solr::servlet_engine_service]
          }
          
          }
        }
      }
}
  

  # Deploy Solr and restart Tomcat
  exec { 'deploy_solr':

    command => "/bin/cp /tmp/solr/${fedora_commons_solr::solr_release}/dist/${fedora_commons_solr::solr_release}.war ${fedora_commons_solr::servlet_webapps_dir_path}/solr.war",
    unless => "/usr/bin/stat ${fedora_commons_solr::servlet_webapps_dir_path}/solr.war",
    require => [ Service[$fedora_commons_solr::servlet_engine_service], Exec['solr_add_core_fedora'] ]
  }
}
