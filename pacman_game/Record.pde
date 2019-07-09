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
