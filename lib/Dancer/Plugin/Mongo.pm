package Dancer::Plugin::Mongo;

use strict;
use warnings;
use Dancer::Plugin;
use MongoDB '0.38';

my $settings = plugin_setting;
my $conn;

## return a connected MongoDB object
register mongo => sub {
    
    $conn ? $conn : $conn =  MongoDB::Connection->new({ _slurp_settings() });

    return $conn;
    
};

register_plugin;

sub _slurp_settings {
    
    my @args;
    for (qw/ host port username password w wtimeout auto_reconnect auto_connect
	timeout db_name query_timeout find_master/) {
	if (exists $settings->{$_}) {
	    push (@args, $_ . '=>' . $settings->{$_});
	}
    }

    my $arg_string = join(',', @args) if @args;
    
    return $arg_string;
}

=head1 SYNOPSIS
    
    use Dancer;
    use Dancer::Plugin::Mongo;

    get '/widget/view/:id' => sub {
	my $widget = mongo->database->widgets->find({ id => params->{id} });
    }

=head1 CONFIGURATON

Plugins:
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

All these configuration values are optional, full details are on the 
Mongo::Connection page.

=cut

1;
