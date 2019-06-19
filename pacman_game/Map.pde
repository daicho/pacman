// マップ
public class Map {
    protected int[][] objects;       // 0:壁 1:通路 2:敵待機場所 3:敵出入口
    protected Item[] foods;          // エサ
    protected Item[] powerFoods;     // パワーエサ
    protected PVector startPosition; // パックマンの初期位置
    protected PImage image;          // 画像ファイル
    protected String stageName;      // ファイル読み込みに用いるステージ名

    public Map(String stageName) {
        PImage mapImage;       // マップファイル
        this.stageName = stageName;

        // 画像ファイル読み込み
        this.image = loadImage("maps/" + stageName + "-image.png");
        mapImage = loadImage("maps/" + stageName + "-map.png");

        this.startPosition = new PVector(50, 50);
    }

    public int getObject(int x, int y) {
      return objects[x][y];
    }

    // 画面描画
    public void draw() {
      image(image, 0, 0);
    }
}