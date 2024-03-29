package Until::View;

use v5.38;

use Gtk3 -init;

sub new($class, @deltas) {
  bless({
    _deltas => \@deltas
  }, $class)
}

sub run($self) {
  my $window = Gtk3::Window->new('toplevel');
  $window->show_all();
  Gtk3::main();
}

1