package Tables
  extends Modelica.Icons.Library;

  annotation (Documentation(info="<html>
<p>
This package contains components to <b>interpolate linearly</b> in <b>tables</b>.
Table data may optionally be read in from <b>files</b> (ASCII or Matlab-4
binary format). This package contains the following components:
</p>

<pre>
   <b>CombiTableTime</b>  Table look-up with time as abszissa
   <b>CombiTableTime2</b> Table look-up with time as abszissa and
                   linear/perodic extrapolation methods
   <b>CombiTable1D</b>    Table look-up in one dimension
   <b>CombiTable1Ds</b>   Table look-up in one dimension with
                   same input for different coloumns
   <b>CombiTable2D</b>    Table look-up in two dimensions
</pre>

<p>
This package is not part of the Modelica standard library, because it is
planned to realize a package with better and more general table support
based on a different design.
</p>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
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
<li><i>August 18, 2003</i>
by Hans Olsson, Dynasim
Added smoothness parameter
</li>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Added component CombiTable1Ds with single input and multiple output. Example updated.</li>

<li><i>March 31, 2001</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New component CombiTableTime2 (used CombiTableTime as a basis and added the
       arguments <b>extrapolation, columns, startTime</b>.
       This allows periodic function definitions). Bug fixed for CombiTableTime,
       when table is read from file and starting time is not within the first
       interval of the table.</li>

<li><i>June 11, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized based on an existing Dymola library of Martin Otter.</li>
</ul>
<br>


<p><b>Copyright &copy; 2000-2002, DLR.</b></p>

<p><i>
The ModelicaAdditions.Tables package is <b>free</b> software;
it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  package Examples "Demonstration examples for tables"
    extends Modelica.Icons.Library;

    encapsulated model allTables "Show usage of all tables"
      import Modelica.Icons;
      import Modelica.Blocks.Sources;
      import ModelicaAdditions.Tables;

      extends Icons.Example;

      parameter Real tab[:, :]=[2, 0.5, 1; 3, 2, 3; 4, 1, 2];
      parameter Real offset=10;
      parameter Real startTime=1;
      parameter Integer columns[:]={2,3};
      parameter Real tab2[:, :]=[-1, -1; 0, 0; 0, 1; 1, 2];
      parameter Real tab3[:, :]=[0, 0; 0, 1; 1, 2];

      annotation (
        experiment(StopTime=7),
        Documentation(info="<HTML>

<p>
The usage of the tables is demonstrated.
Simulate for 7 s. In the range 0..1 and 3..5, the table outputs
of table0, table1, table2 need to be identical. At the other
time instants, different extrapolation formula are used.
</p>

</HTML>


"),
        Diagram);
      Tables.CombiTableTime2 table0(
        table=tab,
        columns=columns,
        offset={offset},
        extrapolation={0},
        startTime={startTime}) annotation (extent=[-60, 60; -40, 80]);
      Tables.CombiTableTime2 table1(
        table=tab,
        columns=columns,
        offset={offset},
        extrapolation={1},
        startTime={startTime}) annotation (extent=[-60, 20; -40, 40]);
      Tables.CombiTableTime2 table2(
        table=tab,
        columns=columns,
        offset={offset},
        extrapolation={2},
        startTime={startTime}) annotation (extent=[-60, -20; -40, 0]);
      Tables.CombiTableTime combiTableTime(table=tab2) annotation (extent=[0,
            60; 20, 80]);
      Tables.CombiTable1D CombiTable1D1(table=[0, 0; 1, 1; 2, 4; 3, 9; 4, 16; 5
            , 25; 6, 36]) annotation (extent=[40, 20; 60, 40]);
      Tables.CombiTable1Ds CombiTable1Ds1(table=[0, 0, 0; 1, 1, 1; 2, 4, 8; 3,
            9, 27; 4, 16, 64; 5, 25, 125; 6, 36, 216], icol=2:3) annotation (
          extent=[40, -20; 60, 0]);
      Sources.Ramp Ramp1(height={10}, duration={10}) annotation (extent=[0, 20
            ; 20, 40]);
      Tables.CombiTable2D CombiTable2D1 annotation (extent=[40, -70; 60, -50]);
      Sources.Ramp Ramp2(height={10}, duration={10}) annotation (extent=[0, -50
            ; 20, -30]);
      Sources.Ramp Ramp3(height={10}, duration={10}) annotation (extent=[0, -90
            ; 20, -70]);
      Tables.CombiTableTime2 combiTableTime2(table=tab2) annotation (extent=[40
            , 60; 60, 80]);
    equation
      connect(Ramp1.outPort, CombiTable1D1.inPort) annotation (points=[22, 30;
            40, 30]);
      connect(Ramp1.outPort, CombiTable1Ds1.inPort) annotation (points=[22, 30
            ; 30, 30; 30, -10; 36, -10], style(color=3));
      connect(Ramp2.outPort, CombiTable2D1.inPort1) annotation (points=[22, -40
            ; 30, -40; 30, -54; 36, -54], style(color=3));
      connect(Ramp3.outPort, CombiTable2D1.inPort2) annotation (points=[22, -80
            ; 30, -80; 30, -66; 36, -66], style(color=3));
    end allTables;
  end Examples;

  model CombiTableTime "Table look-up with time as abszissa (matrix/file) "
    parameter Real table[:, :]=[0, 0; 1, 1]
      "table matrix (time = first column)";
    parameter String tableName="NoName"
      "table name on file or in function usertab(optional)";
    parameter String fileName="NoName" "file where matrix is stored (optional)"
      ;
    parameter Real icol[:]={2} "columns of table to be interpolated";
    parameter Integer smoothNess=0 "smoothness of table"
      annotation(choices(choice=0 "Linear segements",
                         choice=1 "Continuous derivative")) ;
    extends Modelica.Blocks.Interfaces.MO(final nout=size(icol, 1));
  protected
    Real tableID(start=0);
    annotation (
      Documentation(info="<html>
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
        Line(points=[-60, 40; -60, -40; 60, -40; 60, 40; 30, 40; 30, -40; -30,
              -40; -30, 40; -60, 40; -60, 20; 60, 20; 60, 0; -60, 0; -60, -20;
              60, -20; 60, -40; -60, -40; -60, 40; 60, 40; 60, -40], style(
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
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=30, fillPattern=1)
          ),
        Line(points=[60, 0; 100, 0]),
        Text(extent=[-100, 100; 100, 64], string=
              "1 dimensional linear table interpolation"),
        Line(points=[-54, 40; -54, -40; 54, -40; 54, 40; 28, 40; 28, -40; -28,
              -40; -28, 40; -54, 40; -54, 20; 54, 20; 54, 0; -54, 0; -54, -20;
              54, -20; 54, -40; -54, -40; -54, 40; 54, 40; 54, -40], style(
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
      tableID = dymTableTimeIni(time, smoothNess, tableName, fileName, table, 0.0);
    end when;

    /*Interpolate with respect to time.*/
    for i in 1:nout loop
      outPort.signal[i] = dymTableTimeIpo(tableID, icol[i], time);
    end for;

  end CombiTableTime;

  model CombiTableTime2
    "Table look-up with respect to time and linear/perodic extrapolation methods (data from matrix/file)"


    parameter Real table[:, :]=[0, 0; 1, 1]
      "table matrix (time = first column)";
    parameter String tableName="NoName"
      "table name on file or in function usertab(optional)";
    parameter String fileName="NoName" "file where matrix is stored (optional)"
      ;
    parameter Integer columns[:]=2:size(table, 2)
      "columns of table to be interpolated";
    parameter Real offset[:]={0} "Offsets of output signals";
    parameter Integer extrapolation[1](
      min={0},
      max={2}) = {1}
      "= 0/1/2 constant/last two points/periodic (SAME value for all columns only supported currently)"
      ;
    parameter SI.Time startTime[1]={0}
      "Output = offset for time < startTime (SAME value for all columns only supported currently)"
      ;
    parameter Integer smoothNess=0 "smoothness of table"
      annotation(choices(choice=0 "Linear segements",
                         choice=1 "Continuous derivative")) ;
    extends Modelica.Blocks.Interfaces.MO(final nout=max([size(columns, 1); size(offset, 1)]));

    final parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout
        )*offset[1] else offset);

    final parameter Integer tableID=tableTimeInit(0.0, startTime[1], smoothNess,
        extrapolation[1], tableName, fileName, table, 0);
    final parameter Real t_min=tableTimeTmin(tableID);
    final parameter Real t_max=tableTimeTmax(tableID);

    function tableTimeInit
      input Real timeIn;
      input Real startTime;
      input Integer ipoType;
      input Integer expoType;
      input String tableName;
      input String fileName;
      input Real table[:, :];
      input Integer colWise;
      output Integer tableID;
    external "C" tableID = dymTableTimeIni2(timeIn, startTime, ipoType,
        expoType, tableName, fileName, table, size(table, 1), size(table, 2),
        colWise);
    end tableTimeInit;

    function tableTimeIpo
      input Integer tableID;
      input Integer icol;
      input Real timeIn;
      output Real value;
    external "C" value = dymTableTimeIpo2(tableID, icol, timeIn);
    end tableTimeIpo;

    function tableTimeTmin
      input Integer tableID;
      output Real Tmin "minimum time value in table";
    external "C" Tmin = dymTableTimeTmin(tableID);
    end tableTimeTmin;

    function tableTimeTmax
      input Integer tableID;
      output Real Tmax "maximum time value in table";
    external "C" Tmax = dymTableTimeTmax(tableID);
    end tableTimeTmax;
    annotation (
      Documentation(info="<HTML>
<p>
<p>
This block generates an output signal by <b>linear interpolation</b> in
a table. The time points and function values are stored in a matrix
<b>table[i,j]</b>, where the first column table[:,1] contains the
time points and the other columns contain the data to be interpolated.
Via parameter <b>columns</b> it can be defined which columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that
2 output signals are present and that the first output is computed
by interpolation of column 2 and the second output is computed
by interpolation of column 4 of the table matrix.
The table interpolation has the following proporties:
</p>

<ul>
<li>The time points need to be <b>monotonically increasing</b>. </li>
<li><b>Discontinuities</b> are allowed, by providing the same
    time point twice in the table. </li>
<li>Values <b>outside</b> of the table range, are computed by
    <b>extrapolation</b>:
<pre>
  extrapolation = 0: hold the first or last value of the table,
                     if outside of the range.
                = 1: extrapolate through the last or first two
                     points of the table.
                = 2: periodically repeat the table data
                     (periodical function).
</pre></li>
<li>If the table has only <b>one row</b>, no interpolation is performed and
    the table values of this row are just returned.</li>
<li>Via parameters <b>startTime</b> and <b>offset</b> the curve defined
    by the table can be shifted both in time and in the ordinate value.
    The time instants stored in the table are therefore <b>relative</b>
    to <b>startTime</b>.
    If time < startTime, no interpolation is performed and the offsets
    are used as ordinate values. If vector <b>offset</b> has only
    one element, this element is added as offset to all values of the
    columns selected by <b>columns</b>.
<li>The table is implemented in a numerically sound way by
    generating <b>time events</b> at interval boundaries,
    in order to not integrate over a discontinuous or not differentiable
    points.
<li>For special applications it is sometimes needed to know the minimum
    and maximum time instant defined in the table as a parameter. For this
    reason parameters t_min and t_max are provided and can be access from
    the outside of the table object.
</li>
</ul>

<p>
Example:
</p>

<pre>
   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]; extrapolation = 1 (default)

If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e. extrapolation via last 2 points).
</pre>


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

<p><b>Release Notes:</b></p>
<ul>
<li><i>March 31, 2001</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Used CombiTableTime as a basis and added the
       arguments <b>extrapolation, columns, startTime</b>.
       This allows periodic function definitions. </li>
</ul>
</HTML>
"),
      Icon(
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, 68; -80, -80], style(color=8)),
        Line(points=[-90, -70; 82, -70], style(color=8)),
        Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-48, 70; 2, -50], style(
            color=7,
            fillColor=49,
            fillPattern=1)),
        Line(points=[-48, -50; -48, 70; 52, 70; 52, -50; -48, -50; -48, -20; 52
              , -20; 52, 10; -48, 10; -48, 40; 52, 40; 52, 70; 2, 70; 2, -51],
            style(color=0))),
      Diagram(
        Text(extent=[78, 18; 102, 6], string="y"),
        Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
              fillColor=8)),
        Line(points=[-80, 68; -80, -80], style(color=8)),
        Line(points=[-90, -70; 82, -70], style(color=8)),
        Polygon(points=[90, -70; 68, -62; 68, -78; 90, -70], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-20, 90; 20, -30], style(
            color=7,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-20, -30; -20, 90; 80, 90; 80, -30; -20, -30; -20, 0; 80,
              0; 80, 30; -20, 30; -20, 60; 80, 60; 80, 90; 20, 90; 20, -30],
            style(color=0)),
        Text(
          extent=[-77, -42; -38, -58],
          string="offset",
          style(color=9)),
        Polygon(points=[-31, -30; -33, -40; -28, -40; -31, -30], style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[-30, -70; -33, -60; -28, -60; -30, -70; -30, -70],
            style(
            color=8,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-31, -31; -31, -70], style(
            color=8,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-20, -30; -20, -70], style(color=8, pattern=2)),
        Text(
          extent=[-38, -70; 8, -88],
          string="startTime",
          style(color=9)),
        Line(points=[-20, -30; -80, -30], style(color=8, pattern=2)),
        Text(
          extent=[-73, 93; -41, 78],
          string="outPort",
          style(color=9)),
        Text(
          extent=[66, -81; 91, -93],
          string="time",
          style(color=9)),
        Text(
          extent=[-19, 83; 20, 68],
          string="time",
          style(color=0)),
        Text(
          extent=[31, 84; 74, 68],
          string="outPort",
          style(color=0)),
        Line(points=[50, 90; 50, -30], style(color=0)),
        Line(points=[80, 0; 100, 0]),
        Text(extent=[34, -30; 71, -42], string="columns")));
  equation
    for i in 1:nout loop
      outPort.signal[i] = p_offset[i] + tableTimeIpo(tableID, columns[i], time)
        ;
    end for;
  end CombiTableTime2;

  model CombiTable1D "Table look-up in one dimension (matrix/file) "
    parameter Real table[:, :]=[0, 0; 1, 1]
      "table matrix (grid = first column)";
    parameter String tableName="NoName"
      "table name on file or in function usertab(optional)";
    parameter String fileName="NoName" "file where matrix is stored (optional)"
      ;
    parameter Real icol[:]={2} "columns of table to be interpolated";
    parameter Integer smoothNess=0 "smoothness of table"
      annotation(choices(choice=0 "Linear segements",
                         choice=1 "Continuous derivative")) ;
    extends Modelica.Blocks.Interfaces.MIMOs(final n=size(icol, 1));
  protected
    Real tableID(start=0);
    annotation (
      Documentation(info="<html>
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
        Line(points=[-60, 40; -60, -40; 60, -40; 60, 40; 30, 40; 30, -40; -30,
              -40; -30, 40; -60, 40; -60, 20; 60, 20; 60, 0; -60, 0; -60, -20;
              60, -20; 60, -40; -60, -40; -60, 40; 60, 40; 60, -40], style(
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
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=30, fillPattern=1)
          ),
        Line(points=[-100, 0; -58, 0]),
        Line(points=[60, 0; 100, 0]),
        Text(extent=[-100, 100; 100, 64], string=
              "1 dimensional linear table interpolation"),
        Line(points=[-54, 40; -54, -40; 54, -40; 54, 40; 28, 40; 28, -40; -28,
              -40; -28, 40; -54, 40; -54, 20; 54, 20; 54, 0; -54, 0; -54, -20;
              54, -20; 54, -40; -54, -40; -54, 40; 54, 40; 54, -40], style(
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
      tableID = dymTableInit(1.0, smoothNess, tableName, fileName, table, 0.0);
    end when;

    for i in 1:n loop
      y[i] = if tableName=="NoName" and fileName=="NoName" and size(table,1)==1
          then table[1, integer(icol[i])] else dymTableIpo1(tableID, icol[i], u[i]);
    end for;
  end CombiTable1D;

  model CombiTable1Ds
    "Table look-up in one dimension (matrix/file) with only single input"
    parameter Real table[:, :]=[0, 0; 1, 1]
      "table matrix (grid = first column)";
    parameter String tableName="NoName"
      "table name on file or in function usertab(optional)";
    parameter String fileName="NoName" "file where matrix is stored (optional)"
      ;
    parameter Real icol[:]={2} "columns of table to be interpolated";
    parameter Integer smoothNess=0 "smoothness of table"
     annotation(choices(choice=0 "Linear segements",choice=1 "Continuous derivative"));
    extends Modelica.Blocks.Interfaces.SIMO(final nout=size(icol, 1));
  protected
    Real tableID(start=0);
    annotation (
      Documentation(info="<html>
<p>
<b>Linear interpolation</b> in <b>one</b> dimension of a <b>table</b>.
Via parameter <b>icol</b> it can be defined how many columns of the
table are interpolated. If, e.g., icol={2,4}, it is assumed that one input
and 2 output signals are present and that the first output interpolates
via column 2 and the second output interpolates via column 4 of the
table matrix.
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
        Line(points=[-60, 40; -60, -40; 60, -40; 60, 40; 30, 40; 30, -40; -30,
              -40; -30, 40; -60, 40; -60, 20; 60, 20; 60, 0; -60, 0; -60, -20;
              60, -20; 60, -40; -60, -40; -60, 40; 60, 40; 60, -40], style(
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
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=30, fillPattern=1)
          ),
        Line(points=[-100, 0; -58, 0]),
        Line(points=[60, 0; 100, 0]),
        Text(extent=[-100, 100; 100, 64], string=
              "1 dimensional linear table interpolation"),
        Line(points=[-54, 40; -54, -40; 54, -40; 54, 40; 28, 40; 28, -40; -28,
              -40; -28, 40; -54, 40; -54, 20; 54, 20; 54, 0; -54, 0; -54, -20;
              54, -20; 54, -40; -54, -40; -54, 40; 54, 40; 54, -40], style(
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
      tableID = dymTableInit(1.0, smoothNess, tableName, fileName, table, 0.0);
    end when;

    for i in 1:nout loop
      y[i] = if tableName=="NoName" and fileName=="NoName" and size(table,1)==1
          then table[1, integer(icol[i])] else dymTableIpo1(tableID, icol[i], u);
    end for;
  end CombiTable1Ds;

  model CombiTable2D "Table look-up in two dimensions (matrix/file) "
    extends Modelica.Blocks.Interfaces.SI2SO;
    parameter Real table[:, :]=[0, 0, 1; 0, 0, 1; 1, 1, 1]
      "table matrix (grid = first column/first row)";
    parameter String tableName="NoName"
      "table name on file or in function usertab(optional)";
    parameter String fileName="NoName" "file where matrix is stored (optional)"
      ;
    parameter Integer smoothNess=0 "smoothness of table"
     annotation(choices(choice=0 "Linear segements",choice=1 "Continuous derivative"));
    annotation (
      Documentation(info="<html>
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
        Line(points=[-60, 40; -60, -40; 60, -40; 60, 40; 30, 40; 30, -40; -30,
              -40; -30, 40; -60, 40; -60, 20; 60, 20; 60, 0; -60, 0; -60, -20;
              60, -20; 60, -40; -60, -40; -60, 40; 60, 40; 60, -40], style(
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
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=30, fillPattern=1)
          ),
        Line(points=[60, 0; 100, 0]),
        Text(extent=[-100, 100; 100, 64], string=
              "2 dimensional linear table interpolation"),
        Line(points=[-54, 40; -54, -40; 54, -40; 54, 40; 28, 40; 28, -40; -28,
              -40; -28, 40; -54, 40; -54, 20; 54, 20; 54, 0; -54, 0; -54, -20;
              54, -20; 54, -40; -54, -40; -54, 40; 54, 40; 54, -40], style(
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
      tableID = dymTableInit(2.0, smoothNess, tableName, fileName, table, 0.0);
    end when;

    y = dymTableIpo2(tableID, u1, u2);
  end CombiTable2D;
end Tables;
