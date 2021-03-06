#!/usr/bin/env perl

use strict;
use warnings;
use File::Basename;

my @commands = qw/
    condor_history
    condor_hold
    condor_q
    condor_qedit
    condor_release
    condor_rm
    condor_submit
    condor_version
    condor_config_val
    /;

my $dir = dirname($0);

foreach my $cmd (@commands) {
    # Create a wrapper script
    
    (my $new_name = $cmd) =~ s/condor_/condor_cron_/;
    my $out_file = "$dir/$new_name";
    open(OUT, '>', $out_file) or die("Cannot write to $out_file: $!");
    
    print OUT "#!/bin/sh\n";
    print OUT "\n";
    print OUT ". /usr/libexec/condor-cron/condor-cron.sh\n";
    print OUT "exec $cmd \"\$\@\"\n";

    close(OUT);

    system("chmod 0755 $out_file");
}
                 
