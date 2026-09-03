abstract class NavbarEvent {}
class ChangeNavbarIndex extends NavbarEvent{
  final int index;
  ChangeNavbarIndex(this.index);
}