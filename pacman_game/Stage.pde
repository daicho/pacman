import java.util.Iterator;

// ステージ
public class Stage {
  protected Pacman pacman;               // パックマン
  protected ArrayList<Monster> monsters; // 敵
  protected ArrayList<Item> foods;       // エサ
  protected ArrayList<Item> powerFoods;  // パワーエサ
  protected Map map;                     // マップ
  protected InputInterface input;        // 入力インターフェース
  protected int score;                   // スコア

  public Stage(String mapName, InputInterface input) {
    this.monsters = new ArrayList<Monster>();
    this.foods = new ArrayList<Item>();
    this.powerFoods = new ArrayList<Item>();
    this.map = new Map(mapName);
    this.input = input;
    this.score = 0;

    // マップファイル読み込み
    ArrayList<PVector> enemyPositions = new ArrayList<PVector>();
    PImage mapImage = loadImage("maps/" + mapName + "-map.png");
    mapImage.loadPixels();

    for (int y = 0; y < mapImage.height; y++) {
      for (int x = 0; x < mapImage.width; x++) {
        color pixel = mapImage.pixels[y * mapImage.width + x];

        // パックマン
        if (pixel == color(255, 0, 0)) {
          pacman = new Pacman(new PVector(x, y), 0, 1.6, 3, "pacman");

        // 敵
        } else if (pixel == color(255, 0, 255)) {
          enemyPositions.add(new PVector(x, y));

        // エサ
        } else if (pixel == color(255, 255, 0)) {
          foods.add(new Item(new PVector(x, y), 0, "food"));

        // パワーエサ
        } else if (pixel == color(0, 255, 255)) {
          powerFoods.add(new Item(new PVector(x, y), 10, "power_food"));
        }
      }
    }

    this.monsters.add(new Pinky (enemyPositions.get(2), 0, 1.6, 5, "pinky" ));
    this.monsters.add(new Akabei(enemyPositions.get(0), 0, 1.6, 5, "akabei"));
    this.monsters.add(new Guzuta(enemyPositions.get(3), 0, 1.6, 5, "guzuta"));
    this.monsters.add(new Aosuke(enemyPositions.get(1), 0, 1.6, 5, "aosuke"));
  }

  public int getScore() {
    return this.score;
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
    for (Monster monster : monsters)
      monster.decideDirection(this);
    pacman.decideDirection(this);

    // 移動
    for (Monster monster : monsters)
      monster.move(map);
    pacman.move(map);

    // 当たり判定
    for (Iterator<Item> i = foods.iterator(); i.hasNext();) {
      Item food = i.next();

      if (pacman.isColliding(food)) {
        /* ―――――
           音を鳴らす
           ――――― */
        this.score += 10;
        i.remove();
      }
    }

    for (Iterator<Item> i = powerFoods.iterator(); i.hasNext();) {
      Item powerFood = i.next();

      if (pacman.isColliding(powerFood)) {
        /* ―――――
           音を鳴らす
           ――――― */

        /* ―――――――――――――――
           パックマンを無敵モードにし、
           モンスターをイジケモードにする
           何秒か経ったら通常モードに戻す
           (本家は8秒)
           ――――――――――――――― */
        for (Monster monster : monsters)
          monster.setStatus(MonsterStatus.Ijike);

        this.score += 50;
        i.remove();
      }
    }

    for (Iterator<Monster> i = monsters.iterator(); i.hasNext();) {
      Monster monster = i.next();
      
      if (pacman.isColliding(monster)) {
        if (monster.getStatus() == MonsterStatus.Ijike) {
          ; /* 待機場所に戻る */
        } else {
          ; /* ゲームオーバー */
        }
      }
    }

    if (foods.isEmpty() && powerFoods.isEmpty()) {
      ; /* ゲームクリア */
    }
  }
  
  // スコア表示
  protected void dispScore() {
    textFont(loadFont("NuAnkoMochi-Reg-20.vlw"), 20);
    fill(255);
    textAlign(RIGHT, BASELINE);
    text("SCORE", 75, 180);
    text(score, 75, 200);
  }

  // 画面描画
  public void draw() {
    background(0);
    map.draw();

    for (Item food : foods)
      food.draw();

    for (Item powerFood : powerFoods)
      powerFood.draw();

    pacman.draw();

    for (Monster monster : monsters)
      monster.draw();

    dispScore(); //スコア表示
  }
}