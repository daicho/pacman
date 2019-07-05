import java.util.Iterator;

// ステージ
public class Stage implements Scene {
  protected final PFont font = loadFont("fonts/NuAnkoMochi-Reg-20.vlw");

  protected Pacman pacman; // パックマン
  protected ArrayList<Monster> monsters = new ArrayList<Monster>(); // 敵
  protected ArrayList<Item> foods = new ArrayList<Item>();          // エサ
  protected ArrayList<Item> powerFoods = new ArrayList<Item>();     // パワーエサ
  protected Map map;       // マップ
  protected int frame = 0; // 経過フレーム
  protected int score = 0; // スコア
  protected int monsterEatCount = 4; // イジケ時に敵を食べた個数
  protected int life = 3;  // 残機の数

  public Stage(String mapName) {
    this.map = new Map(mapName);

    // マップファイル読み込み
    ArrayList<PVector> enemyPositions = new ArrayList<PVector>();
    PImage mapImage = loadImage("maps/" + mapName + "-map.png");
    mapImage.loadPixels();

    for (int y = 0; y < mapImage.height; y++) {
      for (int x = 0; x < mapImage.width; x++) {
        color pixel = mapImage.pixels[y * mapImage.width + x];

        // パックマン
        if (pixel == color(255, 0, 0)) {
          pacman = new Pacman(new PVector(x, y), 2, 1.6, 3, "pacman");
        }
        // 敵
        else if (pixel == color(0, 0, 255)) {
          enemyPositions.add(new PVector(x, y));
        }
        // エサ
        else if (pixel == color(255, 255, 0)) {
          foods.add(new Item(new PVector(x, y), 0, "food"));
        }
        // パワーエサ
        else if (pixel == color(0, 255, 255)) {
          powerFoods.add(new Item(new PVector(x, y), 10, "power_food"));
        }
      }
    }

    this.monsters.add(new Akabei(enemyPositions.get(0), 1, 1.6, 5, "akabei"));
    this.monsters.add(new Pinky (enemyPositions.get(2), 1, 1.6, 5, "pinky" ));
    this.monsters.add(new Aosuke(enemyPositions.get(1), 1, 1.6, 5, "aosuke"));
    this.monsters.add(new Guzuta(enemyPositions.get(3), 1, 1.6, 5, "guzuta"));

    this.draw();
  }

  public int getScore() {
    return this.score;
  }

  // ステージ内の状態を更新
  public void update() {
    // ボタン入力
    if (Input.right())
      pacman.setNextDirection(0); // →
    else if (Input.up())
      pacman.setNextDirection(1); // ↑
    else if (Input.left())
      pacman.setNextDirection(2); // ←
    else if (Input.down())
      pacman.setNextDirection(3); // ↓

    // モンスター放出
    switch (frame) {
    case 0:
      this.monsters.get(0).setStatus(MonsterStatus.Release);
      break;

    case 300:
      this.monsters.get(1).setStatus(MonsterStatus.Release);
      break;

    case 600:
      this.monsters.get(2).setStatus(MonsterStatus.Release);
      break;

    case 900:
      this.monsters.get(3).setStatus(MonsterStatus.Release);
      break;
    }

    // パックマンと敵の向きを決定
    for (Monster monster : monsters)
      monster.decideDirection(this);
    pacman.decideDirection(this);

    // 移動
    for (Monster monster : monsters)
      monster.move(map);
    pacman.move(map);

    // 更新
    pacman.update(map);

    for (Monster monster : monsters)
      monster.update(map);

    for (Item food : foods)
      food.update();

    for (Item powerFood : powerFoods)
      powerFood.update();

    // 当たり判定
    for (Iterator<Item> i = foods.iterator(); i.hasNext(); ) {
      Item food = i.next();

      if (pacman.isColliding(food)) {
        /* ―――――
         音を鳴らす
         ――――― */
        this.score += 10;
        i.remove();
      }
    }

    for (Iterator<Item> i = powerFoods.iterator(); i.hasNext(); ) {
      Item powerFood = i.next();

      if (pacman.isColliding(powerFood)) {
        /* ―――――
         音を鳴らす
         ――――― */

        for (Monster monster : monsters) {
          if (monster.status != MonsterStatus.Return) {
            monster.setMode(MonsterMode.Ijike);
            monster.setIjikeTime(480);
          }
        }

        this.monsterEatCount = 0;
        this.score += 50;
        i.remove();
      }
    }

    for (Iterator<Monster> i = monsters.iterator(); i.hasNext(); ) {
      Monster monster = i.next();

      if (pacman.isColliding(monster)) {
        switch (monster.getStatus()) {
        case Return:
          break;

        case Active:
          if (monster.getMode() == MonsterMode.Ijike) {
            // モンスターを食べた時のスコア
            this.monsterEatCount++;

            switch (this.monsterEatCount) {
            case 1:
              this.score += 200;
              break;

            case 2:
              this.score += 400;
              break;

            case 3:
              this.score += 800;
              break;

            case 4:
              this.score += 1600;
              break;
            }
            monster.setStatus(MonsterStatus.Return);
            break;
          }

        default:
          if (life <= 0) {
            /* ゲームオーバー */
            println("game over");
          } else {
            // 残機を1つ減らしゲーム続行
            life--;
            println(life);

            ArrayList<PVector> enemyPositions = new ArrayList<PVector>();
            PImage mapImage = loadImage("maps/" + "original" + "-map.png");
            mapImage.loadPixels();
            for (int y = 0; y < mapImage.height; y++) {
              for (int x = 0; x < mapImage.width; x++) {
                color pixel = mapImage.pixels[y * mapImage.width + x];

                // パックマン
                if (pixel == color(255, 0, 0)) {
                  pacman.position.set(x, y);
                }
                // 敵
                else if (pixel == color(0, 0, 255)) {
                  enemyPositions.add(new PVector(x, y));
                }
              }
            }

            for (int m = 0; m < monsters.size(); m++) {
              this.monsters.get(m).position = enemyPositions.get((3-m)*m/2+m%2*m);
              this.monsters.get(m).setStatus(MonsterStatus.Wait);
              this.monsters.get(m).setMode(MonsterMode.Rest);
              this.monsters.get(m).direction = 1;
            }
            frame = 0;
            this.update();
          }
          break;
        }
      }
    }

    if (foods.isEmpty() && powerFoods.isEmpty()) {
      ; /* ゲームクリア */
    }

    frame++;
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

    // スコア表示
    textFont(font, 20);
    fill(255);
    textAlign(RIGHT, BASELINE);
    text("SCORE", 75, 180);
    text(score, 75, 200);
  }
}
