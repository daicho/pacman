// パックマン
public class Pacman extends Character {
  protected boolean invincible; // 無敵状態か
  protected int nextDirection;  // 次に進む方向

  public Pacman(PVector position, int direction, float speed, String characterName, int interval) {
    super(position, direction, speed, characterName, interval);
  }

  public int getNextDirection() {
    return this.nextDirection;
  }

  public void setNextDirection(int nextDirection) {
    this.nextDirection = nextDirection;
  }

  public boolean getInvincble() {
    return this.invincible;
  }

  public void setInvincible(boolean invincible) {
    this.invincible = invincible;
  }

  // 進む方向を決定する
  public void decideDirection(Map map) {
    if (canMove(map, nextDirection))
      direction = nextDirection;
  }
}