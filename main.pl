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

sub process_user{
    # `user name` is arrgument
    # creat list of all process for user
    my @list_process_user = ();# empty list
    my ($user_name) = @_;# user_name = arrgument
    # run command ps -o user,pid,comm --user <user_name> 
    my $command = "ps -o user,pid,comm --user ";
    $command = $command . $user_name; # add user name to command
    
    foreach my $process (`$command`) {
    push @list_process_user, $process;# add process to list
    }

    return @list_process_user;
}