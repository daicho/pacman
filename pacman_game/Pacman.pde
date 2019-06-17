// パックマン
public class Pacman extends Character {
  private boolean invincible; // 無敵状態か
  private int nextDirection;  // 次に進む方向

  public Pacman(PVector position) {
    super(position);
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

  }
}