public static class Record {
  protected static final int RANK_NUM = 10;

  protected static int[] highScore;
  protected static String dataName;

  //記録されているスコアの中で最も高い値のスコア（ハイスコア・ランキング1位）を返す
  public static int getHighScore() {
    return Record.highScore[0];
  }

  //記録されているスコアの中で最も低い値のスコア（ランキング10位）を返す
  public static int getRank10() {
    return Record.highScore[9];
  }

  public static void setRankScore(int score) {
    for (int i = 0; i < 10; i++) {
      if (Record.highScore[i] < score) {
        for (int j = 9; j < i; j--) {
          Record.highScore[j] = Record.highScore[j-1];
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
    for (int i = 0; i < 10; i++) {
      int score = int(scoreData[i]);
      Record.highScore[i] = score;
    }
  }

  // ハイスコアの保存
  public static void saveRankScore() {
    File dataPath = new File(Record.dataName);
    String[] scoreData = {str(Record.highScore[0]), str(Record.highScore[1]), 
      str(Record.highScore[2]), str(Record.highScore[3]), 
      str(Record.highScore[4]), str(Record.highScore[5]), 
      str(Record.highScore[6]), str(Record.highScore[7]), 
      str(Record.highScore[8]), str(Record.highScore[9])};
    saveStrings(dataPath, scoreData);
  }
}
