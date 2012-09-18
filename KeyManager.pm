#-*-perl-*-

package CustomAccount::KeyManager;

use strict;
use warnings;

sub describe {

    my $key_strength_hook = {
	'category' => 'Cpanel',
	'event' => 'Api2::SSH::genkey',
	'stage' => 'pre',
	'hook' => 'CustomAccount::KeyManager::force_key_strength',
	'check' => 'CustomAccount::KeyManager::check_key_strength',
	'exectype' => 'module',
    };

    return [$key_strength_hook];
}

sub check_key_strength {

    my ( $context, $data ) = @_;

    my $args = $data->{'args'};
    
    my $user = $data->{'user'};

    my $bits = $args->{'bits'};

    if ( $bits < 2048 ) {
	print "WARN: Weak SSH key, only $bits bits!","\n";
	return 1; # return true, do force strength
    } else {
	print "Generating SSH key for $user, secured with $bits bits.","\n";
	return 0; # return false, no need to force strength
    }
    
}

sub force_key_strength {

    my ( $context, $data ) = @_;

    my $args = $data->{'args'};
    my $bits = $args->{'bits'};
      
    my $secure_bits = 2048;
    
    print "NOTE: Default strength $bits forced to $secure_bits!";
    $args->{'bits'} = $secure_bits;
}

1;
