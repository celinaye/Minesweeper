import de.bezier.guido.*;
public static final int NUM_ROWS = 20;
public static final int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>();
 //ArrayList of just the minesweeper buttons that are mined
 boolean win, lose = false;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make(this);
    
    //your code to declare and initialize buttons goes here
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int i = 0; i<NUM_ROWS; i++)
    {
        for(int j = 0; j<NUM_COLS; j++)
        {
            buttons[i][j] = new MSButton(i,j);
        }
    }
    for(int i = 0; i<50; i++)
    {
        setBombs();
    }
}
public void setBombs()
{
    int row = (int)(Math.random()*20);
    int col = (int)(Math.random()*20);
    if(!bombs.contains(buttons[row][col]))
    {
        bombs.add(buttons[row][col]);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
    {
        displayWinningMessage();
    }
}
public boolean isWon()
{
    for(int i = 0; i<bombs.size(); i++)
    {
        if(!bombs.get(i).isMarked())
        {
            return false;
        }
    }
    return true;
}
public void displayLosingMessage()
{
    lose = true;
    fill(0);
    textAlign(CENTER);
    for(int i = 0; i<buttons.length; i++)
    {
        if(bombs.get(i).isMarked()==false)
            bombs.get(i).clicked = true;
    }
    buttons[10][7].setLabel("Y");
    buttons[10][8].setLabel("O");
    buttons[10][9].setLabel("U");
    buttons[10][10].setLabel(" ");
    buttons[10][11].setLabel("L");
    buttons[10][12].setLabel("O");
    buttons[10][13].setLabel("S");
    buttons[10][14].setLabel("E");
    buttons[10][15].setLabel("!");
}
public void displayWinningMessage()
{
    win = true;
    fill(0);    
    textAlign(CENTER);
    buttons[10][7].setLabel("Y");
    buttons[10][8].setLabel("O");
    buttons[10][9].setLabel("U");
    buttons[10][10].setLabel(" ");
    buttons[10][11].setLabel("W");
    buttons[10][12].setLabel("I");
    buttons[10][13].setLabel("N");
    buttons[10][14].setLabel("!");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton (int rr, int cc)
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
        clicked = true;

        if(keyPressed == true && marked == true)
        {
            marked = false;
            clicked = false;
        }
        else if(keyPressed == true && marked == false)
        {
            marked = true;
            clicked = false;
        }
        else if(bombs.contains(this) == true)
        {
            displayLosingMessage();
        }
        else if(countBombs(r,c)>0)
        {
            setLabel(Integer.toString(countBombs(r,c)));
        }
        else
        {
            if(isValid(r+1,c+1) && buttons[r+1][c+1].isClicked()==false)
            {
                buttons[r+1][c+1].mousePressed();
            }
            if(isValid(r+1,c) && buttons[r+1][c].isClicked()==false)
            {
                buttons[r+1][c].mousePressed();
            }
            if(isValid(r+1,c-1) && buttons[r+1][c-1].isClicked()==false)
            {
                buttons[r+1][c-1].mousePressed();
            }
            if(isValid(r,c-1) && buttons[r][c-1].isClicked()==false)
            {
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r-1,c-1) && buttons[r-1][c-1].isClicked()==false)
            {
                buttons[r-1][c-1].mousePressed();
            }
            if(isValid(r,c-1) && buttons[r][c-1].isClicked()==false)
            {
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r-1,c+1) && buttons[r-1][c+1].isClicked()==false)
            {
                buttons[r-1][c+1].mousePressed();
            }
            if(isValid(r+1,c-1) && buttons[r+1][c-1].isClicked()==false)
            {
                buttons[r+1][c-1].mousePressed();
            }
        }
    }

    public void draw () 
    {    
        if(marked)
            fill(0);
        else if(clicked && bombs.contains(this)) 
            fill(255,0,0);
        else if(clicked)
            fill(200);
        else 
            fill(100);

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r>=0 && c>=0 && r<NUM_ROWS && c<NUM_COLS)
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;

        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
            numBombs++;
        
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs++;

        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
            numBombs++;

        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs++;

        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
            numBombs++;

        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs++;

        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
            numBombs++;

        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs++;

        return numBombs;
    }
}
