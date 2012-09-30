#!/usr/bin/perl

# Required modules
use Growl::GNTP;  # This needs to be installed from CPAN
use Getopt::Long qw(:config no_ignore_case);

# Define our global variables
our ($name,$host,$port,$title,$message,$icon,$password,$help);

# Check if no arguments where given and die
if (scalar(@ARGV) == 0) { die ("No arguments where given, I don't know what to do.\nCheck out the help: (-h|--help)\n"); }

# Get the command line options and set some defaults
GetOptions ('name|n=s'  => \$name,
            'host|h=s' => \($host = 'localhost'),
            'port|p=i' => \($port = '23053'),
            'title|t=s' => \$title,
            'message|m=s' => \$message,
            'icon|i=s' => \$icon,
            'password|P=s' => \$password,
            'help|H' => \$help);

# Print the help if asked for it
if ($help) {
    print "\nThis is a wrapper script to help you send a message to a Growl receiver.\n\nIt needs the following flags:\n-n|--name    Name of the app or script sending the message.\n-t|--title    Title of the message.\n-m|--message    The message itself.\n\nThe following flags are optional:\n-h|--host    Host running Growl, the receiver.Defaults to localhost.\n-p|--port    The port that Growl is running on.Defaults to 23053.\n-i|--icon    Icon to use when sending the message.\n-p|--password    Use a password if the Growl receiver requires one.\n-h|--help    Print this help\n";
    exit 0
}

# We need at least the name of the app, title and message
if (!$name or !$title or !$message) { die("I need at least (-n|--name) of the app, (-t|--title) and (-m|--message) you want to send.\nCheck out the (-h|--help)\n"); }

# Define and send the message
my $growl = Growl::GNTP->new(
    AppName => "$name",
    PeerHost => "$host",
    PeerPort => $port,
    Password => "$password",
    PasswordHashAlgorithm => "MD5",
);

$growl->register([
        { Name => "$name", },
        { Enabled => "True", },
        { Icon => "$icon", },
    ]);

$growl->notify(
    Event => "$name",
    Title => "$title",
    Message => "$message",
    Icon => "$icon",
);
