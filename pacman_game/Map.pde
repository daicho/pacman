// マップ内のオブジェクトの種類
public enum MapObject {
  Wall,      // 壁
  Route,     // 通路
  EnemyBase, // 敵待機場所
  EnemyDoor  // 敵出入口
}

// マップ
public class Map {
  protected MapObject[][] objects;
  protected ArrayList<Item> foods;             // エサ
  protected ArrayList<Item> powerFoods;        // パワーエサ
  protected PVector pacmanPosition;            // パックマンの初期位置
  protected ArrayList<PVector> enemyPositions; // 敵の初期位置
  protected PImage image;                      // 画像ファイル
  protected PVector size;                      // 画像サイズ
  
  public Map(String mapName) {
    this.foods = new ArrayList<Item>();
    this.powerFoods = new ArrayList<Item>();
    this.enemyPositions = new ArrayList<PVector>();
    
    // 画像ファイル読み込み
    this.image = loadImage("maps/" + mapName + "-image.png");
    this.size = new PVector(image.width, image.height);
    this.objects = new MapObject[image.width][image.height];

    // マップファイル読み込み
    PImage mapImage = loadImage("maps/" + mapName + "-map.png");
    mapImage.loadPixels();

    for (int y = 0; y < mapImage.height; y++) {
      for (int x = 0; x < mapImage.width; x++) {
        color pixel = mapImage.pixels[y * mapImage.width + x];

        // パックマンの初期位置
        if (pixel == color(255, 0, 0)) {
          objects[x][y] = MapObject.Route;
          pacmanPosition = new PVector(x, y);

        // 敵の初期位置
        } else if (pixel == color(255, 0, 255)) {
          objects[x][y] = MapObject.Route;
          enemyPositions.add(new PVector(x, y));

        // エサ
        } else if (pixel == color(255, 255, 0)) {
          objects[x][y] = MapObject.Route;
          foods.add(new Item(new PVector(x, y), 0, "food"));

        // パワーエサ
        } else if (pixel == color(0, 255, 255)) {
          objects[x][y] = MapObject.Route;
          powerFoods.add(new Item(new PVector(x, y), 10, "power_food"));

        // 敵待機場所
        } else if (pixel == color(0, 0, 255)) {
          objects[x][y] = MapObject.EnemyBase;

        // 敵出入口
        } else if (pixel == color(0, 255, 0)) {
          objects[x][y] = MapObject.EnemyDoor;

        // 通路
        } else if (pixel == color(0, 0, 0)) {
          objects[x][y] = MapObject.Route;

        // 壁
        } else {
          objects[x][y] = MapObject.Wall;
        }
      }
    }
  }

  public PVector getPacmanPosition() {
    return this.pacmanPosition;
  }

  public PVector getEnemyPosition(int index) {
    return this.enemyPositions.get(index);
  }

  public PVector getSize() {
    return this.size;
  }

  public MapObject getObject(float x, float y) {
    // 画面外は通路判定
    if (round(x) < 0 || round(x) >= size.x || round(y) < 0 || round(y) >= size.y)
      return MapObject.Route;
    else
      return this.objects[round(x)][round(y)];
  }

  // 画面描画
  public void draw() {
    image(image, 0, 0);

    for (Item food : foods)
      food.draw();

    for (Item powerFood : powerFoods)
      powerFood.draw();
  }
}