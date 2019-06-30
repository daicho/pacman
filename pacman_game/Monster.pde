public abstract class Monster extends Character {
  protected boolean ijike;

  protected Monster(PVector position, int direction, float speed, int interval, String characterName) {
    super(position, direction, speed, interval, characterName);
  }

  public boolean getIjike() {
    return this.ijike;
  }

  public void setIjike(boolean ijike) {
    this.ijike = ijike;
  }

  // 目標地点に進むための方向を返す
  protected int getAimDirection(Map map, PVector point) {
    int aimDirection = 1;
    float distanceMin = map.size.mag();
    boolean canForward = canMove(map, direction);

    for (int i = 0; i < 4; i++) {
      // 前進できるなら後退しない
      if (canForward)
        if (i == 2) continue;

      // 各方向に進んだときに目標地点との距離が最短となる方向を探す
      int checkDirection = (direction + i) % 4;

      PVector moveVector = getDirectionVector(checkDirection);
      moveVector.mult(speed);
      PVector checkPosition = new PVector(position.x + moveVector.x, position.y + moveVector.y);

      if (canMove(map, checkDirection) && checkPosition.dist(point) < distanceMin) {
        aimDirection = checkDirection;
        distanceMin = checkPosition.dist(point);
      }
    }

    return aimDirection;
  }

  // 進む方向を決定する
  public abstract void decideDirection(Map map, Pacman pacman);
}