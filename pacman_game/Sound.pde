import ddf.minim.*;
import ddf.minim.ugens.*;

// BGMの基底クラス
abstract public class BGM {
  protected Minim minim;
  protected AudioPlayer player;
  //protected int length; 
  protected boolean breakFlag = false; // ファイル読み込みエラー用のフラグ

  public BGM(Minim minim) {
    // 音楽ファイル読み込み
    this.minim = minim;
  }

  // 再生開始する位置を初期位置にセット
  abstract public void rewind();

  // 再生
  abstract public boolean play();

  // 一時停止
  public void pause() {
    if (breakFlag == false) {
      player.pause();
    }
  }

  // 停止
  public void stop() {
    if (breakFlag == false) {
      player.close();
      minim.stop();
    }
  }
}

// スタート時のBGM
public class StartBGM extends BGM {
  public StartBGM(Minim minim) {
    super(minim);
    player = this.minim.loadFile("sounds/start.mp3");
    if (player == null) {
      breakFlag = true;
    } else {
      player.rewind();
      //player.printControls(); // 音量調節可能な範囲を表示
      player.setGain(-10); // 音量調節
    }
  }

  // 再生開始する位置を初期位置にセット
  public void rewind() {
    if (breakFlag == false) {
      player.rewind();
    }
  }

