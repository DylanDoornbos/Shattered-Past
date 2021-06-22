//closet
class Closet extends Scene {
  private boolean firstEntrance = true;
  Dialogue inClosetDialogue = new Dialogue(new String[]{
    "P: I didn't even feel like I was falling, I hardly even noticed I had hit the ground", 
    "P: I felt around and pushed against the wall of the box, the 'wall' gave out and I stumbled into a bedroom"
    });
  public Closet() {
    super("Inside_closet.png", "Closet?", false);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Bedroom 1", 0, 0, 1000, 800), 
    };
  }
  public void Draw() {
    //Check if it's the first time entering the room
    if (firstEntrance) {
      //Play the dialogue
      inClosetDialogue.Play();
      yeet.amp(1);
      yeet.play();

      //Update the boolean
      firstEntrance = false;
    }

    //Draw the rest of the scene
    super.Draw();
  }
}

//bedroom1
class Bedroom1 extends Scene {
  private boolean firstEntrance = true;
  Dialogue inBedroom = new Dialogue(new String[]{
    "I ended up inside what resembled my childhood bedroom", 
    });
  public Bedroom1() {
    super("bedroom1.png", "Bedroom 1", false);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Bedroom 2", width - 100, height - 100, 80, 80), 
      new SceneTransitionArea("Door Lock", 360, 410, 70, 80), 
      new SceneTransitionArea("Diary", 830, 410, 180, 10), 
      new SceneTransitionArea("Book", 957, 48, 27, 70)
    };
  }
  public void Draw() {
    //Draw the rest of the scene
    super.Draw();

    image(arrowRightImage, width - 100, height - 100, 80, 80);

    //Check if it's the first time entering the room
    if (firstEntrance) {
      //Play the dialogue
      inBedroom.Play();

      //Update the boolean
      firstEntrance = false;
    }
  }
}

//bedroom2
class Bedroom2 extends Scene {

  public Bedroom2() {
    super("bedroom2.png", "Bedroom 2", false);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Bedroom 1", 20, height - 100, 80, 80), 
      new SceneTransitionArea("Teddy", 280, 450, 200, 280), 
      new SceneTransitionArea("Camera front", 50, 315, 170, 75), 
    };

    InteractiveDialogue closetClickDialogue = new InteractiveDialogue(395, 0, 315, 470, 
      new Dialogue(new String[]{
      "It's the closet I fell out of"
      }));
    dialogueObjects = new InteractiveDialogue[]{closetClickDialogue};
  }

  public void Draw() {
    super.Draw();
    image(arrowLeftImage, 20, height - 100, 80, 80);
  }
}

//door lock zoom
class DoorLock extends Scene {
  private boolean firstEntrance = true;
  Dialogue nearLockDialogue = new Dialogue(new String[]{
    "The door is locked, it seems I need a 3 digit code..."
    });
  public DoorLock() {
    super("Door_lock.png", "Door Lock", false);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Bedroom 1", width - 100, height - 100, 80, 80), 
    };

    buttons = new LockButton[]{
      new LockButton(435, 605, 50, 33, 1), 
      new LockButton(490, 605, 60, 33, 2), 
      new LockButton(550, 605, 50, 33, 3), 
      new LockButton(435, 640, 50, 35, 4), 
      new LockButton(488, 640, 60, 35, 5), 
      new LockButton(550, 640, 50, 35, 6), 
      new LockButton(435, 680, 50, 33, 7), 
      new LockButton(488, 680, 60, 33, 8), 
      new LockButton(550, 680, 50, 33, 9)
    };
  }

  public void Draw() {
    //Draw the rest of the scene
    super.Draw();

    image(arrowBackImage, width - 100, height - 100, 80, 80);

    //Check if it's the first time entering the room
    if (firstEntrance) {
      //Play the dialogue
      nearLockDialogue.Play();

      //Update the boolean
      firstEntrance = false;
    }
  }

  //buttons
  int correct1 = 3;
  int correct2 = 9;
  int correct3 = 7;

  int saved1 = 0;
  int saved2 = 0;
  int saved3 = 0;

  boolean isSaved1 = false;
  boolean isSaved2 = false;
  boolean isSaved3 = false;

  void lockPuzzle() {


    if (buttons!= null) {
      for (int  i = 0; i<buttons.length; i++) {
        //mouse hovers over
        if (CheckPointOnBoxCollision(mouseX, mouseY, 
          buttons[i].x, buttons[i].y, 
          buttons[i].w, buttons[i].h)) {
          keypadPress.play();
          if (isSaved1 != true) {
            saved1 = buttons[i].n;
            isSaved1 = true;
          } else if (isSaved2 != true) {
            saved2 = buttons[i].n;
            isSaved2 = true;
          } else if (isSaved3 != true) {
            saved3 = buttons[i].n;
            isSaved3 = true;
            if ((saved1 == correct1) && (saved2 == correct2) && (saved3 == correct3)) {
              transitionAreas = new SceneTransitionArea[]{
                new SceneTransitionArea("Hallway", 0, 0, 1000, 800), 
              };
              accepted.play();
            } else {
              isSaved1 = false;
              isSaved2 = false;
              isSaved3 = false;
              denied.play();
            }
          }
        }
      }
    }
  }
}


//diary
class Diary extends Scene {
  public Diary() {
    super("Diary.png", "Diary", false);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Bedroom 1", width - 100, height - 100, 80, 80), 
      new SceneTransitionArea("Diary page", width/2, 450, 300, 250)
    };
  }

  public void Draw() {
    super.Draw();
    image(arrowBackImage, width - 100, height - 100, 80, 80);
  }
}

//diary page
class DiaryPage extends Scene {
  public DiaryPage() {
    super("Diary_reading.png", "Diary page", false);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Diary", width - 100, height - 100, 80, 80), 
      new SceneTransitionArea("Diary page 2", 350, 55, 390, 520)
    };
  }

  public void Draw() {
    super.Draw();
    image(arrowBackImage, width - 100, height - 100, 80, 80);
  }
}
class DiaryPage2 extends Scene {
  public DiaryPage2() {
    super("Diary_reading2.png", "Diary page 2", false);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Diary page", width - 100, height - 100, 80, 80), 
      new SceneTransitionArea("Diary page 3", 350, 55, 390, 520)
    };
  }

  public void Draw() {
    super.Draw();
    image(arrowBackImage, width - 100, height - 100, 80, 80);
  }
}

class DiaryPage3 extends Scene {
  public DiaryPage3() {
    super("Diary_reading3.png", "Diary page 3", false);
    transitionAreas = new SceneTransitionArea[]{
      new SceneTransitionArea("Diary page 2", width - 100, height - 100, 80, 80), 
      new SceneTransitionArea("Diary", 350, 55, 390, 520)
    };
  }

  public void Draw() {
    super.Draw();
    image(arrowBackImage, width - 100, height - 100, 80, 80);
  }
}
