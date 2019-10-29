#!/usr/bin/perl -w

use Tk;
use strict;

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

my $mw = MainWindow->new; # creat main window.
$mw->geometry("600x400"); # set geometry.
$mw->title("Lista_procesow!"); # set title.
my $main_frame = $mw->Frame(-background => 'cyan')->pack(-side=>'top',-fill=>'x'); # add main frame.
# creat left nad right frame in mian frame.
#left frame has User label nad Listbox with all users
# right fraem has Porcess user label and text widget with process.
my $left_frame = $main_frame->Frame(-background => 'green')->pack(-side=>'left',-fill=>'x');
my $right_frame = $main_frame->Frame(-background => 'blue')->pack(-side=>'right',-fill=>'x');

# label with User.
my $label_user = $left_frame->Label(-text => 'User: ', -background => 'cyan',
                                    -width => 9, -borderwidth => 2,
                                    -relief => 'sunken')->pack(-side=>'left');                                                                                                                                                                           
# label with user name. 
my $label_process_user_name = $right_frame->Label(-text => "Process for user:",-background => 'green',
                                    -width => 40, -borderwidth => 2,
                                    -relief => 'sunken')->pack(-side => "top");
# text widget where we see all process information for some user.                                                                                                                                                                           
my $text_user_process = $right_frame->Text(-background => 'yellow',-width => 40,
                                           -borderwidth => 2)->pack(-side => "top");

# list of users from file /etc/passwd.
my @all_users = list_all_user();
#Add Listbox of all users.
my $listbox_all_user = $left_frame->Scrolled("Listbox", -scrollbars => "osoe")->pack(-side => "left");
#Add array with users to Listbox.
$listbox_all_user->insert("end",  @all_users);
#add event if we click a item from Listbox we run change_user function.


MainLoop;