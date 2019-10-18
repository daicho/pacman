import ddf.minim.*;
import ddf.minim.ugens.*;

// ステージで流れるBGM用のインターフェース
public interface BGMMethod {
  public void rewind();  // 再生開始位置をリセット
  public void play();    // 再生
  public void pause();   // 停止
}

// BGMの基底クラス
abstract public class BGM {
  protected Minim minim;
  protected AudioPlayer player;
  protected boolean breakFlag; // ファイル読み込みエラー用のフラグ

  public BGM(Minim minim) {
    // 音楽ファイル読み込み
    this.minim = minim;
  }

  // 停止
  public void stop() {
    if (!breakFlag) {
      player.close();
      minim.stop();
    }
  }
}

// スタート時のBGM
public class StartBGM extends BGM {

  public StartBGM(Minim minim, String mapName) {
    super(minim);
    player = this.minim.loadFile("sounds/start.mp3");
    if (player == null) {
      breakFlag = true;
    } else {
      breakFlag = false;
      player.rewind();
    }
    if (mapName.equals("1")) {  // ゲーム開始時かをチェック
    } else {
      player.setGain(-100);     // ゲーム開始時以外なら消音にする
      player.cue(2700);
    }
  }

  // 消音にし、再生開始位置をリセット
  public void mute() {
    if (!breakFlag) {
      player.setGain(-100);
      player.cue(2700);
    }
  }

  // 再生
  public boolean play() {
    if (!breakFlag) {
      player.play();
      if (player.position() >= 4700) {
        player.pause();
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}

// 通常時のBGM
public class NomalBGM extends BGM implements BGMMethod {

  public NomalBGM(Minim minim) {
    super(minim);
    player = this.minim.loadFile("sounds/schoolSong.mp3");
    if (player == null) {
      breakFlag = true;
    } else {
      breakFlag = false;
      player.cue(3500);
      player.setGain(-10);      // 音量調節
    }
  }

  // 再生開始位置をリセット
  public void rewind() {
    if (!breakFlag) {
      player.cue(3500);
    }
  }

  // 再生
  public void play() {
    if (!breakFlag) {
      if (player.position() >= 52000) {
        player.cue(4100);
      }
      player.play();
    }
  }
  
  // 一時停止
  public void pause() {
    if (!breakFlag) {
      player.pause();
    }
  }
}

public class IjikeBGM extends BGM implements BGMMethod {

  public IjikeBGM(Minim minim) {
    super(minim);
    player = this.minim.loadFile("sounds/ijike.mp3");
    if (player == null) {
      breakFlag = true;
    } else {
      breakFlag = false;
      player.rewind();
      player.setGain(-10);      // 音量調節
    }
  }

  // 再生開始位置をリセット
  public void rewind() {
    if (!breakFlag) {
      player.rewind();
    }
  }

  // 再生
  public void play() {
    if (!breakFlag) {
      if (player.position() >= 7000) {
        player.rewind();
      }
      player.play();
    }
  }

  // 一時停止
  public void pause() {
    if (!breakFlag) {
      player.pause();
    }
  }
}

public class StageBGM {
  protected NomalBGM nomal;
  protected IjikeBGM ijike;
  protected boolean breakFlag = false; // ファイル読み込みエラー用のフラグ

  public StageBGM(Minim minim) {
    this.nomal = new NomalBGM(minim);
    this.ijike = new IjikeBGM(minim);
    if (!nomal.breakFlag && !ijike.breakFlag ) {
      this.breakFlag = false;
    } else {
      this.breakFlag = true;
    }
  }

  // 再生開始位置をリセット
  public void rewind() {
    if (!breakFlag) {
      nomal.rewind();
      ijike.rewind();
    }
  }

  // 通常BGMを再生
  public void play() {
    if (!breakFlag) {
      ijike.pause();
      nomal.play();
    }
  }

  // いじけBGMを再生
  public void ijike() {
    if (!breakFlag) {
      nomal.pause();
      ijike.play();
    }
  }

  // 一時停止
  public void pause() {
    if (!breakFlag) {
      nomal.pause();
      ijike.pause();
    }
  }

  // 停止
  public void stop() {
    if (!breakFlag) {
      nomal.stop();
      ijike.stop();
    }
  }
}

// 効果音
public class SoundEffect {
  protected final float VOLUME = 0.1;  // 音量
  private boolean eatSEFlag = true;    // 普通のエサを食べたときの効果音切り替えフラグ

  protected AudioOutput out;

  public SoundEffect(Minim minim) {
    out = minim.getLineOut();
  }

  // パワーエサを食べたとき
  public void eatPowerFood() {  
    float soundWidth = 0.02, cycle = 0.16; 
    int i;
    for (i = 0; i < 4; i++) {
      out.playNote(soundWidth * 0 + cycle * i, soundWidth, new SquareInstrument(787.330, VOLUME, out));
      out.playNote(soundWidth * 1 + cycle * i, soundWidth, new SquareInstrument(864.255, VOLUME, out));
      out.playNote(soundWidth * 2 + cycle * i, soundWidth, new SquareInstrument(908.456, VOLUME, out));
      out.playNote(soundWidth * 3 + cycle * i, soundWidth, new SquareInstrument(998.991, VOLUME, out));
      out.playNote(soundWidth * 4 + cycle * i, soundWidth, new SquareInstrument(1100.000, VOLUME, out));
      out.playNote(soundWidth * 5 + cycle * i, soundWidth, new SquareInstrument(1212.767, VOLUME, out));
      out.playNote(soundWidth * 6 + cycle * i, soundWidth, new SquareInstrument(1276.562, VOLUME, out));
      out.playNote(soundWidth * 7 + cycle * i, soundWidth, new SquareInstrument(1409.659, VOLUME, out));
    }
  }

  // 普通のエサを食べたとき
  public void eatFood() {
    float soundWidth = 0.015;
    if (eatSEFlag) {
      out.playNote(soundWidth * 0, soundWidth, new SquareInstrument(174.614, VOLUME, out));
      out.playNote(soundWidth * 1, soundWidth, new SquareInstrument(195.998, VOLUME, out));
      out.playNote(soundWidth * 2, soundWidth * 2, new SquareInstrument(220, VOLUME, out));
    } else {
      out.playNote(soundWidth * 0, soundWidth * 2, new SquareInstrument(220, VOLUME, out));
      out.playNote(soundWidth * 2, soundWidth, new SquareInstrument(195.998, VOLUME, out));
      out.playNote(soundWidth * 3, soundWidth, new SquareInstrument(174.614, VOLUME, out));
    }
    eatSEFlag = !eatSEFlag;
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
    out.playNote(soundWidth * 3, soundWidth, new SquareInstrument(440.000, VOLUME * 2, out));
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
