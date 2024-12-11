void Box(int x, int y, int w, int h, int c);
void Draw_Circle( int xc, int yc, int r, int c);
void Draw_Line(int xo, int yo, int x1,int y1, char color);
void Plot_Pixel_Fast(int x, int y, int c);
void Plot_8(int xc, int yc, int xcrd, int ycrd, int c);
void start(void);

unsigned char *video_buffer;
int  byte_line = 320;

void start(void)
{
video_buffer = (char *)0x1A0000;
Box(64, 67, 65, 66, 69);
Draw_Circle(128, 119, 50, 77);
Draw_Line(64,64,319,239,132);
Plot_Pixel_Fast(120,130,104);
}

void  Box(int x, int y, int w, int h, int c)
{
int i;
for ( i = x ; i < x+(w+1); i++ )
        {
        Plot_Pixel_Fast(i,y,c);
        Plot_Pixel_Fast(i,y+h,c);
        }
for (i = y ; i < y+(h+1); i++ )
        {
        Plot_Pixel_Fast(x,i,c);
        Plot_Pixel_Fast(x+w,i,c);
        }
}

void  Draw_Circle( int xc, int yc, int r, int c)
{
int     xcrd,ycrd,a,b,f,rn;
	xcrd = r;
	ycrd = 0;
	a = -2 * (xcrd + 1);
	b = 1;
	f = 0;
	while( b <= (-a))
	{
	Plot_8( xc, yc, xcrd, ycrd, c);
	ycrd = ycrd + 1;
	f = f + b;
		if(f > r)
		{
		f = f + a;
		a = a + 2;
		xcrd = xcrd - 1;
		}
	b = b + 2;
	}
}

void Draw_Line(int xo, int yo, int x1,int y1, char color)
{
int dx, dy, x_inc, y_inc, error = 0, index;
char  *vb_start = video_buffer;
vb_start = vb_start + ((int)yo<<6) +((int)yo<<8) +(int)xo;
dx = x1-xo;
dy = y1-yo;
if (dx>=0){x_inc = 1;}
else{x_inc = -1;
   dx    = -dx;}
if (dy>=0){y_inc = byte_line;}
else{y_inc = -byte_line;
   dy    = -dy;}
if (dx>dy)
   {
   for (index=0; index<=dx; index++)
       {*vb_start = color;
       error+=dy;
       if (error>dx){error-=dx;
	  vb_start+=y_inc;}
       vb_start+=x_inc;}
   }
else
   {
   for (index=0; index<=dy; index++)
       {*vb_start = color;
       error+=dx;
       if (error>0)
	  {error-=dy;
	  vb_start+=x_inc;}
       vb_start+=y_inc;}
   }
}

void Plot_Pixel_Fast(int x, int y, int c)
{
y = (y<<8) + (y<<6) + x;
if(y > 76799 || y < 0){return;}
video_buffer[y] = c;
}

void  Plot_8(int xc, int yc, int xcrd, int ycrd, int c)
{
  Plot_Pixel_Fast (ycrd + xc, xcrd + yc, c);        
  Plot_Pixel_Fast (-ycrd + xc, xcrd + yc, c+1);      
  Plot_Pixel_Fast (-ycrd + xc, -xcrd + yc, c+2);      
  Plot_Pixel_Fast (ycrd + xc, -xcrd + yc, c+3);       
  Plot_Pixel_Fast (xcrd + xc, -ycrd + yc, c);       
  Plot_Pixel_Fast (xcrd + xc, ycrd + yc, c);        
  Plot_Pixel_Fast (-xcrd + xc, ycrd + yc, c);       
  Plot_Pixel_Fast (-xcrd + xc, -ycrd + yc, c); }