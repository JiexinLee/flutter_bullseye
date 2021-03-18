class GameModel {
  static const START_VALUE = 50;
  static const START_ROUND = 1;
  static const START_SCORE = 0;
  GameModel(this.target, 
  [this.currentValue = START_VALUE, this.round = START_ROUND, this.totalScore = START_SCORE]);
  int round;
  int totalScore;
  int currentValue;
  int target;
}
