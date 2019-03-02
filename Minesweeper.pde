import de.bezier.guido.*;
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
public final static int NUM_BOMBS=100;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs= new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
void setup ()
{ 
  size(400, 400);
  textAlign(CENTER, CENTER);
  // make the manager
  Interactive.make( this );
  buttons=new MSButton[NUM_ROWS][NUM_COLS];
  for (int r=0; r<NUM_ROWS; r++)
    for (int c=0; c<NUM_COLS; c++)
      buttons[r][c]=new MSButton(r, c);
  setBombs();
}
public void setBombs()
{
  while (bombs.size() < NUM_BOMBS)
  {
    int r=(int)(Math.random()*NUM_ROWS);
    int c=(int)(Math.random()*NUM_COLS);
    if (!bombs.contains(r)&&!bombs.contains(c))
    {
      bombs.add(buttons[r][c]);
    }
  }
}

public void draw ()
{
  background( 0 );
     for (int r=0; r<buttons.length; r++)
    for (int c=0; c<buttons[r].length; c++)
  if (isWon()&&buttons[r][c].clicked!=true)
    displayWinningMessage();
}
public boolean isWon()
{
 int count=0;
 int test =(NUM_ROWS*NUM_COLS)-NUM_BOMBS;

        for (int r=0; r<buttons.length; r++)
    for (int c=0; c<buttons[r].length; c++)
    if (!bombs.contains(buttons[r][c]))
        if(buttons[r][c].clicked)
        count++;
        // System.out.println("count:"+count);
      //   System.out.println("boolean for is Won:"+test);
        if(count == (NUM_ROWS*NUM_COLS)-NUM_BOMBS)
        return true;
  return false;
    
    }
public void displayLosingMessage()
{
  buttons[9][5].setLabel("Y");
  buttons[9][6].setLabel("o");
  buttons[9][7].setLabel("u");
  buttons[9][8].setLabel(" ");
  buttons[9][9].setLabel(" ");
  buttons[9][10].setLabel("L"); 
  buttons[9][11].setLabel("o");
  buttons[9][12].setLabel("s");
  buttons[9][13].setLabel("e");
  buttons[9][14].setLabel("!");
   for (int r=0; r<buttons.length; r++)
    for (int c=0; c<buttons[r].length; c++)
   buttons[r][c].clicked=true;
  
}
public void displayWinningMessage()
{
  buttons[9][6].setLabel("Y");
  buttons[9][7].setLabel("o");
  buttons[9][8].setLabel("u");
  buttons[9][9].setLabel(" ");
  buttons[9][10].setLabel("W"); 
  buttons[9][11].setLabel("i");
  buttons[9][12].setLabel("n");
  buttons[9][13].setLabel("!");
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager

  public void mousePressed () 
  {
    if (mouseButton == RIGHT && !clicked)
    {
      if (!marked)
        clicked=false;
      marked=!marked;
    }
    if (mouseButton == LEFT && !marked)

      clicked=true;    

    if (bombs.contains(this)) {
      displayLosingMessage();
    } else if (countBombs(this.r, this.c)>0)
      setLabel(""+countBombs(this.r, this.c));

    if (isValid(r, c-1) && !buttons[r][c-1].isClicked()&&countBombs(this.r, this.c)==0) {
     // System.out.println("1");
      buttons[r][c-1].mousePressed();
    }
    if (isValid(r-1, c) && !buttons[r-1][c].isClicked()&&countBombs(this.r, this.c)==0) {
     // System.out.println("2");
      buttons[r-1][c].mousePressed();
    }
    if (isValid(r, c+1) && !buttons[r][c+1].isClicked()&&countBombs(this.r, this.c)==0) {
     // System.out.println("3");
      buttons[r][c+1].mousePressed();
    }
    if (isValid(r+1, c) && !buttons[r+1][c].isClicked()&&countBombs(this.r, this.c)==0) {
     // System.out.println("4");
      buttons[r+1][c].mousePressed();
    }
  }

  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    if (r<20&&c<20&&r>=0&&c>=0)
      return true;
    return false;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    if (isValid(row, col-1)&&bombs.contains(buttons[row][col-1]))
      numBombs+=1;
    if (isValid(row, col+1)&&bombs.contains(buttons[row][col+1]))
      numBombs+=1;
    if (isValid(row+1, col+1)&&bombs.contains(buttons[row+1][col+1]))
      numBombs+=1;
    if (isValid(row+1, col-1)&&bombs.contains(buttons[row+1][col-1]))
      numBombs+=1;
    if (isValid(row-1, col)&&bombs.contains(buttons[row-1][col]))
      numBombs+=1;
    if (isValid(row+1, col)&&bombs.contains(buttons[row+1][col]))
      numBombs+=1;
    if (isValid(row-1, col-1)&&bombs.contains(buttons[row-1][col-1]))
      numBombs+=1;
    if (isValid(row-1, col+1)&&bombs.contains(buttons[row-1][col+1]))
      numBombs+=1;
    return numBombs;
  }
}
