class SceneStart extends Scene {
  public SceneStart() {
    super ("Start Screen.png", "", false);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Office 1", 350, 574, 283, 137), 
    };
  }
}