  // 再生
  public boolean play() {
    if (breakFlag == false) {
      player.play();
      if (player.position() >= 4700) {
        player.pause();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

// 通常時のBGM
public class NomalBGM extends BGM {

  public NomalBGM(Minim minim) {
    super(minim);
    player = this.minim.loadFile("sounds/schoolSong.mp3");
    if (player == null) {
      breakFlag = true;
    } else {
      player.cue(3500);
      //player.printControls(); // 音量調節可能な範囲を表示
      player.setGain(-10); // 音量調節
    }
  }

  // 再生開始する位置を初期位置にセット
  public void rewind() {
    if (breakFlag == false) {
      player.cue(3500);
    }
  }

  // 再生
  public boolean play() {
    if (breakFlag == false) {
      if (player.position() >= 52000) {
        player.cue(4100);
      }
      player.play();
    }
    return true;
  }
}

// 効果音
public class SoundEffect {
  protected final float VOLUME = 0.1; // 音量

  // 音程
  protected final float P1 = 787.330;
  protected final float P2 = 864.255;
  protected final float P3 = 908.456;
  protected final float P4 = 998.991;
  protected final float P5 = 1100.000;
  protected final float P6 = 1212.767;
  protected final float P7 = 1276.562;
  protected final float P8 = 1409.659;

  protected final float P9 = 174.614;
  protected final float P10 = 195.998;
  protected final float P11 = 220;

  protected AudioOutput out;

  public SoundEffect(Minim minim) {
    out = minim.getLineOut();
  }

  // パワーエサを食べたとき
  public void eatPowerFood() {  
    float soundWidth = 0.02, cycle = 0.16; 
    int i;
    for (i = 0; i < 4; i++) {
      out.playNote(soundWidth * 0 + cycle * i, soundWidth, new SquareInstrument(P1, VOLUME, out));
      out.playNote(soundWidth * 1 + cycle * i, soundWidth, new SquareInstrument(P2, VOLUME, out));
      out.playNote(soundWidth * 2 + cycle * i, soundWidth, new SquareInstrument(P3, VOLUME, out));
      out.playNote(soundWidth * 3 + cycle * i, soundWidth, new SquareInstrument(P4, VOLUME, out));
      out.playNote(soundWidth * 4 + cycle * i, soundWidth, new SquareInstrument(P5, VOLUME, out));
      out.playNote(soundWidth * 5 + cycle * i, soundWidth, new SquareInstrument(P6, VOLUME, out));
      out.playNote(soundWidth * 6 + cycle * i, soundWidth, new SquareInstrument(P7, VOLUME, out));
      out.playNote(soundWidth * 7 + cycle * i, soundWidth, new SquareInstrument(P8, VOLUME, out));
    }
  }

  // 普通のエサを食べたとき
  public void eatFood(boolean flag) {
    float soundWidth = 0.015;
    if (flag) {
      out.playNote(soundWidth * 0, soundWidth, new SquareInstrument(P9, VOLUME, out));
      out.playNote(soundWidth * 1, soundWidth, new SquareInstrument(P10, VOLUME, out));
      out.playNote(soundWidth * 2, soundWidth * 2, new SquareInstrument(P11, VOLUME, out));
    } else {
      out.playNote(soundWidth * 0, soundWidth * 2, new SquareInstrument(P11, VOLUME, out));
      out.playNote(soundWidth * 2, soundWidth, new SquareInstrument(P10, VOLUME, out));
      out.playNote(soundWidth * 3, soundWidth, new SquareInstrument(P9, VOLUME, out));
    }
  }

  // モンスターを食べたとき
  public void eatMonster() {
    float soundWidth = 0.03;
    out.playNote(soundWidth * 0, soundWidth, new SquareInstrument(659.255, VOLUME, out));
    out.playNote(soundWidth * 1, soundWidth, new SquareInstrument(698.456, VOLUME, out));
    out.playNote(soundWidth * 2, soundWidth, new SquareInstrument(783.991, VOLUME, out));
    out.playNote(soundWidth * 3, soundWidth, new SquareInstrument(880.000, VOLUME, out));
    out.playNote(soundWidth * 4, soundWidth, new SquareInstrument(987.767, VOLUME, out));
    out.playNote(soundWidth * 5, soundWidth, new SquareInstrument(1046.502, VOLUME, out));
    out.playNote(soundWidth * 6, soundWidth, new SquareInstrument(1174.659, VOLUME, out));
    out.playNote(soundWidth * 7, soundWidth, new SquareInstrument(1318.510, VOLUME, out));
    out.playNote(soundWidth * 8, soundWidth, new SquareInstrument(1396.918, VOLUME, out));
  }

  // 食べられたとき
  public void eaten() {
    float soundWidth = 0.125;
    out.playNote(soundWidth * 0, soundWidth, new SquareInstrument(1396.913, VOLUME, out));
    out.playNote(soundWidth * 1, soundWidth, new SquareInstrument(1479.978, VOLUME, out));
    out.playNote(soundWidth * 2, soundWidth, new SquareInstrument(1318.510, VOLUME, out));
    out.playNote(soundWidth * 3, soundWidth, new SquareInstrument(1396.918, VOLUME, out));
    out.playNote(soundWidth * 4, soundWidth, new SquareInstrument(1174.659, VOLUME, out));
    out.playNote(soundWidth * 5, soundWidth, new SquareInstrument(1244.508, VOLUME, out));
    out.playNote(soundWidth * 6, soundWidth, new SquareInstrument(1046.502, VOLUME, out));
    out.playNote(soundWidth * 7.5, soundWidth, new SquareInstrument(739.989, VOLUME, out));
    out.playNote(soundWidth * 9, soundWidth, new SquareInstrument(739.989, VOLUME, out));
  }

  // 1up
  public void oneUp() {
    float soundWidth = 0.13;
    out.playNote(soundWidth * 0, soundWidth, new SquareInstrument(391.995, VOLUME * 2, out));
    out.playNote(soundWidth * 1, soundWidth, new SquareInstrument(523.251, VOLUME * 2, out));
    out.playNote(soundWidth * 2, soundWidth, new SquareInstrument(659.255, VOLUME * 2, out));
    out.playNote(soundWidth * 3, soundWidth, new SquareInstrument(440, VOLUME * 2, out));
    out.playNote(soundWidth * 4, soundWidth, new SquareInstrument(587.330, VOLUME * 2, out));
    out.playNote(soundWidth * 5, soundWidth, new SquareInstrument(783.991, VOLUME * 2, out));
  }
}

// 矩形波を生成
public class SquareInstrument implements Instrument {
  protected Oscil oscil;
  protected AudioOutput out;

  public SquareInstrument(float frequency, float amplitude, AudioOutput out) {
    oscil = new Oscil(frequency, amplitude, Waves.SQUARE);
    this.out = out;
  }

  public void noteOn(float duration) {
    oscil.patch(out);
  }

  public void noteOff() {
    oscil.unpatch(out);
  }
}
