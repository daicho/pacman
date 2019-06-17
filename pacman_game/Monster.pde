public abstract class Monster extends Character {
  private boolean ijike;

  public Monster(PVector position) {
    super(position);
  }

  public boolean getIjike() {
    return this.ijike;
  }

  public void setIjike(boolean ijike) {
    this.ijike = ijike;
  }

  // 進む方向を決定する
  public abstract void decideDirection(Map map, Pacman pacman);
}