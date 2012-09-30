post-process-transmission
=========================

A collection of scripts to be run by Transmission after a torrent has finished downloading.

Right now it includes:

* growl\_notify.pl --> a Perl wrapper around Growl::GNTP to allow for easy message sending to a Growl receiver
* unpack\_torrent.sh --> a Bash script to unpack all archives from a torrent (if any) and log everything that happened to the last torrent downloaded

growl\_notify.pl is not specifically related to transmission, it's a more general script that allows any app, script to send a message to a Growl receiver listening on a network
connection. Or just manual message sending from the command line.

    How to use it:
    It needs the following flags:
    -n|--name    Name of the app or script sending the message.
    -t|--title    Title of the message.
    -m|--message    The message itself.
    The following flags are optional:
    -h|--host    Host running Growl, the receiver.Defaults to localhost.
    -p|--port    The port that Growl is running on.Defaults to 23053.
    -i|--icon    Icon to use when sending the message.
    -p|--password    Use a password if the Growl receiver requires one.
    -h|--help    Print this help

    Examples:
    growl_notify.pl -n transmission -t Torrent foo --message Has finished --host 192.168.1.1 --icon /usr/share/icons/hicolor/32x32/apps/transmission.png
    growl_notify.pl -n thunderbird -t Email from: -m "Jon Doe"

It can be used by Transmission by adding it to the scripts to run after a torrent has finished downloading to send a message to your box running Growl. Useful for headless
torrent boxes.

If you are worried about using your Growl password on the command line by passing it to the script using --password, there is a way around it. You can put the password in a plain
text file owned just by you - let's call it "password", chmod it to 600 and then use growl\_notify like this:

    growl_notify.pl -n transmission -t Torrent foo --message Has finished --host 192.168.1.1 --password `cat password`
