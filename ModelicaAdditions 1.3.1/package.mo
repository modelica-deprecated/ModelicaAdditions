package ModelicaAdditions "Collection of Modelica libraries of DLR"
extends Modelica.Icons.Library;

annotation (
  Coordsys(
    extent=[0, 0; 201, 361],
    grid=[1, 1],
    component=[20, 20]),
  Window(
    x=0.03,
    y=0.02,
    width=0.16,
    height=0.4,
    library=1,
    autolayout=1),
  Documentation(info="
<HTML>

<p>
Package <b>ModelicaAdditions</b> is a collection of libraries
which is supplied by DLR (Deutsches Zentrum f&uuml;r Luft- und Raumfahrt)
to provide often needed components which are missing in the Modelica
standard package. It is planned to provide the components of package
<b>ModelicaAdditions</b> in an improved form in a future version of
package <b>Modelica</b>. In the subpackages of ModelicaAdditions it
is explained why the corresponding sublibrary is not yet included
in package Modelica.
</p>

<p>
The ModelicaAdditions package is <b>free</b> software and can be redistributed
and/or modified under the terms of the Modelica License.
</p>

<p>
The ModelicaAdditions package consists currently of the following subpackages
</p>

<pre>
   <b>Blocks</b>      Additional input/output control blocks
               (operations on Boolean signals, discrete
               control blocks, multiplexer).
   <b>HeatFlow1D</b>  1-dimensional heat flow
   <b>MultiBody</b>   3D-mechanical systems
   <b>PetriNets</b>   Components to model simple state machines and petri nets
   <b>Tables</b>      Linear interpolation in one and two dimensions.
               Table data may be read from file.
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
<li><i>Version 1.3.1beta2 (June 20, 2000)</i><br>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized beta release.</li>
</ul>
<br>


<p><b>Copyright (C) 2000, DLR.</b></p>

<p><i>
The ModelicaAdditions package is <b>free</b> software;
it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
end ModelicaAdditions;
