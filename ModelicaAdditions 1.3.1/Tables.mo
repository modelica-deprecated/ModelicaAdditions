package Tables
  extends Modelica.Icons.Library;

  annotation (
    Coordsys(
      extent=[0, 0; 214, 326],
      grid=[1, 1],
      component=[20, 20]),
    Window(
      x=0.05,
      y=0.06,
      width=0.17,
      height=0.36,
      library=1,
      autolayout=1),
    Documentation(info="
<HTML>
<p>
This package contains components to <b>interpolate linearly</b> in <b>tables</b>.
Table data may optionally be read in from <b>files</b> (ASCII or Matlab-4
binary format). This package contains the following components:
</p>

<pre>
   <b>CombiTableTime</b>  Table look-up with time as abszissa
   <b>CombiTable1D</b>    Table look-up in one dimension
   <b>CombiTable2D</b>    Table look-up in two dimensions
</pre>

<p>
This package is not part of the Modelica standard library, because it is
planned to realize a package with better and more general table support
based on a different design.
</p>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 11, 2000</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized based on an existing Dymola library of Martin Otter.</li>
</ul>
<br>


<p><b>Copyright (C) 2000, DLR.</b></p>

<p><i>
The ModelicaAdditions.Tables package is <b>free</b> software;
it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  model CombiTableTime "Table look-up with time as abszissa (matrix/file) "
    parameter Real table[:, :]=[0, 0; 1, 1]
      "table matrix (time = first column)";
    parameter String tableName="NoName"
      "table name on file or in function usertab(optional)";
    parameter String fileName="NoName"
      "file where matrix is stored (optional)";
    parameter Real icol[:]={2} "columns of table to be interpolated";
    extends Modelica.Blocks.Interfaces.MO(final nout=size(icol, 1));
  protected
    Real tableID(start=0);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.29,
        y=0.02,
        width=0.61,
        height=0.73),
      Documentation(info="
<HTML>
<p>
<b>Linear interpolation</b> in a <b>table</b> with respect to <b>time</b>.
Via parameter <b>icol</b> it can be defined how many columns of the
table are interpolated. If, e.g., icol={2,4}, it is assumed that
2 output signals are present and that the first output is computed
by interpolation of column 2 and the second output is computed
by interpolation of column 4 of the table matrix.
</p>

<p>
The time points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the time points and the
other columns contain the data to be interpolated. Example:
</p>

<pre>
   table = [0,  0;
            1,  0;
            1,  1;
            2,  4;
            3,  9;
            4, 16]

  If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
      e.g., time = 1.5, the output y =  2.5,
      e.g., time = 2.0, the output y =  4.0,
      e.g., time = 5.0, the output y = 23.0 (i.e. extrapolation).
</pre>

<ul>
<li> If the table has only <b>one row</b>, the table value is returned,
     independently of time.</li>
<li> If time is <b>outside</b> of the defined <b>interval</b>, i.e.,
     time > table[size(table,1),1] or time < table[1,1], the corresponding
     value is also determined by linear
     interpolation through the last or first two points of the table.</li>
<li> <b>Two successive</b> time instants may be <b>identical</b>
     (see table example) to define a <b>discontinuous</b> point in the function.
     At every defined time instant of the table, a time event occurs in
     order to not integrate over a discontinuous or not differentiable point.
     From the discussion follows that the time values in the first column of
     the table have to be monotonically (but NOT strict monotonically) increasing.</li>
</ul>

<p>
The table matrix can be defined in the following ways:
</p>

<ol>
<li> Explicitly supplied as <b>parameter matrix</b> \"table\",
     and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>

<li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
      \"tableName\". Both ASCII and binary file format is possible.
      (the ASCII format is described below).
      It is most convenient to generate the binary file from Matlab
      (Matlab 4 storage format), e.g., by command
<pre>
   save tables.mat tab1 tab2 tab3 -V4
</pre>
      when the three tables tab1, tab2, tab3 should be
      used from the model.</li>

<li>  Statically stored in function \"usertab\" in file \"usertab.c\".
      The matrix is identified by \"tableName\". Parameter
      fileName = \"NoName\" or has only blanks.</li>
</ol>

<p>
Table definition methods (1) and (3) do <b>not</b> allocate dynamic memory,
and do not access files, whereas method (2) does. Therefore (1) and (3)
are suited for hardware-in-the-loop simulation (e.g. with dSpace hardware).
When the constant \"NO_FILE\" is defined, all parts of the
source code of method (2) are removed by the C-preprocessor, such that
no dynamic memory allocation and no access to files takes place.
</p>

<p>
If tables are read from an ASCII-file, the file need to have the
following structure (\"-----\" is not part of the file content):
</p>

<pre>
-----------------------------------------------------
#1
double tab1(6,2)   # comment line
  0   0
  1   0
  1   1
  2   4
  3   9
  4  16

double tab2(6,2)   # another comment line
  0   0
  2   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre>

<p>
Note, that the first two characters in the file need to be
\"#1\". Afterwards, the corresponding matrix has to be declared
with type, name and actual dimensions. Finally, in successive
rows of the file, the elements of the matrix have to be given.
Several matrices may be defined one after another.
</p>

</HTML>
"),
      Icon(
        Line(points=[-60, 40; -60, -40; 60, -40; 60, 40; 30, 40; 30, -40; -30
              , -40; -30, 40; -60, 40; -60, 20; 60, 20; 60, 0; -60, 0; -60, -20
              ; 60, -20; 60, -40; -60, -40; -60, 40; 60, 40; 60, -40], style(
              color=0)),
        Line(points=[0, 40; 0, -40], style(color=0)),
        Rectangle(extent=[-60, 40; -30, 20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-60, 20; -30, 0], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-60, 0; -30, -20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-60, -20; -30, -40], style(
            color=0,
            fillColor=6,
            fillPattern=1))),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=30, fillPattern=1
            )),
        Line(points=[60, 0; 100, 0]),
        Text(extent=[-100, 100; 100, 64], string=
              "1 dimensional linear table interpolation"),
        Line(points=[-54, 40; -54, -40; 54, -40; 54, 40; 28, 40; 28, -40; -28
              , -40; -28, 40; -54, 40; -54, 20; 54, 20; 54, 0; -54, 0; -54, -20
              ; 54, -20; 54, -40; -54, -40; -54, 40; 54, 40; 54, -40], style(
              color=0)),
        Line(points=[0, 40; 0, -40], style(color=0)),
        Rectangle(extent=[-54, 40; -28, 20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-54, 20; -28, 0], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-54, 0; -28, -20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-54, -20; -28, -40], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Text(extent=[-52, 56; -34, 44], string="time"),
        Text(extent=[2, 56; 26, 44], string="y"),
        Text(extent=[-2, -40; 30, -54], string="icol"),
        Text(extent=[66, 14; 90, 2], string="y")));
  equation
    when initial() then
      tableID = dymTableTimeIni(time, 0.0, tableName, fileName, table, 0.0);
    end when;

    /*Interpolate with respect to time.*/
    for i in 1:nout loop
      outPort.signal[i] = dymTableTimeIpo(tableID, icol[i], time);
    end for;

  end CombiTableTime;
  model CombiTable1D "Table look-up in one dimension (matrix/file) "
    parameter Real table[:, :]=[0, 0; 1, 1]
      "table matrix (grid = first column)";
    parameter String tableName="NoName"
      "table name on file or in function usertab(optional)";
    parameter String fileName="NoName"
      "file where matrix is stored (optional)";
    parameter Real icol[:]={2} "columns of table to be interpolated";
    extends Modelica.Blocks.Interfaces.MIMOs(final n=size(icol, 1));
  protected
    Real tableID(start=0);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.1,
        y=0.13,
        width=0.61,
        height=0.73),
      Documentation(info="
<HTML>
<p>
<b>Linear interpolation</b> in <b>one</b> dimension of a <b>table</b>.
Via parameter <b>icol</b> it can be defined how many columns of the
table are interpolated. If, e.g., icol={2,4}, it is assumed that 2 input
and 2 output signals are present and that the first output interpolates
the first input via column 2 and the second output interpolates the
second input via column 4 of the table matrix.
</p>

<p>
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>

<pre>
   table = [0,  0;
            1,  1;
            2,  4;
            4, 16]

   If, e.g., the input u = 1.0, the output y =  1.0,
       e.g., the input u = 1.5, the output y =  2.5,
       e.g., the input u = 2.0, the output y =  4.0,
       e.g., the input u =-1.0, the output y = -1.0 (i.e. extrapolation).
</pre>

<ul>
<li> The interpolation is <b>efficient</b>, because a search for a new interpolation
     starts at the interval used in the last call.</li>
<li> If the table has only <b>one row</b>, the table value is returned,
     independent of the value of the input signal.</li>
<li> If the input signal <b>u</b> is <b>outside</b> of the defined <b>interval</b>, i.e.,
     u > table[size(table,1),1] or u < table[1,1], the corresponding
     value is also determined by linear
     interpolation through the last or first two points of the table.</li>
<li> The grid values (first column) have to be <b>strict</b>
     monotonically increasing.</li>
</ul>

<p>
The table matrix can be defined in the following ways:
</p>

<ol>
<li> Explicitly supplied as <b>parameter matrix</b> \"table\",
     and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>

<li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
      \"tableName\". Both ASCII and binary file format is possible.
      (the ASCII format is described below).
      It is most convenient to generate the binary file from Matlab
      (Matlab 4 storage format), e.g., by command
<pre>
   save tables.mat tab1 tab2 tab3 -V4
</pre>
      when the three tables tab1, tab2, tab3 should be
      used from the model.</li>

<li>  Statically stored in function \"usertab\" in file \"usertab.c\".
      The matrix is identified by \"tableName\". Parameter
      fileName = \"NoName\" or has only blanks.</li>
</ol>

<p>
Table definition methods (1) and (3) do <b>not</b> allocate dynamic memory,
and do not access files, whereas method (2) does. Therefore (1) and (3)
are suited for hardware-in-the-loop simulation (e.g. with dSpace hardware).
When the constant \"NO_FILE\" is defined, all parts of the
source code of method (2) are removed by the C-preprocessor, such that
no dynamic memory allocation and no access to files takes place.
</p>

<p>
If tables are read from an ASCII-file, the file need to have the
following structure (\"-----\" is not part of the file content):
</p>

<pre>
-----------------------------------------------------
#1
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16

double tab2(5,2)   # another comment line
  0   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre>

<p>
Note, that the first two characters in the file need to be
\"#1\". Afterwards, the corresponding matrix has to be declared
with type, name and actual dimensions. Finally, in successive
rows of the file, the elements of the matrix have to be given.
Several matrices may be defined one after another.
</p>

</HTML>
"),
      Icon(
        Line(points=[-60, 40; -60, -40; 60, -40; 60, 40; 30, 40; 30, -40; -30
              , -40; -30, 40; -60, 40; -60, 20; 60, 20; 60, 0; -60, 0; -60, -20
              ; 60, -20; 60, -40; -60, -40; -60, 40; 60, 40; 60, -40], style(
              color=0)),
        Line(points=[0, 40; 0, -40], style(color=0)),
        Rectangle(extent=[-60, 40; -30, 20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-60, 20; -30, 0], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-60, 0; -30, -20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-60, -20; -30, -40], style(
            color=0,
            fillColor=6,
            fillPattern=1))),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=30, fillPattern=1
            )),
        Line(points=[-100, 0; -58, 0]),
        Line(points=[60, 0; 100, 0]),
        Text(extent=[-100, 100; 100, 64], string=
              "1 dimensional linear table interpolation"),
        Line(points=[-54, 40; -54, -40; 54, -40; 54, 40; 28, 40; 28, -40; -28
              , -40; -28, 40; -54, 40; -54, 20; 54, 20; 54, 0; -54, 0; -54, -20
              ; 54, -20; 54, -40; -54, -40; -54, 40; 54, 40; 54, -40], style(
              color=0)),
        Line(points=[0, 40; 0, -40], style(color=0)),
        Rectangle(extent=[-54, 40; -28, 20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-54, 20; -28, 0], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-54, 0; -28, -20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-54, -20; -28, -40], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Text(extent=[-52, 56; -34, 44], string="u"),
        Text(extent=[2, 56; 26, 44], string="y"),
        Text(extent=[-2, -40; 30, -54], string="icol"),
        Text(extent=[-98, 14; -80, 2], string="u"),
        Text(extent=[68, 14; 92, 2], string="y")));
  equation
    when initial() then
      tableID = dymTableInit(1.0, 0.0, tableName, fileName, table, 0.0);
    end when;

    for i in 1:n loop
      y[i] = dymTableIpo1(tableID, icol[i], u[i]);
    end for;
  end CombiTable1D;
  model CombiTable2D "Table look-up in two dimensions (matrix/file) "
    extends Modelica.Blocks.Interfaces.SI2SO;
    parameter Real table[:, :]=[0, 0, 1; 0, 0, 1; 1, 1, 1]
      "table matrix (grid = first column/first row)";
    parameter String tableName="NoName"
      "table name on file or in function usertab(optional)";
    parameter String fileName="NoName"
      "file where matrix is stored (optional)";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.35,
        y=0.08,
        width=0.64,
        height=0.68),
      Documentation(info="
<HTML>
<p>
<b>Linear interpolation</b> in <b>two</b> dimensions of a <b>table</b>.
The grid points and function values are stored in a matrix \"table[i,j]\",
where:
</p>

<ul>
<li> the first column \"table[2:,1]\" contains the u[1] grid points,</li>
<li> the first row \"table[1,2:]\" contains the u[2] grid points,</li>
<li> the other rows and columns contain the data to be interpolated.</li>
</ul>

<p>
Example:
</p>

<pre>
           |       |       |       |
           |  1.0  |  2.0  |  3.0  |  // u2
       ----*-------*-------*-------*
       1.0 |  1.0  |  3.0  |  5.0  |
       ----*-------*-------*-------*
       2.0 |  2.0  |  4.0  |  6.0  |
       ----*-------*-------*-------*
     // u1

   is defined as

      table = [0.0,   1.0,   2.0,   3.0;
               1.0,   1.0,   3.0,   5.0;
               2.0,   2.0,   4.0,   6.0]

   If, e.g. the input u is [1.0;1.0], the output y is 1.0,
       e.g. the input u is [2.0;1.5], the output y is 3.0.
</pre>

<ul>
<li> The interpolation is <b>efficient</b>, because a search for a new interpolation
     starts at the interval used in the last call.</li>
<li> If the table has only <b>one element</b>, the table value is returned,
     independent of the value of the input signal.</li>
<li> If the input signal <b>u</b> is <b>outside</b> of the defined <b>interval</b>,
     the corresponding value is also determined by linear
     interpolation through the last or first two points of the table.</li>
<li> The grid values (first column and first row) have to be <b>strict</b>
     monotonically increasing.</li>
</ul>

<p>
The table matrix can be defined in the following ways:
</p>

<ol>
<li> Explicitly supplied as <b>parameter matrix</b> \"table\",
     and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>

<li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
      \"tableName\". Both ASCII and binary file format is possible.
      (the ASCII format is described below).
      It is most convenient to generate the binary file from Matlab
      (Matlab 4 storage format), e.g., by command
<pre>
   save tables.mat tab1 tab2 tab3 -V4
</pre>
      when the three tables tab1, tab2, tab3 should be
      used from the model.</li>

<li>  Statically stored in function \"usertab\" in file \"usertab.c\".
      The matrix is identified by \"tableName\". Parameter
      fileName = \"NoName\" or has only blanks.</li>
</ol>

<p>
Table definition methods (1) and (3) do <b>not</b> allocate dynamic memory,
and do not access files, whereas method (2) does. Therefore (1) and (3)
are suited for hardware-in-the-loop simulation (e.g. with dSpace hardware).
When the constant \"NO_FILE\" is defined, all parts of the
source code of method (2) are removed by the C-preprocessor, such that
no dynamic memory allocation and no access to files takes place.
</p>

<p>
If tables are read from an ASCII-file, the file need to have the
following structure (\"-----\" is not part of the file content):
</p>

<pre>
-----------------------------------------------------
#1
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16

double tab2(5,2)   # another comment line
  0   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre>

<p>
Note, that the first two characters in the file need to be
\"#1\". Afterwards, the corresponding matrix has to be declared
with type, name and actual dimensions. Finally, in successive
rows of the file, the elements of the matrix have to be given.
Several matrices may be defined one after another.
</p>

</HTML>
"),
      Icon(
        Line(points=[-60, 40; -60, -40; 60, -40; 60, 40; 30, 40; 30, -40; -30
              , -40; -30, 40; -60, 40; -60, 20; 60, 20; 60, 0; -60, 0; -60, -20
              ; 60, -20; 60, -40; -60, -40; -60, 40; 60, 40; 60, -40], style(
              color=0)),
        Line(points=[0, 40; 0, -40], style(color=0)),
        Rectangle(extent=[-60, 20; -30, 0], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-60, 0; -30, -20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-60, -20; -30, -40], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-30, 40; 0, 20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[0, 40; 30, 20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[30, 40; 60, 20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Line(points=[-60, 40; -30, 20], style(color=0)),
        Line(points=[-30, 40; -60, 20], style(color=0))),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=30, fillPattern=1
            )),
        Line(points=[60, 0; 100, 0]),
        Text(extent=[-100, 100; 100, 64], string=
              "2 dimensional linear table interpolation"),
        Line(points=[-54, 40; -54, -40; 54, -40; 54, 40; 28, 40; 28, -40; -28
              , -40; -28, 40; -54, 40; -54, 20; 54, 20; 54, 0; -54, 0; -54, -20
              ; 54, -20; 54, -40; -54, -40; -54, 40; 54, 40; 54, -40], style(
              color=0)),
        Line(points=[0, 40; 0, -40], style(color=0)),
        Rectangle(extent=[-54, 20; -28, 0], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-54, 0; -28, -20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-54, -20; -28, -40], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[-28, 40; 0, 20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[0, 40; 28, 20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Rectangle(extent=[28, 40; 54, 20], style(
            color=0,
            fillColor=6,
            fillPattern=1)),
        Line(points=[-54, 40; -28, 20], style(color=0)),
        Line(points=[-28, 40; -54, 20], style(color=0)),
        Text(extent=[-54, -40; -30, -56], string="inPort1"),
        Text(extent=[28, 58; 52, 44], string="inPort2"),
        Text(extent=[-4, 12; 30, -22], string="outPort")));
  protected
    Real tableID(start=0);
  equation
    when initial() then
      tableID = dymTableInit(2.0, 0.0, tableName, fileName, table, 0.0);
    end when;

    y = dymTableIpo2(tableID, u1, u2);
  end CombiTable2D;
end Tables;
