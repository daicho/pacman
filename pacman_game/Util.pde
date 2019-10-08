// アニメーション
public class Animation {
  protected PImage[] images;     // アニメーション画像
  protected PVector size;        // 画像サイズ
  protected int cur = 0;         // 現在のアニメーション番号
  protected int number;          // アニメーションの数
  protected Timer intervalTimer; // インターバルタイマー

  public Animation(String imageName) {
    // 画像ファイルの存在確認
    this.number = 0;
    while (true) {
      File imageFile = new File(dataPath("images/" + imageName + "-" + number + ".png"));
      if (!imageFile.exists())
        break;

      this.number++;
    }

    // 画像ファイル読み込み
    this.images = new PImage[number];
    for (int i = 0; i < number; i++)
      this.images[i] = loadImage(dataPath("images/" + imageName + "-" + i + ".png"));
    size = new PVector(images[0].width, images[0].height);

    // インターバル読み込み
    String[] intervalText = loadStrings(dataPath("images/" + imageName + "-interval.txt"));
    this.intervalTimer = new Timer(int(intervalText[0]));
  }

  // アニメーションを更新しアニメーションの終端ならばtrueを返す
  public boolean update() {
    if (intervalTimer.update()) {
      cur++;
      if (cur >= number) {
        cur = 0;
        return true;
      }
    }

    return false;
  }

  // 初期状態にリセット
  public void reset() {
    cur = 0;
    intervalTimer.reset();
  }

  // 画像を取得
  public PImage getImage() {
    return images[cur];
  }

  // 画像サイズを取得
  public PVector getSize() {
    return size;
  }
}

// タイマー
public class Timer {
  protected int time; // 設定時間
  protected int left; // 残り時間

  public Timer(int time) {
    this.time = time;
    this.left = time;
  }

  public int getTime() {
    return this.time;
  }

  public void setTime(int time) {
    this.time = time;
    this.left = time;
  }

  public int getLeft() {
    return this.left;
  }

  // 設定時間が経過したらtrueを返す
  public boolean update() {
    left--;
    if (left < 0) {
      left = time;
      return true;
    } else {
      return false;
    }
  }

  // リセット
  public void reset() {
    left = time;
  }
}

// スコアの記録
public static class Record {
  protected static final int RANK_NUM = 10; // ランキングの数

  protected static int[] ranking;   // ランキング
  protected static String filePath; // ランキングファイルパス

  // 指定されたランクのスコアを返す (+なら上から、-なら下からの順位を参照)
  public static int getRanking(int rank) {
    if (0 < rank && rank <= Record.RANK_NUM) {
      return Record.ranking[rank - 1];
    } else if (-Record.RANK_NUM <= rank && rank < 0) {
      return Record.ranking[Record.RANK_NUM + rank];
    } else {
      return 0;
    }
  }

  // ランキングに設定する
  public static int setRanking(int score) {
    for (int i = 0; i < Record.RANK_NUM; i++) {
      if (Record.ranking[i] <= score) {
        for (int j = Record.RANK_NUM - 1; j < i; j--) {
          Record.ranking[j] = Record.ranking[j - 1];
        }
        ranking[i] = score;
        return i + 1;
      }
    }

    return 0;
  }

  // ファイルパス読み込み
  public static void setFilePath(String filePath) {
    Record.filePath = filePath;
  }

  // ハイスコアの読み込み
  public static void loadRanking() {
    Record.ranking = new int[10];
    File dataFile = new File(Record.filePath);
    String[] scoreData = loadStrings(dataFile); // ハイスコアをロード
    for (int i = 0; i < Record.RANK_NUM; i++) {
      int score = int(scoreData[i]);
      Record.ranking[i] = score;
    }
  }

  // ハイスコアの保存
  public static void saveRanking() {
    File dataFile = new File(Record.filePath);
    String[] scoreData = new String[Record.RANK_NUM];
    for (int i = 0; i < Record.RANK_NUM; i++) {
      scoreData[i] = str(Record.ranking[i]);
    }
    saveStrings(dataFile, scoreData);
  }
}
