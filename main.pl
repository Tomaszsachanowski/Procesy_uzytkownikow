#!/usr/bin/perl -w

use Tk;
use strict;
use List::MoreUtils qw(uniq);#we only have distinct values in an array. 

sub list_all_user{
    # creat list of all users
    # from file /etc/passwd and command `ps -e -o user`

    my @list_users = ();# creat empty list
    foreach my $file (`cat /etc/passwd`) {
    my @spl = split(':',$file);# split line `root:x:0:0:root:/root:/bin/bash`
    my $user = $spl[0];# frst element is user name.
    push @list_users, $user;# add user to list
    }
    
    my @ps_list = (`ps -e -o user`); # list of user who has process
    @ps_list = @ps_list[1..$#ps_list]; # avoidance first elem `USER`

    my @list_users_ps = ();# creat empty list
    foreach my $line (@ps_list) {
    my @spl = split(' ',$line);# split line `root   ` delete White signs.
    my $user = $spl[0];# frst element is user name.
    push @list_users_ps, $user;# add user to list
    }
    my @tmp_list = (@list_users, @list_users_ps); #appending a list to the end of an other list.
    @list_users = uniq @tmp_list; #we only have distinct values in an array. 
    return @list_users;# return all list of users
}

sub process_user{
    # `user name` is arrgument
    # creat list of all process for user
    my @list_process_user = ();# empty list
    my ($user_name) = @_;# user_name = arrgument
    
    my $command = "";
    # when we have all process without root process.
    if (($user_name eq "all_users_without_root") == 1){
        $command = "ps -e -o user,pid,comm"; # commnad with all process.
        # for all process i check if process belongs to root.
        foreach my $process (`$command`) {
            my @spl = split(' ',$process);# split line `root     14353 kworker/u8:2`
            my $user = $spl[0];# if process doesn't belongs to root.
            if (($user ne "root")==1){
                push @list_process_user, $process;# add process to list
            }
        }
    }
    # When we click all_process or some user.
    else{# if we click all_process.
        if (($user_name eq "all_users") == 1){
                $command = "ps -e -o user,pid,comm";
        }
        else{
                $command = "ps -o user,pid,comm --user ";
                $command = $command . $user_name; # add user name to command
        }
        # run command ps ...
        foreach my $process (`$command`) {
        push @list_process_user, $process;# add process to list
        }
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
$listbox_all_user->insert("end",  "all_users","all_users_without_root", @all_users);
#add event if we click a item from Listbox we run change_user function.
$listbox_all_user->bind('<Button-1>'=>\&change_user);


sub change_user{
    #get user name from Listbox. $_[0] is event from Listbox  
    my $user_name = $_[0]->get($_[0]->curselection);
    # joining string.
    my $text = "Process for user: " . $user_name;
    # Update label with information about user name.
    $label_process_user_name->configure(-text=>"$text");

    #creat list of process for selected user name.
    my @all_process = process_user("$user_name");

    # change text state (I can delete and add some text).
    $text_user_process->configure(-state=>'normal');
    # delete all text.
    $text_user_process->delete('0.0','end');
    # add all process.
    foreach my $process (@all_process) {
    $text_user_process->insert('end', $process);
    }
    # change text state to disabled (I can't edit text). 
    $text_user_process->configure(-state=>'disabled');
}

MainLoop;
