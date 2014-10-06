#!/usr/bin/perl

# From:
# http://superuser.com/questions/96489/ssh-tunnel-via-multiple-hops

$iport = 13021;
$first = 1;

foreach (@ARGV) {
    if (/^-/) {
	$args .= " $_";
    }
    elsif (/^((.+)@)?([^:]+):?(\d+)?$/) {
	$user = $1;
	$host = $3;
	$port = $4 || 22;
	if ($first) {
	    $cmd = "ssh ${user}${host} -p $port -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
	    $args = '';
	    $first = 0;
	}
	else {
	    $cmd .= " -L $iport:$host:$port";
	    push @cmds, "$cmd -f sleep 10 $args";
	    $cmd = "ssh ${user}localhost -p $iport -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
	    $args = '';
	    $iport ++;
	}
    }
}

push @cmds, "$cmd $args";

foreach (@cmds) {
    print "$_\n";
    system($_);
}
