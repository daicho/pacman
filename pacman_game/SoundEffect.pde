// 効果音
public class SoundEffect {
  final protected float VOLUME = 0.5; // 音量

  final protected float P1 = 787.330; // 音程
  final protected float P2 = 864.255;
  final protected float P3 = 908.456;
  final protected float P4 = 998.991;
  final protected float P5 = 1100.000;
  final protected float P6 = 1212.767;
  final protected float P7 = 1276.562;
  final protected float P8 = 1409.659;

  final protected float P9 = 174.614;
  final protected float P10 = 195.998;
  final protected float P11 = 220;

  protected AudioOutput out;
  protected Minim minim;

  public SoundEffect(Minim minim) {
    out = minim.getLineOut();
  }

  // パワーエサを食べたとき
  public void eatPowerFood() {  
    float soundWidth = 0.02, cycle = 0.16; 
    int i;
    for (i = 0; i < 4; i++) {
      out.playNote(soundWidth * 0 + (cycle * i), soundWidth, new SquareInstrument(P1, VOLUME, out));
      out.playNote(soundWidth * 1 + (cycle * i), soundWidth, new SquareInstrument(P2, VOLUME, out));
      out.playNote(soundWidth * 2 + (cycle * i), soundWidth, new SquareInstrument(P3, VOLUME, out));
      out.playNote(soundWidth * 3 + (cycle * i), soundWidth, new SquareInstrument(P4, VOLUME, out));
      out.playNote(soundWidth * 4 + (cycle * i), soundWidth, new SquareInstrument(P5, VOLUME, out));
      out.playNote(soundWidth * 5 + (cycle * i), soundWidth, new SquareInstrument(P6, VOLUME, out));
      out.playNote(soundWidth * 6 + (cycle * i), soundWidth, new SquareInstrument(P7, VOLUME, out));
      out.playNote(soundWidth * 7 + (cycle * i), soundWidth, new SquareInstrument(P8, VOLUME, out));
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
}
