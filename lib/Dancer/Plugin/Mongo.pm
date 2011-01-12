# ABSTRACT: MongoDB plugin for the Dancer micro framework
package Dancer::Plugin::Mongo;

use strict;
use warnings;
use Dancer::Plugin;
use MongoDB 0.38;

my $settings = plugin_setting;
my $conn;

## return a connected MongoDB object
register mongo => sub {

    $conn ? $conn : $conn = MongoDB::Connection->new( _slurp_settings() ) ;

    return $conn;
};

register_plugin;

sub _slurp_settings {
    
    my $args;
    for (qw/ host port username password w wtimeout auto_reconnect auto_connect
        timeout db_name query_timeout find_master/) {
        if (exists $settings->{$_}) {
            $args->{$_} = $settings->{$_};
        }
    }

    return $args;
}

=head1 SYNOPSIS

    use Dancer;
    use Dancer::Plugin::Mongo;

    get '/widget/view/:id' => sub {
        my $widget = mongo->database->collection->find_one({ id => params->{id} });
    }

=head1 DESCRIPTION

Dancer::Plugin::Mongo provides a wrapper around L<MongoDB>. Add the appropriate
configuraton options to your config.yml and then you can access a MongoDB database
using the 'mongo' keyword.

To query the database, use the standard MongoDB syntax, described in
L<MongoDB::Collection>.

=head1 CONFIGURATON

Connection details will be taken from your Dancer application config file, and
should be specified as follows:

    plugins:
        Mongo:
            host:
            port:
            username:
            password:
            w:
            wtimeout:
            auto_reconnect:
            auto_connect:
            timeout:
            db_name:
            query_timeout:
            find_master:

All these configuration values are optional, full details are in the
L<MongoDB::Connection> documentation.

=cut

1;
