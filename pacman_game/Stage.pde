// ステージ
public class Stage {
  private Pacman pacman;        // パックマン
  private Monster[] monsters;   // 敵
  private Map map;              // マップ
  private InputInterface input; // 入力インターフェース
  private String stage_name;    // ファイル読み込みに用いるステージ名

  Stage(String stage_name, InputInterface input) {
    this.stage_name = stage_name;
    this.input = input;
  }

  // ステージ内の状態を更新
  public void update() {

  }

  // 画面描画
  public void draw() {

  }
}