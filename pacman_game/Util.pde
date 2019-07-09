// スコアの記録
public static class Record {
  protected static final int RANK_NUM = 10;

  protected static int[] highScore;
  protected static String dataName;

  // 指定されたランクのスコアを返す (+なら上から、-なら下からの順位を参照)
  public static int getRankScore(int rank) {
    if (0 < rank && rank <= Record.RANK_NUM) {
      return Record.highScore[rank - 1];
    } else if (-Record.RANK_NUM <= rank && rank < 0) {
      return Record.highScore[Record.RANK_NUM + rank];
    } else {
      return 0;
    }
  }

  public static void setRankScore(int score) {
    for (int i = 0; i < Record.RANK_NUM; i++) {
      if (Record.highScore[i] < score) {
        for (int j = Record.RANK_NUM - 1; j < i; j--) {
          Record.highScore[j] = Record.highScore[j - 1];
        }
        highScore[i] = score;
        break;
      }
    }
  }

  // ファイルパス読み込み
  public static void loadFilePath(String dataFilePath) {
    Record.dataName = dataFilePath;
  }

  // ハイスコアの読み込み
  public static void loadRankScore() {
    Record.highScore = new int[10];
    File dataPath = new File(Record.dataName);
    String[] scoreData = loadStrings(dataPath); // ハイスコアをロード
    for (int i = 0; i < Record.RANK_NUM; i++) {
      int score = int(scoreData[i]);
      Record.highScore[i] = score;
    }
  }

  // ハイスコアの保存
  public static void saveRankScore() {
    File dataPath = new File(Record.dataName);
    String[] scoreData = new String[Record.RANK_NUM];
    for (int i = 0; i < Record.RANK_NUM; i++) {
      scoreData[i] = str(Record.highScore[i]);
    }
    saveStrings(dataPath, scoreData);
  }
}

// アニメーション
public class Animation {
  protected PImage[] images;     // アニメーション画像
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
    return images[cur].copy();
  }

  // 画像サイズを取得
  public PVector getSize() {
    return new PVector(images[0].width, images[0].height);
  }
}

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
