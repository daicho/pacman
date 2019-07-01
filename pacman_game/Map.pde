// マップ内のオブジェクトの種類
public enum MapObject {
  Wall,      // 壁
  Route,     // 通路
  EnemyBase, // 敵待機場所
  EnemyDoor  // 敵出入口
}

// マップ
public class Map {
  protected MapObject[][] objects; // マップ内のオブジェクト
  protected PVector releasePoint;  // 出撃地点
  protected PVector returnPoint;   // 帰還地点
  protected PImage image;          // 画像ファイル
  protected PVector size;          // 画像サイズ

  public Map(String mapName) {
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

        // 壁
        if (pixel == color(255, 255, 255)) {
          objects[x][y] = MapObject.Wall;

        // 敵待機場所
        } else if (pixel == color(0, 0, 255)) {
          objects[x][y] = MapObject.EnemyBase;

        // 敵出入口
        } else if (pixel == color(0, 255, 0)) {
          objects[x][y] = MapObject.EnemyDoor;

        // 通路
        } else {
          objects[x][y] = MapObject.Route;
        }

        // 出撃地点
        if (pixel == color(127, 0, 255)) {
          releasePoint = new PVector(x, y);

        // 帰還地点
        } else if (pixel == color(255, 127, 0)) {
          returnPoint = new PVector(x, y);
        }
      }
    }
  }

  public PVector getReleasePoint() {
    return this.releasePoint.copy();
  }

  public PVector getReturnPoint() {
    return this.returnPoint.copy();
  }

  public PVector getSize() {
    return this.size.copy();
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
  }
}
