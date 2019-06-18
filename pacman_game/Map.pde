// マップ
public class Map {
    private int[][] objects;       // 0:壁 1:通路 2:敵待機場所 3:敵出入口
    private Item[] foods;          // エサ
    private Item[] powerFoods;     // パワーエサ
    private PVector startPosition; // パックマンの初期位置
    private PImage image;          // 画像ファイル
    private String stageName;     // ファイル読み込みに用いるステージ名

    public Map(String stageName) {
        this.stageName = stageName;

        // 画像ファイル読み込み

        // マップファイル読み込み
    }

    public int getObject(int x, int y) {
      return objects[x][y];
    }

    // 画面描画
    public void draw() {

    }
}