
package jcurses.widgets;

import jcurses.util.Rectangle;

/***************************************************************************************************************************************************************
 * This class is a layout manager that works like as the <code>DefaultLayoutManager</code> with a difference: the painting rectangle is shared in many grid
 * cells and the constraints are stated not in real coordinates on the painting rectangle, but in 'grid-coordinates'
 */
public class GridLayoutManager implements LayoutManager, WidgetsConstants
{

  private final DefaultLayoutManager _defLayout = new DefaultLayoutManager();

  private WidgetContainer      _father    = null;

  private final int _width;
  private final int _height;

  private Grid _grid = null;

  public void bindToContainer(WidgetContainer container)
  {
    if ( _father != null )
    {
      throw new RuntimeException("Already bound!!!");
    }
    _father = container;
  }

  public void unbindFromContainer()
  {
    _father = null;
  }

  /**
   * The constructor
   * 
   * @param width the width of the grid ( in cells )
   * @param height the height of the grid ( in cells )
   *  
   */
  public GridLayoutManager(int width, int height)
  {
    _width = width;
    _height = height;
  }

  public void layout(Widget widget, Object constraint)
  {
    if ( ! ( constraint instanceof GridLayoutConstraint ) )
    {
      throw new RuntimeException("unknown constraint: " + constraint.getClass().getName());
    }

    Rectangle rect = ( _father.getClientArea() == null ) ? _father.getSize() : _father.getClientArea();
    _grid = new Grid(rect, _width, _height);
    _defLayout.layout(widget, ( (GridLayoutConstraint)constraint ).getDefaultLayoutConstraint(_grid));

  }

  /**
   * Adds a widget to the bounded container
   * 
   * @param widget widget to be added
   * @param x the x coordinate of the top left corner of the rectangle, within that the widget is placed
   * @param y the y coordinate of the top left corner of the rectangle, within that the widget is placed
   * @param width the width of the rectangle, within that the widget is placed
   * @param height the height of the rectangle, within that the widget is placed
   * @param verticalConstraint vertical alignment constraint. Following values a possible: <code>WidgetConstraints.ALIGNMENT_CENTER</code>,
   *          <code>WidgetConstraints.ALIGNMENT_TOP</code>,<code>WidgetConstraints.ALIGNMENT_BOTTOM</code>
   * @param horizontalConstraint vertical alignment constraint, Following values are possible: *<code>WidgetConstraints.ALIGNMENT_CENTER</code>,
   *          <code>WidgetConstraints.ALIGNMENT_LEFT</code>,<code>WidgetConstraints.ALIGNMENT_RIGHT</code>
   */
  public void addWidget(Widget widget, int x, int y, int width, int height, int verticalConstraint, int horizontalConstraint)
  {
    _father.addWidget(widget, new GridLayoutConstraint(x, y, width, height, horizontalConstraint, verticalConstraint));

  }

  /**
   * Removes a widget
   * 
   * @param widget widget to remove
   */
  public void removeWidget(Widget widget)
  {
    _father.removeWidget(widget);

  }
}

class GridLayoutConstraint
{

  int x;
  int y;
  int width;
  int height;
  int horizontalConstraint;
  int verticalConstraint;

  GridLayoutConstraint(int aX, int aY, int aWidth, int aHeight, int aHorizontalConstraint, int aVerticalConstraint)
  {
    this.x = aX;
    this.y = aY;
    this.width = aWidth;
    this.height = aHeight;
    this.horizontalConstraint = aHorizontalConstraint;
    this.verticalConstraint = aVerticalConstraint;
  }

  DefaultLayoutConstraint getDefaultLayoutConstraint(Grid grid)
  {

    Rectangle rect = grid.getRectangle(x, y, width, height);
    return new DefaultLayoutConstraint(rect.getX(), rect.getY(), rect.getWidth(), rect.getHeight(), horizontalConstraint, verticalConstraint);

  }

}

class Grid
{

  int[] _widths;
  int[] _heights;

  Grid(Rectangle rect, int width, int height)
  {
    if ( ( ( rect.getWidth() / width ) < 1 ) || ( ( rect.getHeight() / height ) < 1 ) )
    {
      throw new RuntimeException(" the grid is to fine: " + rect.getWidth() + ":" + rect.getHeight() + ":" + width + ":" + height);
    }

    _widths = new int[width];
    _heights = new int[height];

    fillArray(_widths, rect.getWidth(), width);
    fillArray(_heights, rect.getHeight(), height);

  }

  private void fillArray(int[] array, int rectWidth, int width)
  {
    int mod = rectWidth % width;
    int cellWidth = rectWidth / width;

    for ( int i = 0; i < width; i++ )
    {
      if ( mod > 0 )
      {
        array[i] = cellWidth + 1;
        mod--;
      }
      else
      {
        array[i] = cellWidth;
      }
    }

  }

  Rectangle getRectangle(int x, int y, int width, int height)
  {
    return new Rectangle(getWidth(_widths, 0, x), getWidth(_heights, 0, y), getWidth(_widths, x, x + width), getWidth(_heights, y, y + height));

  }

  private int getWidth(int[] array, int begin, int end)
  {
    int width = 0;
    for ( int i = begin; i < end; i++ )
    {
      width += array[i];
    }

    return width;
  }

}

