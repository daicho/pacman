// パックマン
public class Pacman extends Character {
  protected int nextDirection; // 次に進む方向

  public Pacman(PVector position, int direction, float speed, int interval, String characterName) {
    super(position, direction, speed, interval, characterName);
    this.nextDirection = direction;
  }

  public int getNextDirection() {
    return this.nextDirection;
  }

  public void setNextDirection(int nextDirection) {
    this.nextDirection = nextDirection;
  }

  // 進む方向を決定する
  public void decideDirection(Stage stage) {
    if (canMove(stage.map, nextDirection))
      direction = nextDirection;
  }
}
