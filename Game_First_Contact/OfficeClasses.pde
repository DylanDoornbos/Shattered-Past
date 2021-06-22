class Office1 extends Scene {
  private boolean firstEntrance = true;
  
  Dialogue sceneEnterConversation = new Dialogue(new String[]{
    "I felt nervous, like I was about to tell my biggest secret",
    "And who knows, maybe deep down this was my deepest secret, so secret that even I did not know it",
    "T: please start at the very beginning",
    "P: The beginning is a bit odd to explain, most of the time I'll be having a different dream, when suddenly, in that dream I fall to the ground",
    "T: Go on",
    "I close my eyes as  I try to remember everything in detail",
    "P: In my dream I always wake up in the same basement"
    });

  public Office1() {
    super("office.png", "Office", false);
  }
  
  public void Draw(){
    super.Draw();
    if(!firstEntrance && !Game_First_Contact.dialogueActive){
      ChangeScene("Basement 1");
    }
    
    if(firstEntrance){
      sceneEnterConversation.Play();
      firstEntrance = false;
    }
  }
}

class Office2 extends Scene {
  private boolean firstEntrance = true;
  
  Dialogue sceneEnterConversation2 = new Dialogue(new String[]{
    "T: I must admit I do not specialize in decyphering dreams but if this is a reoccurring nightmare, combined with everything you have told me, I do think there may be more to this",
    "P: I'm sorry I didn't know where else to go",
    "T: It's quite alright, but I do think you might want to involve police if you feel like it is really serious",
    "The conversation died out there, she adviced me to go look further, find articles, talk to police", 
    "I did, and as I dove further I realized that this was only the beginning of a long journey to figure out what happend in my past, and what actually lead to the death of my sister"
    });

  public Office2() {
    super("office.png", "Office ", false);
  }
  
  public void Draw(){
    super.Draw();
    
    super.Draw();
    if(!firstEntrance && !Game_First_Contact.dialogueActive){
      ChangeScene("   ");
    }
    
    if(firstEntrance){
      sceneEnterConversation2.Play();
      firstEntrance = false;
    }
  }
}
