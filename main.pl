#!/usr/bin/perl -w

sub list_all_user{
    # creat list of all users
    # from file /etc/passwd

    my @list_users = ();# creat empty list
    foreach my $file (`cat /etc/passwd`) {
    my @spl = split(':',$file);# split line `root:x:0:0:root:/root:/bin/bash`
    my $user = $spl[0];# frst element is user name.
    push @list_users, $user;# add user to list
    }
    return @list_users;# return all list of users
}

