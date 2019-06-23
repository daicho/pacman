public abstract class Monster extends Character {
  protected boolean ijike;

  protected Monster(PVector position, int direction, float speed, String characterName, int interval) {
    super(position, direction, speed, characterName, interval);
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