package Joints "Joints in the spanning tree"
  extends Modelica.Icons.Library;
  package SIunits = Modelica.SIunits ;

  annotation (
    Coordsys(
      extent=[0, 0; 259, 387],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.07,
      y=0.11,
      width=0.21,
      height=0.42,
      library=1,
      autolayout=1),
    Documentation(info="
<HTML>
<p>
This package contains elements to model ideal joints.
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
<li><i>April 5, 2000</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
<br>

<p><b>Copyright (C) 2000, DLR.</b></p>

<p><i>
The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  model Revolute "Revolute joint (1 degree-of-freedom, used in spanning tree)"


    extends MultiBody.Interfaces.TreeJoint;
    parameter Real n[3]={0,0,1}
      "Axis of rotation resolved in frame_a (= same as in frame_b)";
    parameter Real q0=0 "Rotation angle offset (see info) [deg]";
    parameter Boolean startValueFixed=false
      "true, if start values of q, qd are fixed";
    SIunits.Angle q(final fixed=startValueFixed);
    SIunits.AngularVelocity qd(final fixed=startValueFixed);
    SIunits.AngularAcceleration qdd;
    SIunits.Angle qq;
    Real nn[3];
    Real sinq;
    Real cosq;

    Modelica.Mechanics.Rotational.Interfaces.Flange_a axis annotation (extent=
          [10, 80; -10, 60]);
    Modelica.Mechanics.Rotational.Interfaces.Flange_b bearing annotation (
        extent=[-70, 80; -50, 60]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.05,
        y=0.09,
        width=0.65,
        height=0.69),
      Documentation(info="<HTML>
<p>
Joint where frame_b rotates around axis n which is fixed in frame_a.
The joint axis has an additional flange where it can be
driven with elements of the Modelica.Mechanics.Rotational library.
The relative angle q [rad] and the relative angular velocity
qd [rad/s] are used as state variables.
</p>

<p>
The following parameters are used to define the joint:
</p>
<pre>
  n : Axis of rotation resolved in frame_a (= same as in frame_b).
      n  must not necessarily be a unit vector. E.g.,
         n = {0, 0, 1} or n = {1, 0, 1}
  q0: Rotation angle offset in [deg].
      If q=q0, frame_a and frame_b are identical.
  startValueFixed: true, if start values of q, qd are fixed.
</pre>
</HTML>
"),
      Icon(
        Rectangle(extent=[-90, -60; -30, 60], style(
            color=8,
            gradient=2,
            fillColor=8)),
        Rectangle(extent=[30, -60; 90, 60], style(
            color=8,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-30, 10; 10, -10], style(
            color=0,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[10, 30; 30, 50; 30, -50; 10, -30; 10, 30], style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Text(extent=[-100, -138; 100, -79], string="%name=%n"),
        Line(points=[-20, 70; -50, 70], style(color=0)),
        Line(points=[-20, 80; -20, 60], style(color=0)),
        Line(points=[20, 80; 20, 60], style(color=0)),
        Line(points=[20, 70; 41, 70], style(color=0)),
        Rectangle(extent=[-10, 60; 10, 50], style(
            color=8,
            gradient=1,
            fillColor=8)),
        Polygon(points=[-10, 30; 10, 30; 30, 50; -30, 50; -10, 30], style(
            color=0,
            fillColor=8,
            fillPattern=1))),
      Diagram(
        Rectangle(extent=[-90, -60; -30, 60], style(
            color=8,
            gradient=2,
            fillColor=8)),
        Rectangle(extent=[30, -60; 90, 60], style(
            color=8,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-30, 10; 10, -10], style(
            color=0,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[10, 30; 30, 50; 30, -50; 10, -30; 10, 30], style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-20, 70; -50, 70], style(color=0)),
        Line(points=[-20, 80; -20, 60], style(color=0)),
        Line(points=[20, 80; 20, 60], style(color=0)),
        Line(points=[20, 70; 41, 70], style(color=0)),
        Polygon(points=[-10, 30; 10, 30; 30, 50; -30, 50; -10, 30], style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-10, 60; 10, 50], style(
            color=8,
            gradient=1,
            fillColor=8))));
  equation
    axis.phi = q;
    bearing.phi = 0;

    // define states
    qd = der(q);
    qdd = der(qd);

    /*rotation matrix*/
    nn = n/sqrt(n*n);
    qq = q - q0*PI/180;
    sinq = sin(qq);
    cosq = cos(qq);
    S_rel = [nn]*transpose([nn]) + (identity(3) - [nn]*transpose([nn]))*cosq
       - skew(nn)*sinq;

    /*other kinematic quantities*/
    r_rela = zeros(3);
    v_rela = zeros(3);
    a_rela = zeros(3);
    w_rela = nn*qd;
    z_rela = nn*qdd;

    /* Transform the kinematic quantities from frame_a to frame_b and the
     force and torque acting at frame_b to frame_a
     (= general equations of a "TreeJoint" specialized to this class).
  */
    Sb = Sa*transpose(S_rel);
    r0b = r0a;

    vb = S_rel*va;
    wb = S_rel*(wa + w_rela);

    ab = S_rel*aa;
    zb = S_rel*(za + z_rela + cross(wa, w_rela));

    fa = transpose(S_rel)*fb;
    ta = transpose(S_rel)*tb;

    // d'Alemberts principle
    axis.tau = nn*tb;
  end Revolute;
  model Prismatic
    "Prismatic joint (1 degree-of-freedom, used in spanning tree)"
    extends MultiBody.Interfaces.TreeJoint;
    parameter Real n[3]={1,0,0}
      "Axis of translation resolved in frame_a (= same as in frame_b)";
    parameter SIunits.Position q0=0 "Relative distance offset(see info)";
    parameter Boolean startValueFixed=false
      "true, if start values of q, qd are fixed";
    SIunits.Position q(final fixed=startValueFixed);
    SIunits.Velocity qd(final fixed=startValueFixed);
    SIunits.Acceleration qdd;
    SIunits.Position qq;
    Real nn[3];
    SIunits.Velocity vaux[3];

    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.2,
        y=0.01,
        width=0.55,
        height=0.64),
      Documentation(info="<HTML>
<p>
Joint where frame_b is translated around axis n which is fixed in frame_a.
The joint axis has an additional flange where it can be
driven with elements of the Modelica.Mechanics.Translational library.
The relative distance q [m] and the relative velocity qd [m] are
used as state variables.
</p>

<p>
The following parameters are used to define the joint:
</p>
<pre>
  n : Axis of translation resolved in frame_a (= same as in frame_b).
      n must not necessarily be a unit vector. E.g.,
         n = {0, 0, 1} or n = {1, 0, 1}
  q0: Relative distance offset in [m].
      (in the direction of n).
      If q=q0, frame_a and frame_b are identical.
  startValueFixed: true, if start values of q, qd are fixed.
</pre>
</HTML>
"),
      Icon(
        Rectangle(extent=[80, 70; 90, 30], style(
            color=0,
            fillColor=10,
            fillPattern=1)),
        Rectangle(extent=[-90, -50; -20, 40], style(pattern=0, fillColor=8)),
        Rectangle(extent=[-90, 40; -20, 50], style(
            pattern=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-20, -30; 90, 20], style(pattern=0, fillColor=8)),
        Rectangle(extent=[-20, 20; 90, 30], style(
            pattern=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-20, -50; -20, 50], style(color=0)),
        Text(extent=[-100, -129; 100, -69], string="%name=%n")),
      Diagram(
        Rectangle(extent=[-90, -50; -20, 40], style(pattern=0, fillColor=8)),
        Rectangle(extent=[-90, 40; -20, 50], style(
            pattern=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-20, -30; 90, 20], style(pattern=0, fillColor=8)),
        Rectangle(extent=[-20, 20; 90, 30], style(
            pattern=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-20, -50; -20, 50], style(color=0)),
        Rectangle(extent=[80, 70; 90, 30], style(
            color=9,
            fillColor=10,
            fillPattern=1)),
        Text(extent=[32, 81; 47, 66], string="f"),
        Line(points=[30, 65; 60, 65], style(color=3)),
        Polygon(points=[-10, 68; -20, 65; -10, 62; -10, 68], style(color=3,
              fillColor=3)),
        Line(points=[10, 65; -20, 65], style(color=3)),
        Text(extent=[-10, 80; 5, 65], string="f"),
        Polygon(points=[50, 68; 60, 65; 50, 62; 50, 68], style(color=3,
              fillColor=3)),
        Polygon(points=[50, 58; 60, 55; 50, 52; 50, 58], style(color=3,
              fillColor=3)),
        Line(points=[-19, 55; 51, 55]),
        Text(extent=[5, 54; 36, 44], string="q = axis.s")));
    Modelica.Mechanics.Translational.Interfaces.Flange_a axis annotation (
        extent=[60, 70; 80, 50]);
    Modelica.Mechanics.Translational.Interfaces.Flange_b bearing annotation (
        extent=[-20, 70; -40, 50]);
  equation
    axis.s = q;
    bearing.s = 0;

    // define states
    qd = der(q);
    qdd = der(qd);

    /*normalize axis vector*/
    nn = n/sqrt(n*n);

    /*kinematic quantities*/
    S_rel = identity(3);
    qq = q - q0;
    r_rela = nn*qq;
    v_rela = nn*qd;
    a_rela = nn*qdd;
    w_rela = zeros(3);
    z_rela = zeros(3);

    /* Transform the kinematic quantities from frame_a to frame_b and the
     force and torque acting at frame_b to frame_a
     (= general equations of a "TreeJoint" specialized to this class).
  */
    Sb = Sa;
    r0b = r0a + Sa*r_rela;

    vaux = cross(wa, r_rela);
    vb = va + v_rela + vaux;
    wb = wa;

    ab = aa + a_rela + cross(za, r_rela) + cross(wa, vaux + 2*v_rela);
    zb = za;

    fa = fb;
    ta = tb + cross(r_rela, fa);

    // d'Alemberts principle
    axis.f = nn*fb;
  end Prismatic;
  model Screw "Screw joint (1 degree-of-freedom, used in spanning tree)"
    extends MultiBody.Interfaces.TreeJoint;
    parameter Real n[3]={1,0,0} "Screw axis resolved in frame_a and frame_b";
    parameter SIunits.Length R=0.01 "Screw radius";
    parameter Real slope=1 "Screw slope in [deg] (slope>0)";
    parameter Real q0=0 "Screw axis angle offset in [deg]";
    SIunits.Angle q(start=0, fixed=true);
    SIunits.AngularVelocity qd(start=0, fixed=true);
    SIunits.AngularAcceleration qdd;
    Real nn[3];
    Real nt[3];
    Real sinq;
    Real cosq;
    Real ri;
    Real vaux[3];
    Real qq;

    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.19,
        y=0,
        width=0.63,
        height=0.71),
      Documentation(info="<HTML>
<p>
Joint where frame_b rotates around axis n which is fixed in frame_a
and at the same time is translated around the same axis. The rotational
and translational movement are coupled by a fixed factor.
The joint axis has an additional flange where it can be
driven with elements of the Modelica.Mechanics.Rotational library.
The relative angle q [rad] and the relative angular velocity
qd [rad/s] are used as state variables.
</p>

<p>
The following parameters are used to define the joint:
</p>
<pre>
  n    : Axis of rotation resolved in frame_a (= same as in frame_b).
         n  must not necessarily be a unit vector. E.g.,
            n = {0, 0, 1} or n = {1, 0, 1}
  q0   : Rotation angle offset in [deg].
         If q=q0, frame_a and frame_b are identical.
  R    : Radius of the screw in [m].
  slope: Slope of the screw in [deg].
         (relative distance = (q-q0)*R*tan( slope*PI/180 ))
  startValueFixed: true, if start values of q, qd are fixed.
</pre>
</HTML>
"),
      Icon(
        Rectangle(extent=[-90, -60; -30, 60], style(
            color=8,
            gradient=2,
            fillColor=8)),
        Rectangle(extent=[-10, 60; 10, 50], style(
            color=8,
            gradient=1,
            fillColor=8)),
        Text(extent=[-100, -129; 100, -70], string="%name=%n"),
        Ellipse(extent=[-16, 54; 18, 20], style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-30, 20; 90, -20], style(
            color=0,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[-20, 20; -8, 20; 4, -20; -8, -20; -20, 20], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[22, 20; 34, 20; 46, -20; 34, -20; 22, 20], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[64, 20; 76, 20; 88, -20; 76, -20; 64, 20], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Ellipse(extent=[-2, 40; 4, 34], style(
            color=0,
            fillColor=0,
            fillPattern=1))),
      Diagram(
        Rectangle(extent=[-90, -60; -30, 60], style(
            color=8,
            gradient=2,
            fillColor=8)),
        Rectangle(extent=[-10, 60; 10, 50], style(
            color=8,
            gradient=1,
            fillColor=8)),
        Rectangle(extent=[-30, 20; 90, -20], style(
            color=0,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-20, 80; -20, 60], style(color=0)),
        Line(points=[-20, 70; -50, 70], style(color=0)),
        Line(points=[20, 80; 20, 60], style(color=0)),
        Line(points=[20, 70; 41, 70], style(color=0)),
        Ellipse(extent=[-16, 54; 18, 20], style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[-20, 20; -8, 20; 4, -20; -8, -20; -20, 20], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[22, 20; 34, 20; 46, -20; 34, -20; 22, 20], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[64, 20; 76, 20; 88, -20; 76, -20; 64, 20], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Ellipse(extent=[-2, 40; 4, 34], style(
            color=0,
            fillColor=0,
            fillPattern=1))));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a axis annotation (extent=
          [10, 80; -10, 60]);
    Modelica.Mechanics.Rotational.Interfaces.Flange_b bearing annotation (
        extent=[-70, 80; -50, 60]);
  equation
    axis.phi = q;
    bearing.phi = 0;

    // define states
    qd = der(q);
    qdd = der(qd);

    /*rotation matrix*/
    nn = n/sqrt(n*n);
    qq = q - q0*PI/180;
    sinq = sin(qq);
    cosq = cos(qq);
    S_rel = [nn]*transpose([nn]) + (identity(3) - [nn]*transpose([nn]))*cosq
       - skew(nn)*sinq;

    /*other kinematic quantities*/
    ri = R*tan(slope*PI/180);
    nt = nn*ri;
    r_rela = nt*qq;
    v_rela = nt*qd;
    a_rela = nt*qdd;

    w_rela = nn*qd;
    z_rela = nn*qdd;

    /*Transform the kinematic quantities from frame_a to frame_b and the
 force and torque acting at frame_b to frame_a
 (= general equations of a "TreeJoint" specialized to this class).
*/
    Sb = Sa*transpose(S_rel);
    r0b = r0a + Sa*r_rela;

    vaux = cross(wa, r_rela);
    vb = S_rel*(va + v_rela + vaux);
    wb = S_rel*(wa + w_rela);

    ab = S_rel*(aa + a_rela + cross(za, r_rela) + cross(wa, vaux + 2*v_rela));
    zb = S_rel*(za + z_rela + cross(wa, w_rela));

    fa = transpose(S_rel)*fb;
    ta = transpose(S_rel)*tb + cross(r_rela, fa);

    // d'Alemberts principle
    axis.tau = nn*tb + nt*fb;
  end Screw;
  model Cylindrical
    "Cylindrical joint (2 degrees-of-freedom, used in spanning tree)"
    extends MultiBody.Interfaces.TwoTreeFrames;
    parameter Real n[3]={1,0,0}
      "Cylinder axis resolved in frame_a (= same as in frame_b)";
    parameter SIunits.Position qt0=0 "Distance offset (see info)";
    parameter Real qr0=0 "Rotation angle offset (see info) in [deg]";
    parameter Boolean startValueFixed=false
      "true, if start values of q, qd are fixed";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.33,
        y=0.08,
        width=0.67,
        height=0.7),
      Documentation(info="<HTML>
<p>
Joint where frame_b rotates around axis n which is fixed in frame_a
and translates independently around the same axis.
The relative angle revolute.q [rad], the relative distance
prismatic.q [m], the relative angular velocity revolute.qd [rad/s]
and the relative velocity prismatic.qd [m/s] are used as state variables.
</p>

<p>
The following parameters are used to define the joint:
</p>
  n    : Axis of cylindrical joint resolved in frame_a (= same as in frame_b).
         n  must not necessarily be a unit vector.
  qt0  : If revolute.q=qr0 and prismatic.q=qt0,
  qr0    frame_a and frame_b are identical.
  startValueFixed: true, if start values of q, qd are fixed.
</pre>
</HTML>
"),
      Icon(
        Rectangle(extent=[-90, -50; 0, 50], style(
            color=0,
            gradient=2,
            fillColor=8)),
        Rectangle(extent=[0, -30; 90, 30], style(
            color=0,
            gradient=2,
            fillColor=8)),
        Rectangle(extent=[0, 20; 90, 30], style(
            color=0,
            pattern=0,
            fillColor=0)),
        Line(points=[0, -50; 0, 50], style(color=0)),
        Text(extent=[-99, -120; 101, -60], string="%name=%n")));
    MultiBody.Joints.Prismatic prismatic(
      n=n,
      q0=qt0,
      startValueFixed=startValueFixed) annotation (extent=[-65, -25; -10, 25])
      ;
    MultiBody.Joints.Revolute revolute(
      n=n,
      q0=qr0,
      startValueFixed=startValueFixed) annotation (extent=[11, -25; 66, 25]);
  equation
    connect(frame_a, prismatic.frame_a) annotation (points=[-105, 0; -66.375
          , 0]);
  equation
    connect(prismatic.frame_b, revolute.frame_a) annotation (points=[-8.625
          , 0; 9.625, 0]);
  equation
    connect(revolute.frame_b, frame_b) annotation (points=[67.375, 0; 105, 0
          ]);
  end Cylindrical;
  model Universal
    "Universal joint (2 degrees-of-freedom, used in spanning tree)"
    extends MultiBody.Interfaces.TwoTreeFrames;
    parameter Real nx[3]={1,0,0}
      "Axis of revolute joint 1 resolved in frame_a";
    parameter Real ny[3]={0,1,0}
      "Axis of revolute joint 2 resolved in frame_b";
    parameter Real qx0=0
      "Rotation angle offset in direction of nx (see info) in [deg]";
    parameter Real qy0=0
      "Rotation angle offset in direction of ny (see info) in [deg]";
    parameter Boolean startValueFixed=false
      "true, if start values of q, qd are fixed";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.11,
        y=0.09,
        width=0.65,
        height=0.77),
      Documentation(info="<HTML>
<p>
Joint where frame_a rotates around axis nx which is fixed in frame_a
and at the same time rotates around axis ny which is fixed in frame_b.
The relative angles revolute1.q, revolute2.q [rad] and the relative
angular velocities revolute1.qd, revolute2.qd [rad/s] are used as
state variables.
</p>

<p>
The following parameters are used to define the joint:
</p>
<pre>
  nx : Axis of rotation 1 resolved in frame_a.
       nx must not necessarily be a unit vector. E.g.,
          nx = {0, 0, 1} or nx = {1, 0, 1}
  ny : Axis of rotation 2 resolved in frame_b.
       ny must not necessarily be a unit vector. E.g.,
          ny = {0, 0, 1} or ny = {1, 0, 1}
  qx0: Rotation angle offset 1 in [deg].
  qy0: Rotation angle offset 2 in [deg].
       If revolute1.q=qx0 and revolute2.q=qy0,
       frame_a and frame_b are identical.
  startValueFixed: true, if start values of q, qd are fixed.
</pre>
</HTML>

"),
      Icon(
        Rectangle(extent=[-90, 50; 40, -50], style(
            color=8,
            gradient=2,
            fillColor=8)),
        Ellipse(extent=[90, 50; -10, -50], style(color=8, fillColor=8)),
        Text(extent=[-100, -70; 100, -130], string="%name")));
    MultiBody.Joints.Revolute revolute1(
      n=nx,
      q0=qx0,
      startValueFixed=startValueFixed) annotation (extent=[-62, -25; -11, 25])
      ;
    MultiBody.Joints.Revolute revolute2(
      n=ny,
      q0=qy0,
      startValueFixed=startValueFixed) annotation (extent=[10, 20; 60, 70],
        rotation=90);
  equation
    connect(frame_a, revolute1.frame_a) annotation (points=[-105, 0; -63.275
          , 0]);
  equation
    connect(revolute2.frame_b, frame_b) annotation (points=[35, 71.25; 35,
          90; 70, 90; 70, 0; 105, 0]);
  equation
    connect(revolute1.frame_b, revolute2.frame_a) annotation (points=[-9.725
          , 0; 35, 0; 35, 18.75]);
  end Universal;
  model Planar "Planar joint (3 degrees-of-freedom, used in spanning tree)"
    extends MultiBody.Interfaces.TwoTreeFrames;
    parameter Real n[3]={0,0,1}
      "Axis perpendicular to plane resolved in frame_a (= same as in frame_b)";
    parameter Real nx[3]={1,0,0} "x-translation axis resolved in frame_a";
    parameter SIunits.Position qx0=0
      "Distance offset in nx direction (see info)";
    parameter SIunits.Position qy0=0
      "Distance offset in ny direction (see info)";
    parameter Real qr0=0 "Rotation angle offset (see info) in [deg]";
    parameter Boolean startValueFixed=false
      "true, if start values of q, qd are fixed";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.17,
        y=0.04,
        width=0.74,
        height=0.81),
      Documentation(info="<HTML>
<p>
Joint where frame_b can move in a plane and can rotation around an
axis perpendicular to the plane. The plane is defined by
vector n which is perpendicular to the plane and by vector nx,
which points in the direction of the x-axis of the plane.
The relative distances prismatic1.q, prismatic2.q [m] and
the relative rotation angle revolute.q [rad], as well as
the relative velocities prismatic1.qd, prismatic1.qd [m/s],
and the relative angular velocity revolute.qd [rad/s]
are used as state variables.
</p>

<p>
The following parameters are used to define the joint:
</p>
  n    : Axis perpendicular to plane resolved in frame_a (= same as in frame_b)
         n must not necessarily be a unit vector. E.g.,
            n = {0, 0, 1} or n = {1, 0, 1}
  qx0  : If prismatic1.q0=qx0, prismatic2.q0=qy0 and
  qy0    revolute.q=qr0, frame_a and frame_b are identical.
  qr0
  startValueFixed: true, if start values of q, qd are fixed.
</pre>
</HTML>
"),
      Icon(
        Rectangle(extent=[-30, -50; -10, 50], style(
            color=0,
            pattern=0,
            fillColor=8)),
        Rectangle(extent=[10, -30; 30, 30], style(
            color=0,
            pattern=0,
            fillColor=8)),
        Rectangle(extent=[-90, -10; -30, 10], style(
            color=0,
            pattern=0,
            fillColor=8)),
        Rectangle(extent=[90, -10; 30, 10], style(
            color=0,
            pattern=0,
            fillColor=8)),
        Text(extent=[-101, -131; 99, -71], string="%name=%n")));
    MultiBody.Joints.Prismatic prismatic1(
      n=(cross(cross(n, nx), n)),
      q0=qx0,
      startValueFixed=startValueFixed) annotation (extent=[-69, -20; -29, 20])
      ;
    MultiBody.Joints.Prismatic prismatic2(
      n=(cross(n, nx)),
      q0=qy0,
      startValueFixed=startValueFixed) annotation (extent=[-20, 30; 20, 70],
        rotation=90);
    MultiBody.Joints.Revolute revolute(
      n=n,
      q0=qr0,
      startValueFixed=startValueFixed) annotation (extent=[40, -20; 80, 20]);
  equation
    connect(frame_a, prismatic1.frame_a) annotation (points=[-105, 0; -70, 0
          ]);
  equation
    connect(prismatic1.frame_b, prismatic2.frame_a) annotation (points=[-28
          , 0; 0, 0; -1.11022e-015, 29]);
  equation
    connect(prismatic2.frame_b, revolute.frame_a) annotation (points=[
          1.11022e-015, 71; 0, 80; 30, 80; 30, 0; 39, 0]);
  equation
    connect(revolute.frame_b, frame_b) annotation (points=[81, 0; 105, 0]);
  end Planar;
  model Spherical
    "Spherical joint described by three Cardan angles (3 degrees-of-freedom, used in spanning tree)"



      // S_rel needs a correct start value, because pre(S_rel) is referenced below
    extends MultiBody.Interfaces.TreeJoint(S_rel(start=identity(3)));
    SIunits.Angle phi[3](fixed={true,true,true})
      "Cardan angles from a frame fixed in frame_a to frame_b";

  protected
    constant Real phi2_critical_deg=80
      "angle in [deg] too close to singularity. Redefine S_fix and phi";
    constant Real phi2_critical=phi2_critical_deg*Modelica.Constants.pi/180.0;
    constant Real c2_small=1.e-5
      "if cos(phi[2]) < c2_small, c2_small is used as guard against zero division"
      ;
    Real s1;
    Real s2;
    Real s3;
    Real c1;
    Real c2;
    Real c2a;
    Real c3;
    Boolean switch_state;
    Real S_phi[3, 3] "S_rel = S_phi(phi)*S_fix";
    discrete Real S_fix[3, 3](start=identity(3)) "S_rel = S_phi(phi)*S_fix";
    SIunits.AngularVelocity w_fix[3]
      "Relative angular velocity resolved in intermediate frame S_fix";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.02,
        y=0.16,
        width=0.65,
        height=0.79),
      Documentation(info="<HTML>
<p>
Joint where the origins of frame_a and frame_b always coincide, and
the frames are rotating against each other. The joint is realized in
such a way, that a singularity cannot occur. This is achieved because
the Cardan angles are defined between a frame_fix fixed in frame_a and
frame_b. Whenever the Cardan angles are near a singularity, the
integration is stopped and frame_fix is changed, such that the Cardan
angles are far away from the singularity. The following state
variables are used:
</p>

<pre>
  phi[3]   : Cardan angles, also called Tait-Bryan angles, i.e.,
             rotate around 1-, 2-, 3-axis in [rad] from intermediate
             frame_fix, which is fixed in frame_a, to frame_b. Initially, frame_fix
             is identical to frame_a. If phi[2] is near its singularity (= pi/2 or -pi/2),
             the frame_fix and phi are changed, such that phi[2] is far away from
             its singularity.
  w_rela[3]: Relative angular velocity of frame_b with respect to frame_a
             resolved in frame_a in [rad/s].
</pre>
"),
      Icon(
        Ellipse(extent=[-60, -60; 60, 60], style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-43, -47; 47, 43], style(
            color=8,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[-25, 25; 25, -25], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Text(extent=[-100, -140; 100, -80], string="%name"),
        Rectangle(extent=[25, 60; 60, -60], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[22, 10; 90, -10], style(
            color=0,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-90, 10; -60, -10], style(
            color=0,
            gradient=2,
            fillColor=8,
            fillPattern=1))),
      Diagram(
        Ellipse(extent=[-60, -60; 60, 60], style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-43, -47; 47, 43], style(
            color=8,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[-25, 25; 25, -25], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[25, 60; 60, -60], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[22, 10; 90, -10], style(
            color=0,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-90, 10; -60, -10], style(
            color=0,
            gradient=2,
            fillColor=8,
            fillPattern=1))));
  equation
    /* Determine sines and cosines of the Cardan angles */
    s1 = Modelica.Math.sin(phi[1]);
    s2 = Modelica.Math.sin(phi[2]);
    s3 = Modelica.Math.sin(phi[3]);
    c1 = Modelica.Math.cos(phi[1]);
    c2a = Modelica.Math.cos(phi[2]);
    c3 = Modelica.Math.cos(phi[3]);

    /* Below, some expressions are divided by c2. By construction, it is not possible
     that c2=0, during continuous simulation. However, at initial time and when
     large numerical errors occur, c2=0 is possible, which would result in a division
     by zero. The following statement is a guard against this unlikely situation.
  */
    c2 = if noEvent(c2a > c2_small or c2a < -c2_small) then c2a else if
      noEvent(c2a >= 0) then c2_small else -c2_small;

    /* Relative transformation matrix
       S_phi = [ c3, s3, 0;
                -s3, c3, 0;
                  0, 0, 1]*[c2, 0, -s2;
                             0, 1, 0;
                            s2, 0, c2]*[1, 0, 0;
                                        0, c1, s1;
                                        0, -s1, c1];
  */
    switch_state = phi[2] >= phi2_critical or phi[2] <= -phi2_critical;
    when switch_state then
      S_fix = pre(S_rel);
      reinit(phi, zeros(3));
    end when;
    S_phi = [c2*c3, c1*s3 + s1*s2*c3, s1*s3 - c1*s2*c3; -c2*s3, c1*c3 - s1*s2*
      s3, s1*c3 + c1*s2*s3; s2, -s1*c2, c1*c2];
    S_rel = S_phi*S_fix;

    // No translational movement
    r_rela = zeros(3);
    v_rela = zeros(3);
    a_rela = zeros(3);

    // Kinematic differential equations for rotational motion
    w_fix = S_fix*w_rela;
    der(phi) = {w_fix[1] + (s1*w_fix[2] - c1*w_fix[3])*s2/c2,c1*w_fix[2] + s1*
      w_fix[3],(-s1*w_fix[2] + c1*w_fix[3])/c2};
    der(w_rela) = z_rela;

    // Kinematic relationships
    frame_b.S = frame_a.S*transpose(S_rel);
    frame_b.r0 = frame_a.r0;

    frame_b.v = S_rel*frame_a.v;
    frame_b.w = S_rel*(frame_a.w + w_rela);

    frame_b.a = S_rel*frame_a.a;
    frame_b.z = S_rel*(frame_a.z + cross(frame_a.w, w_rela) + z_rela);

    // cut-torques are zero
    frame_a.f = -transpose(S_rel)*frame_b.f;
    frame_a.t = zeros(3);
    frame_b.t = zeros(3);
  end Spherical;
  model FreeMotion
    "Free motion joint (6 degrees-of-freedom, used in spanning tree)"


      // S_rel needs a correct start value, because pre(S_rel) is referenced below
    extends MultiBody.Interfaces.TreeJoint(S_rel(start=identity(3)));
    SIunits.Angle phi[3]
      "Cardan angles from a frame fixed in frame_a to frame_b";
  protected
    constant Real phi2_critical_deg=80
      "angle in [deg] too close to singularity. Redefine S_fix and phi";
    constant Real phi2_critical=phi2_critical_deg*Modelica.Constants.pi/180.0;
    constant Real c2_small=1.e-5
      "if cos(phi[2]) < c2_small, c2_small is used as guard against zero division"
      ;
    SIunits.Velocity vaux[3];
    Real s1;
    Real s2;
    Real s3;
    Real c1;
    Real c2;
    Real c2a;
    Real c3;
    Boolean switch_state;
    Real S_phi[3, 3] "S_rel = S_phi(phi)*S_fix";
    discrete Real S_fix[3, 3](start=identity(3)) "S_rel = S_phi(phi)*S_fix";
    SIunits.AngularVelocity w_fix[3]
      "Relative angular velocity resolved in intermediate frame S_fix";

    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.16,
        y=0,
        width=0.65,
        height=0.79),
      Documentation(info="<HTML>
<p>
Joint which does not constrain the motion between frame_a and frame_b.
Such a joint is just used to define the desired states to be used.
The joint is realized in
such a way, that a singularity cannot occur. This is achieved because
the Cardan angles are defined between a frame_fix fixed in frame_a and
frame_b. Whenever the Cardan angles are near a singularity, the
integration is stopped and frame_fix is changed, such that the Cardan
angles are far away from the singularity. The following state
variables are used:
</p>

<pre>
  r_rela[3]: Distance vector from the origin of frame_a to the origin
             of frame_b, resolved in frame_a in [m].
  phi[3]   : Cardan angles, also called Tait-Bryan angles, i.e.,
             rotate around 1-, 2-, 3-axis in [rad] from intermediate
             frame_fix, which is fixed in frame_a, to frame_b. Initially, frame_fix
             is identical to frame_a. If phi[2] is near its singularity (= pi/2 or -pi/2),
             the frame_fix and phi are changed, such that phi[2] is far away from
             its singularity.
  v_rela[3]: = der(r_rela); relative velocity of frame_b with respect to frame_a
             resolved in frame_a in [m/s].
  w_rela[3]: Relative angular velocity of frame_b with respect to frame_a
             resolved in frame_a in [rad/s].
</pre>
</HTML>
"),
      Icon(
        Line(points=[-86, 31; -74, 61; -49, 83; -17, 92; 19, 88; 40, 69; 59,
              48], style(
            color=9,
            thickness=2,
            fillColor=8)),
        Polygon(points=[90, 0; 50, 20; 50, -20; 90, 0], style(color=0,
              fillColor=8)),
        Polygon(points=[69, 58; 49, 40; 77, 28; 69, 58], style(color=0,
              fillColor=8)),
        Text(
          extent=[100, -40; -100, -100],
          string="%name",
          style(color=3)),
        Rectangle(extent=[-70, -5; -90, 5], style(color=0, fillColor=8)),
        Rectangle(extent=[50, -5; 30, 5], style(color=0, fillColor=8)),
        Rectangle(extent=[11, -5; -9, 5], style(color=0, fillColor=8)),
        Rectangle(extent=[-30, -5; -50, 5], style(color=0, fillColor=8))),
      Diagram(
        Line(points=[-86, 31; -74, 61; -49, 83; -17, 92; 19, 88; 40, 69; 59,
              48], style(
            color=9,
            thickness=2,
            fillColor=8)),
        Polygon(points=[90, 0; 50, 20; 50, -20; 90, 0], style(color=0,
              fillColor=8)),
        Polygon(points=[69, 58; 49, 40; 77, 28; 69, 58], style(color=0,
              fillColor=8)),
        Rectangle(extent=[50, -5; 30, 5], style(color=0, fillColor=8)),
        Rectangle(extent=[11, -5; -9, 5], style(color=0, fillColor=8)),
        Rectangle(extent=[-30, -5; -50, 5], style(color=0, fillColor=8)),
        Rectangle(extent=[-70, -5; -90, 5], style(color=0, fillColor=8))));
  equation

    /* Determine sines and cosines of the Cardan angles */
    s1 = Modelica.Math.sin(phi[1]);
    s2 = Modelica.Math.sin(phi[2]);
    s3 = Modelica.Math.sin(phi[3]);
    c1 = Modelica.Math.cos(phi[1]);
    c2a = Modelica.Math.cos(phi[2]);
    c3 = Modelica.Math.cos(phi[3]);

    /* Below, some expressions are divided by c2. By construction, it is not possible
     that c2=0, during continuous simulation. However, at initial time and when
     large numerical errors occur, c2=0 is possible, which would result in a division
     by zero. The following statement is a guard against this unlikely situation.
  */
    c2 = if noEvent(c2a > c2_small or c2a < -c2_small) then c2a else if
      noEvent(c2a >= 0) then c2_small else -c2_small;

    /* Relative transformation matrix
       S_phi = [ c3, s3, 0;
                -s3, c3, 0;
                  0, 0, 1]*[c2, 0, -s2;
                             0, 1, 0;
                            s2, 0, c2]*[1, 0, 0;
                                        0, c1, s1;
                                        0, -s1, c1];
  */
    switch_state = phi[2] >= phi2_critical or phi[2] <= -phi2_critical;
    when switch_state then
      S_fix = pre(S_rel);
      reinit(phi, zeros(3));
    end when;
    S_phi = [c2*c3, c1*s3 + s1*s2*c3, s1*s3 - c1*s2*c3; -c2*s3, c1*c3 - s1*s2*
      s3, s1*c3 + c1*s2*s3; s2, -s1*c2, c1*c2];
    S_rel = S_phi*S_fix;

    // Kinematic differential equations for translational motion
    der(r_rela) = v_rela;
    der(v_rela) = a_rela;

    // Kinematic differential equations for rotational motion
    w_fix = S_fix*w_rela;
    der(phi) = {w_fix[1] + (s1*w_fix[2] - c1*w_fix[3])*s2/c2,c1*w_fix[2] + s1*
      w_fix[3],(-s1*w_fix[2] + c1*w_fix[3])/c2};
    der(w_rela) = z_rela;

    // Kinematic relationships
    frame_b.S = frame_a.S*transpose(S_rel);
    frame_b.r0 = frame_a.r0 + frame_a.S*r_rela;

    vaux = cross(frame_a.w, r_rela);
    frame_b.v = S_rel*(frame_a.v + v_rela + vaux);
    frame_b.w = S_rel*(frame_a.w + w_rela);

    frame_b.a = S_rel*(frame_a.a + cross(frame_a.z, r_rela) + cross(frame_a.w
      , vaux + 2*v_rela) + a_rela);
    frame_b.z = S_rel*(frame_a.z + cross(frame_a.w, w_rela) + z_rela);

    // cut-forces and cut-torques are zero
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
    frame_b.f = zeros(3);
    frame_b.t = zeros(3);
  end FreeMotion;
end Joints;
