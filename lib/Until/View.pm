package Until::View;

use strict;
use warnings;
use v5.38;

use Gtk3;

sub new($class, @deltas) {
  bless({
    _deltas => \@deltas
  }, $class)
}

sub run($self) {
  Gtk3::init();

  for my $delta ($self->{_deltas}->@*) {
    my $window = Gtk3::Window->new("toplevel");
    $window->set_default_size(300, 300);
    $window->set_resizable(0);

    my $titlebar = Gtk3::HeaderBar->new();
    $window->set_titlebar($titlebar);

    my $box = Gtk3::Box->new("vertical", 10);
    $window->add($box);

    my $btn = Gtk3::Button->new("b");
    $btn->signal_connect(clicked => sub{warn("b")});
    $btn->set_halign("end");
    $box->add($btn);

    $window->show_all();
  }

  Gtk3::main();
}

1