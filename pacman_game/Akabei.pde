// アカベエ
public class Akabei extends Monster {
  public Akabei(PVector position, int direction, float speed, String characterName, int interval) {
    super(position, direction, speed, characterName, interval);
  }

  // 進む方向を決定する
  public void decideDirection(Map map, Pacman pacman) {
  }
}