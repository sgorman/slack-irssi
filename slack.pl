use strict;
use vars qw($VERSION %IRSSI);

use Irssi;
$VERSION = '1.00';
%IRSSI = (
    authors     => 'A. U. Thor',
    contact     => 'author@far.away',
    name        => 'My First Script',
    description => 'This script allows ' .
                   'you to print Hello ' .
                   'World using a command.',
    license     => 'Public Domain',
);

sub screenshot {
    my ($data, $server, $witem) = @_;
    my $filename = "out.png";
    my $channel = 'u';
    my @args = split(/ /,$data);
    return unless $witem;
    my $target = $witem->{name};
    # $witem (window item) may be undef.
    if ($data) {
      $filename = $args[0];
    }
    if ($witem->{type} eq "CHANNEL") {
      $channel = 'c';
      $target = substr $target, 1;
    }
    #$witem->print($filename);
    #$witem->print($target);
    #$witem->print($channel);

    $witem->command("exec screencapture -WxT1 \$TMPDIR/screentmp.png && slackcat -$channel $target -m -n $filename \$TMPDIR/screentmp.png");
    $witem->command("exec rm \$TMPDIR/screentmp.png");
}

Irssi::command_bind slackscreenshot => \&screenshot;
