package Until::Model;

use strict;
use warnings;
use v5.38;

package Until::Model::Date {
  use Date;
  use Scalar::Util qw(blessed);
  use Encode qw(decode);

  say("govno");


  sub new ($class, $date, $name) {
    bless({
      _date => $date,
      _name => $name // ''
    }, $class);
  }

  sub now ($class) {
    $class->new(Date::today(), "Today")
  }

  sub load_from_file($class, $filename) {
    open(my $fh, "<", $filename);

    my @dates;
    while (<$fh>) {
      my($raw, $name) = split(/,/, s/\R\z//r);
      next unless my $date = Date->new($raw);
      push(@dates, $class->new($date, decode('UTF-8', $name)));
    }

    return @dates;
  }

  sub value ($self) {
    $self->{_date}
  }

  sub name($self) {
    $self->{_name}
  }

  sub get_delta($self, $other) {
    Until::Model::Delta->new($self->value - $other->value, $self->name);
  }


}

package Until::Model::Delta {
  sub new ($class, $rel, $name) {
    bless({
      _rel => $rel,
      _name => $name,
    }, $class);
  }

  sub days ($self) {
    $self->{_rel}->to_days()
  }

  sub name ($self) {
    $self->{_name}
  }
}

1