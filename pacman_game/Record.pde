public static class Record {
  protected static int highScore;
  protected static String dataName;
  protected static File directory;

  public static int getHighScore() {
    return Record.highScore;
  }

  public static void setHighScore(int score) {
    // scoreがhighScoreより高かったら更新
    if(Record.getHighScore() < score)
      Record.highScore = score;
  }
  
  // データディレクトリ読み込み
  public static void loadDataDirectory(String dataDirectory) {
    Record.dataName = dataDirectory;
    Record.directory = new File(Record.dataName);
  }

  // ハイスコアの読み込み
  public static void loadHighScore() {
    String[] scoreData = loadStrings(Record.directory); // ハイスコアをロード
    int score = int(scoreData[0]);
    Record.highScore = score;
  }
  
  // ハイスコアの保存
  public static void saveHighScore(int score) {
    String[] scoreData = {str(score)};
    saveStrings(Record.directory, scoreData);
  }
}