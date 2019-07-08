public static class Record {
  protected static int highScore;
  protected static String dataName;

  public static int getHighScore() {
    return Record.highScore;
  }

  public static void setHighScore(int score) {
    // scoreがhighScoreより高かったら更新
    if(Record.getHighScore() < score)
      Record.highScore = score;
  }
  
  // ファイルパス読み込み
  public static void loadFilePath(String dataFilePath) {
    Record.dataName = dataFilePath;
  }

  // ハイスコアの読み込み
  public static void loadHighScore() {
    File dataPath = new File(Record.dataName);
    String[] scoreData = loadStrings(dataPath); // ハイスコアをロード
    int score = int(scoreData[0]);
    Record.highScore = score;
  }
  
  // ハイスコアの保存
  public static void saveHighScore() {
    File dataPath = new File(Record.dataName);
    String[] scoreData = {str(highScore)};
    saveStrings(dataPath, scoreData);
  }
}
