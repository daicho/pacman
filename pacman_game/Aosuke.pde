// アオスケ
public class Aosuke extends Monster {
  public Aosuke(PVector position, int direction, float speed, int interval, String characterName) {
    super(position, direction, speed, interval, characterName);
  }

  // 進む方向を決定する
  public void decideDirection(Map map, Pacman pacman) {
    /* ――――――――――――――――――――
       気まぐれタイプ、パックマンを中心にして、
       オイカケの点対称の位置を目指して行動する
       ―――――――――――――――――――― */
  }
}