package Blocks "Input/output block sublibrary"
extends Modelica.Icons.Library;


annotation (
  Coordsys(
    extent=[0, 0; 182, 147],
    grid=[1, 1],
    component=[20, 20]),
  Window(
    x=0.03,
    y=0.02,
    width=0.19,
    height=0.25,
    library=1,
    autolayout=1),
  Documentation(info="
<HTML>
<p>
Package <b>ModelicaAdditions.Blocks</b> contains
input/output blocks:
</p>

<pre>
   <b>Discrete</b>     Discrete control blocks
   <b>Logical</b>      Components operating on Boolean signals
   <b>Multiplexer</b>  Combine and split signal connectors of type Real
</pre>


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
<li><i>June 14, 2000</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
<br>


<p><b>Copyright (C) 2000, DLR.</b></p>

<p><i>
The ModelicaAdditions.Blocks package is <b>free</b> software;
it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>

</HTML>
"));
end Blocks;
