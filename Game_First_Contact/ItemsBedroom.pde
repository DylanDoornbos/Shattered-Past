//teddy bear
class Teddy extends Scene {
  boolean firstEntrance = true;
  Dialogue teddyDialogue = new Dialogue(new String[]{
    "P: On the floor layed a teddybear, I used to carry him everywhere I went", 
    "T: Is there anything in particular you remember?", 
    "P: No, though he does look a bit bigger and cleaner than the last time I found him"
    });
  public Teddy() {
    super ("teddy.png", "Teddy Bear", false);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Bedroom 2", width - 100, height - 100, 80, 80)
    };
  }
  
  public void Draw() {
    //Draw the rest of the scene
    super.Draw();

    image(arrowBackImage, width - 100, height - 100, 80, 80);

    //Check if it's the first time entering the room
    if (firstEntrance) {
      //Play the dialogue
      teddyDialogue.Play();

      //Update the boolean
      firstEntrance = false;
    }
  }
}

// camera
class Camera1 extends Scene {
  public Camera1() {
    super("camera1.png", "Camera front", false);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Bedroom 2", width - 100, height - 100, 80, 80), 
      new SceneTransitionArea("Camera back", 300, 300, 440, 250)
    };
  }

  public void Draw() {
    super.Draw();
    image(arrowBackImage, width - 100, height - 100, 80, 80);
  }
}

class Camera2 extends Scene {
  public Camera2() {
    super("camera2.png", "Camera back", false);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Bedroom 2", width - 100, height - 100, 80, 80), 
      new SceneTransitionArea("Camera front", 200, 150, 490, 250)
    };
  }

  public void Draw() {
    super.Draw();
    image(arrowBackImage, width - 100, height - 100, 80, 80);
  }
}

//book
class Book extends Scene {
  public Book() {
    super ("book.png", "Book", false);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Bedroom 1", width - 100, height - 100, 80, 80)
    };
  }

  public void Draw() {
    super.Draw();
    image(arrowBackImage, width - 100, height - 100, 80, 80);
  }
}
