class InteractiveDialogue {

  Dialogue dialogueToDisplay;
  float x;
  float y;
  float areaWidth;
  float areaHeight;

  public InteractiveDialogue(float newX, float newY, float newWidth, float newHeight, Dialogue newDialogue) {
    x = newX;
    y = newY;
    areaWidth = newWidth;
    areaHeight = newHeight;
    dialogueToDisplay = newDialogue;
  }
}
