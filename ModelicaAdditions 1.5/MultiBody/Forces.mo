package Forces
  "Force and torque elements for 3D mechanical components"

  extends Modelica.Icons.Library;

  annotation (Documentation(info="<html>
<p>
This package contains components to model forces and torques
in a 3D system.
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
<li><i>April 5, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
<br>

<p><b>Copyright &copy; 2000-2002, DLR.</b></p>

<p><i>
The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  model ExtForce "External force"
    extends Interfaces.ExtForceBase;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.18,
        y=0.01,
        width=0.8,
        height=0.82),
      Documentation(info="
An external force element exerts the inport signal
as negative force on frame_b.
"),
      Icon(Text(extent=[-120, 100; 122, 40], string="%name")));
    Modelica.Blocks.Interfaces.InPort inPort(final n=3) annotation (extent=[-110, -10; -90, 10]);
  equation
    frame_b.f = -inPort.signal;
  end ExtForce;

  model ExtTorque "External torque"
    extends Interfaces.ExtTorqueBase;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.18,
        y=0.17,
        width=0.64,
        height=0.74),
      Documentation(info="
An external torque element exerts the inport signals as
negative torque on frame_b.
"),
      Icon(Text(extent=[-120, -40; 122, -100], string="%name")));
    Modelica.Blocks.Interfaces.InPort inPort(final n=3) annotation (extent=[-110, -10; -90, 10]);
  equation
    frame_b.t = -inPort.signal;
  end ExtTorque;

  model ExtLineForce "External line force"
    extends Interfaces.ExtForceBase;
    parameter Real n[3]={1,0,0} "direction of force (frame_b.f=-n*u)";
    SI.Force u;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.21,
        y=0.05,
        width=0.77,
        height=0.78),
      Documentation(info="
External force acting at a specified, fixed direction on a body.

The value of the force has to be supplied as input signal to
this component using blocks of the block library.

Parameters:
  n(3): Direction of force. Vector is fixed in the body where this
        component is attached. The vector has to be given in frame_b.
"),
      Icon(Text(extent=[-120, 100; 122, 40], string="%name=%n")));
    Modelica.Blocks.Interfaces.InPort inPort(final n=1) annotation (extent=[-110, -10; -90, 10]);
  equation
    u = inPort.signal[1];
    frame_b.f = -n*u;
  end ExtLineForce;

  model ExtLineTorque "External line torque"
    extends Interfaces.ExtTorqueBase;
    parameter Real n[3]={1,0,0} "direction of torque (frame_b.t=-n*u)";
    SI.Torque u;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.22,
        y=0.31,
        width=0.6,
        height=0.6),
      Documentation(info="
External torque acting at a specified, fixed direction on a body.

The value of the torque has to be supplied as input signal to
this component using blocks of the block library.

Parameters:
  n(3): Direction of torque. Vector is fixed in the body where this
        component is attached. The vector has to be given in frame_b.
"),
      Icon(Text(extent=[-120, -40; 122, -100], string="%name=%n")));
    Modelica.Blocks.Interfaces.InPort inPort(final n=1) annotation (extent=[-110, -10; -90, 10]);
  equation
    u = inPort.signal[1];
    frame_b.t = -n*u;
  end ExtLineTorque;

  model Spring "Linear spring"
    parameter Real c(final unit="N/m", final min=0) "Spring constant";
    parameter SI.Length s0=0 "Unstretched spring length";
    extends Interfaces.LineForce;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.37,
        y=0.3,
        width=0.6,
        height=0.6),
      Documentation(info="
(Translational) linear spring.

Parameters:
  c : spring constant in [N/m]
  s0: length in [m], at which the spring force is zero

Note: Both cuts of a force element have ALWAYS to be connected at the cut
      of a joint, of a body or of the inertial system. It is not possible
      to e.g. connect two force elements in series.
"),
      Icon(Text(extent=[-100, 80; 98, 138], string="%name=%c"), Line(points=[-
              90, 0; -58, 0; -43, -30; -13, 30; 17, -30; 47, 30; 62, 0; 90, 0]
            , style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0))),
      Diagram(
        Line(points=[-68, 0; -68, 65], style(color=10)),
        Line(points=[72, 0; 72, 65], style(color=10)),
        Line(points=[-68, 60; 72, 60], style(color=10)),
        Polygon(points=[62, 63; 72, 60; 62, 57; 62, 63], style(color=10,
              fillColor=10)),
        Text(
          extent=[-22, 62; 18, 87],
          string="s",
          style(color=3)),
        Line(points=[-80, 0; -60, 0; -42, -32; -12, 30; 18, -30; 48, 28; 62, 0
              ; 80, 0])));
  equation
    f = c*(s - s0);
  end Spring;

  model Damper "Linear (velocity dependent) damper"
    parameter Real d(
      final unit="N.s/m",
      final min=0) = 0 "Damping constant";
    extends Interfaces.LineForce;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.32,
        y=0.29,
        width=0.6,
        height=0.6),
      Documentation(info="
Translational, velocity dependent, linear damper.

Parameters:
  d: damping constant in [N*s/m]

Note: Both cuts of a force element have ALWAYS to be connected at the cut
      of a joint, of a body or of the inertial system. It is not possible
      to e.g. connect two force elements in series.
"),
      Icon(
        Line(points=[-90, 0; -60, 0], style(color=0)),
        Line(points=[-60, -30; -60, 30], style(color=0)),
        Line(points=[-60, -30; 60, -30], style(color=0)),
        Line(points=[-60, 30; 60, 30], style(color=0)),
        Rectangle(extent=[-60, 30; 30, -30], style(color=0, fillColor=8)),
        Line(points=[30, 0; 90, 0], style(color=0)),
        Text(extent=[-98, 42; 100, 100], string="%name=%d")),
      Diagram(
        Line(points=[-90, 0; -60, 0], style(color=0)),
        Line(points=[-60, -30; -60, 30], style(color=0)),
        Line(points=[-60, -30; 60, -30], style(color=0)),
        Line(points=[-60, 30; 60, 30], style(color=0)),
        Rectangle(extent=[-60, 30; 30, -30], style(color=0, fillColor=8)),
        Line(points=[30, 0; 90, 0], style(color=0)),
        Line(points=[-50, 60; 50, 60], style(color=10)),
        Text(
          extent=[-20, 60; 10, 85],
          string="sd",
          style(color=10)),
        Polygon(points=[64, 60; 42, 68; 42, 52; 62, 60; 64, 60], style(
            color=10,
            fillColor=9,
            fillPattern=1))));
  equation
    f = d*sd;
  end Damper;

  model SpringDamperPar "Linear spring and linear damper in parallel"
    parameter Real c(final unit="N/m", final min=0) "Spring constant";
    parameter SI.Length s0=0 "Unstretched spring length";
    parameter Real d(
      final unit="N.s/m",
      final min=0) = 0 "Damping constant";
    extends Interfaces.LineForce;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.34,
        y=0.26,
        width=0.6,
        height=0.6),
      Documentation(info="
(Translational) linear spring and linear damper in parallel.

Parameters:
  c : spring constant in [N/m]
  s0: length in [m], at which the spring force is zero
  d : damping constant in [N*s/m]

Note: Both cuts of a force element have ALWAYS to be connected at the cut
      of a joint, of a body or of the inertial system. It is not possible
      to e.g. connect two force elements in series.
"),
      Icon(
        Text(extent=[-100, 80; 98, 138], string="%name=%c"),
        Line(points=[-80, 40; -60, 40; -45, 10; -15, 70; 15, 10; 45, 70; 60, 40
              ; 80, 40], style(color=0)),
        Line(points=[-80, 40; -80, -70], style(color=0)),
        Line(points=[-80, -70; -52, -70], style(color=0)),
        Rectangle(extent=[-52, -40; 38, -100], style(color=0, fillColor=8)),
        Line(points=[-52, -40; 68, -40], style(color=0)),
        Line(points=[-52, -100; 68, -100], style(color=0)),
        Line(points=[38, -70; 80, -70], style(color=0)),
        Line(points=[80, 40; 80, -70], style(color=0)),
        Line(points=[-90, 0; -80, 0], style(color=0)),
        Line(points=[80, 0; 90, 0], style(color=0)),
        Text(
          extent=[-101, -147; 98, -107],
          string="d=%d",
          style(color=0))),
      Diagram(
        Line(points=[-80, 32; -58, 32; -43, 2; -13, 62; 17, 2; 47, 62; 62, 32;
              80, 32], style(color=0, thickness=2)),
        Line(points=[-68, 32; -68, 97], style(color=10)),
        Line(points=[72, 32; 72, 97], style(color=10)),
        Line(points=[-68, 92; 72, 92], style(color=10)),
        Polygon(points=[62, 95; 72, 92; 62, 89; 62, 95], style(color=10,
              fillColor=10)),
        Text(
          extent=[-20, 72; 20, 97],
          string="s",
          style(color=3)),
        Rectangle(extent=[-52, -20; 38, -80], style(color=0, fillColor=8)),
        Line(points=[-52, -80; 68, -80], style(color=0)),
        Line(points=[-52, -20; 68, -20], style(color=0)),
        Line(points=[38, -50; 80, -50], style(color=0)),
        Line(points=[-80, -50; -52, -50], style(color=0)),
        Line(points=[-80, 32; -80, -50], style(color=0)),
        Line(points=[80, 32; 80, -50], style(color=0)),
        Line(points=[-90, 0; -80, 0], style(color=0)),
        Line(points=[90, 0; 80, 0], style(color=0))));
  equation
    f = c*(s - s0) + d*sd;
  end SpringDamperPar;

  model SpringDamperSer "Linear spring and linear damper in series connection"

    parameter Real c(final unit="N/m", final min=0) "Spring constant";
    parameter SI.Length s0=0 "Unstretched spring length";
    parameter Real d(
      final unit="N.s/m",
      final min=0) = 0 "Damping constant";
    extends Interfaces.LineForce;
    SI.Position x;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.3,
        y=0.15,
        width=0.6,
        height=0.75),
      Documentation(info="
(Translational) linear spring and linear damper in
series connection:

  cut a --> damper ----> spring --> cut b
        |              |
        |------ x -----|  (x is the state variable of this system)

Parameters:
  c : spring constant in [N/m]
  s0: length in [m], at which the spring force is zero
  d : damping constant in [N*s/m]

Terminal variables:
  x : length of damper in [m]. The spring length = s - x.

Note: Both cuts of a force element have ALWAYS to be connected at the cut
      of a joint, of a body or of the inertial system. It is not possible
      to e.g. connect two force elements in series.
"),
      Icon(
        Line(points=[-90, 0; -15, 0], style(color=0)),
        Line(points=[-60, -30; -15, -30], style(color=0)),
        Line(points=[-60, 30; -15, 30], style(color=0)),
        Rectangle(extent=[-60, 30; -30, -30], style(color=0, fillColor=8)),
        Line(points=[-15, 0; -5, 0; 5, -30; 25, 30; 45, -30; 65, 30; 75, 0; 90
              , 0], style(color=0)),
        Text(extent=[-100, 50; 100, 110], string="%name=%c"),
        Text(
          extent=[-100, -91; 99, -51],
          string="d=%d",
          style(color=0))),
      Diagram(
        Line(points=[-90, 0; -15, 0], style(color=0)),
        Line(points=[-60, -30; -15, -30], style(color=0)),
        Line(points=[-60, 30; -15, 30], style(color=0)),
        Rectangle(extent=[-60, 30; -30, -30], style(color=0, fillColor=8)),
        Line(points=[-15, 0; -5, 0; 5, -30; 25, 30; 45, -30; 65, 30; 75, 0; 90
              , 0], style(color=0)),
        Line(points=[-75, 0; -75, 85], style(color=9)),
        Line(points=[-10, 0; -10, 65], style(color=9)),
        Line(points=[80, 0; 80, 85], style(color=9)),
        Line(points=[-75, 80; 80, 80], style(color=9)),
        Line(points=[-75, 60; -10, 60], style(color=9)),
        Polygon(points=[-10, 60; -20, 65; -20, 55; -10, 60], style(
            color=9,
            fillColor=9,
            fillPattern=1)),
        Polygon(points=[80, 80; 70, 85; 70, 75; 80, 80], style(
            color=9,
            fillColor=9,
            fillPattern=1)),
        Text(
          extent=[-60, 60; -40, 80],
          string="x",
          style(color=9)),
        Text(
          extent=[0, 80; 20, 100],
          string="s",
          style(color=9))));
  equation
    f = c*(s - s0 - x);
    d*der(x) = f;
  end SpringDamperSer;
end Forces;
