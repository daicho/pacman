// マップ内のオブジェクトの種類
public enum Object {
  Wall,      // 壁
  Route,     // 通路
  EnemyBase, // 敵待機場所
  EnemyDoor  // 敵出入口
}

// マップ
public class Map {
  protected Object[][] objects;
  protected ArrayList<Item> foods;             // エサ
  protected ArrayList<Item> powerFoods;        // パワーエサ
  protected PVector pacmanPosition;            // パックマンの初期位置
  protected ArrayList<PVector> enemyPositions; // 敵の初期位置
  protected PImage image;                      // 画像ファイル
  protected String stageName;                  // ファイル読み込みに用いるステージ名
  
  public Map(String stageName) {
    this.stageName = stageName;
    this.foods = new ArrayList<Item>();
    this.powerFoods = new ArrayList<Item>();
    this.enemyPositions = new ArrayList<PVector>();
    this.image = loadImage("maps/" + this.stageName + "-image.png");

    // マップファイル読み込み
    PImage mapImage = loadImage("maps/" + stageName + "-map.png");
    mapImage.loadPixels();
    this.objects = new Object[mapImage.width][mapImage.height];

    for (int y = 0; y < mapImage.height; y++) {
      for (int x = 0; x < mapImage.width; x++) {
        color pixel = mapImage.pixels[y * mapImage.width + x];

        // パックマンの初期位置
        if (pixel == color(255, 0, 0)) {
          this.objects[x][y] = Object.Route;
          this.pacmanPosition = new PVector(x, y);

        // 敵の初期位置
        } else if (pixel == color(255, 0, 255)) {
          this.objects[x][y] = Object.Route;
          this.enemyPositions.add(new PVector(x, y));

        // エサ
        } else if (pixel == color(255, 255, 0)) {
          this.objects[x][y] = Object.Route;
          this.foods.add(new Item(new PVector(x, y), "food"));

        // パワーエサ
        } else if (pixel == color(0, 255, 255)) {
          this.objects[x][y] = Object.Route;
          this.powerFoods.add(new Item(new PVector(x, y), "power_food"));

        // 敵待機場所
        } else if (pixel == color(0, 0, 255)) {
          this.objects[x][y] = Object.EnemyBase;

        // 敵出入口
        } else if (pixel == color(0, 255, 0)) {
          this.objects[x][y] = Object.EnemyDoor;

        // 通路
        } else if (pixel == color(0, 0, 0)) {
          this.objects[x][y] = Object.Route;

        // 壁
        } else {
          this.objects[x][y] = Object.Wall;
        }
      }
    }
  }

  public Object getObject(int x, int y) {
    return this.objects[x][y];
  }

  // 画面描画
  public void draw() {
    image(image, 0, 0);
  }
}