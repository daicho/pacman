// ステージ
public class Stage {
  private Pacman pacman;        // パックマン
  private Monster[] monsters;   // 敵
  private Map map;              // マップ
  private InputInterface input; // 入力インターフェース
  private String stageName;     // ファイル読み込みに用いるステージ名

  Stage(String stageName, InputInterface input) {
    this.stageName = stageName;
    this.map = new Map(stageName);
    this.input = input;
    
    this.pacman = new Pacman(map.startPosition);
    this.monsters = new Monster[4];
    this.monsters[0] = new Akabei(new PVector(0, 0));
    this.monsters[1] = new Aosuke(new PVector(30, 30));
    this.monsters[2] = new Pinky(new PVector(60, 60));
    this.monsters[3] = new Guzuta(new PVector(90, 90));
  }

  // ステージ内の状態を更新
  public void update() {
    // ボタン入力
    if (input.right())
      pacman.setNextDirection(0); // →
    else if (input.up())
      pacman.setNextDirection(1); // ↑
    else if (input.left())
      pacman.setNextDirection(2); // ←
    else if (input.down())
      pacman.setNextDirection(3); // ↓

    // パックマンと敵の向きを決定
    for (Monster monster: monsters)
      monster.decideDirection(map, pacman);
    pacman.decideDirection(map);

    // 移動
    for (Monster monster: monsters)
      monster.move(map);
    pacman.move(map);
  }

  // 画面描画
  public void draw() {
    background(0);
    map.draw();
    for (Monster monster: monsters)
      monster.draw();
    pacman.draw();
  }
}