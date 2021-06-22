class SceneTransitionArea {
  
  String destinationScene;
  
  float x;
  float y;
  float areaWidth;
  float areaHeight;
  
  public SceneTransitionArea(String newDestination,
                             float newX, float newY,
                             float newWidth, float newHeight){
    destinationScene = newDestination;
    x = newX;
    y = newY;
    areaWidth = newWidth;
    areaHeight = newHeight;
  }
}
