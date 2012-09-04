#-*-perl-*-

package CustomAccount::CreateAcct;

use strict;
use warnings;

sub describe {

    my $uid_gid_hook = {
	'category' => 'Whostmgr',
	'event' => 'Accounts::Create',
	'stage' => 'post',
	'hook' => 'CustomAccount::CreateAcct::get_unix_user',
	'exectype' => 'module',
    };

    return [$uid_gid_hook];
}

sub get_unix_user {

    my ( $context, $data ) = @_;
    
    my $cpanel_user = $data->{'user'};
    
    open(FH, "<", "/etc/passwd") or die "open failed: $!";
    
    while ($line = <FH>) {
	my ( $user, $pass, $uid, $gid, $group, $home, $shell ) = split(":", $line);
	
	if ( "$user" == "$cpanel_user" ) {
	    print "user $user matches!\n";
	    print "$uid", "\n";
	    print "$gid", "\n";
	}
    }
}


1;
