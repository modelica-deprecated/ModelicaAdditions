package Parts
  "Parts with and without mass for 3D mechanical components"

  extends Modelica.Icons.Library;

  annotation (Documentation(info="<html>
<p>
This package contains the inertial system and elements
which have mass and inertia.
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
  model InertialSystem "Inertial system"
    parameter SI.Acceleration g=9.81 "Gravity constant";
    parameter Real ng[3]={0,-1,0} "Direction of gravity (gravity = g*ng)";
    parameter String label1="x" "Label of horizontal axis in icon";
    parameter String label2="y" "Label of vertical axis in icon";
    SI.Acceleration gravity[3] "Gravity acceleration vector";
    Interfaces.Frame_b frame_b annotation (extent=[90, -15; 120, 15]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.13,
        y=0.1,
        width=0.81,
        height=0.83),
      Documentation(info="
An instance of this class defines a coordinate system: the inertial
frame. All parameter vectors and tensors (e.g. position vectors)
are given in the home position of the multibody system with respect
to the inertial frame.

One instance of class  InertialSystem  MUST always be present for every
multibody model.

In order to identify the desired axes of the used inertial frame in
the icon, the labels of the two axes can be defined as string parameters.
"),
      Icon(
        Rectangle(extent=[-80, 70; 90, -80],
            style(color=0, fillColor=7)),
        Line(points=[-80, -100; -80, 30], style(
            color=0,
            thickness=2,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[-80, 70; -100, 30; -60, 30; -80, 70; -80, 70], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-100, -80; 50, -80], style(
            color=0,
            thickness=2,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[90, -80; 50, -60; 50, -100; 90, -80], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Text(extent=[0, 150; 0, 79], string="%name"),
        Text(extent=[50, 18; 50, -51], string="%label1"),
        Text(extent=[-30, 60; -30, -11], string="%label2")),
      Diagram(
        Rectangle(extent=[-80, 70; 90, -80],
            style(color=0, fillColor=7)),
        Line(points=[-80, -100; -80, 30], style(
            color=0,
            thickness=2,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[-80, 70; -100, 30; -60, 30; -80, 70; -80, 70], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-100, -80; 50, -80], style(
            color=0,
            thickness=2,
            fillColor=0,
            fillPattern=1)),
        Polygon(points=[90, -80; 50, -60; 50, -100; 90, -80], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Text(extent=[-100, 110; 100, 70], string="inertial system"),
        Text(extent=[-10, -10; 50, -70], string="%label1"),
        Text(extent=[-60, 60; 0, 0], string="%label2")));
  equation
    gravity = g*ng;

    /*Equations*/
    frame_b.S = identity(3);
    frame_b.r0 = zeros(3);
    frame_b.v = zeros(3);
    frame_b.w = zeros(3);
    frame_b.a = -gravity;
    frame_b.z = zeros(3);
  end InertialSystem;

  model FrameTranslation "Fixed translation of frame_b with respect to frame_a"

    extends Interfaces.TwoTreeFrames;
    parameter SI.Position r[3]={0,0,0}
      "Vector from frame_a to frame_b resolved in frame_a";
  protected
    SI.Velocity vaux[3];
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.25,
        y=0.04,
        width=0.75,
        height=0.65),
      Documentation(info="
Fixed translation of frame_b with respect to frame_a, i.e.,
the frames of connectors a and b are parallel to each other.

Parameters:
  r: Position vector from the origin of (connector) frame_a to the origin of
     (connector) frame_b, resolved in frame_a in [m].
"),
      Icon(
        Text(
          extent=[-99, -100; 101, -40],
          string="r=%r",
          style(color=0)),
        Rectangle(extent=[-90, 5; 90, -5], style(color=0, fillColor=0)),
        Text(extent=[-101, 41; 99, 101], string="%name")),
      Diagram(
        Line(points=[-90, 0; -90, -65]),
        Line(points=[90, 0; 90, -65]),
        Line(points=[-90, -60; 80, -60]),
        Polygon(points=[80, -55; 80, -65; 90, -60; 80, -55], style(fillColor=3
              , fillPattern=1)),
        Text(extent=[-22, -36; 16, -60], string="r"),
        Rectangle(extent=[-90, 5; 90, -5], style(color=0, fillColor=0)),
        Line(points=[69, 29; 106, 29], style(arrow=1)),
        Line(points=[70, 27; 70, 59], style(arrow=1)),
        Text(extent=[92, 44; 106, 33], string="x"),
        Text(extent=[51, 66; 66, 54], string="y"),
        Line(points=[-103, 29; -66, 29], style(arrow=1)),
        Line(points=[-102, 27; -102, 59], style(arrow=1)),
        Text(extent=[-80, 44; -66, 33], string="x"),
        Text(extent=[-121, 66; -106, 54], string="y")));
  equation
    Sb = Sa;
    wb = wa;
    zb = za;

    r0b = r0a + Sa*r;
    vaux = cross(wa, r);
    vb = va + vaux;
    ab = aa + cross(za, r) + cross(wa, vaux);

    /*Transform the force and torque acting at frame_b to frame_a*/
    fa = fb;
    ta = tb + cross(r, fa);
  end FrameTranslation;

  model FrameRotation
    "Fixed translation and planar rotation of frame_b with respect to frame_a"
    extends Interfaces.FrameBase;
    parameter Real n[3]={1,0,0} "Axis of rotation in frame_a and in frame_b";
    parameter Real angle=0 "Rotation angle in [deg]";
    parameter String label1="x" "Label of horizontal axis in icon";
    parameter String label2="y" "Label of vertical axis in icon";
  protected
    Real nn[3];
    SI.Angle angleRad;
    annotation (
      Icon(Text(
          extent=[136, 95; 164, 73],
          string="%label1",
          style(color=0)), Text(
          extent=[3, 97; 31, 75],
          string="%label2",
          style(color=0))),
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.16,
        y=0.05,
        width=0.6,
        height=0.6));
  equation
    nn = n/sqrt(n*n);
    angleRad = angle*pi/180;
    S_rel = Interfaces.planarRotation(nn, angleRad);
  end FrameRotation;

  model FrameAxes
    "Fixed translation and rotation of frame_b with respect to frame_a"
    extends Interfaces.FrameBase;
    parameter Real nx[3]={1,0,0} "x-axis of frame_b resolved in frame_a";
    parameter Real ny[3]={0,1,0} "y-axis of frame_b resolved in frame_a";
    parameter String label1="x" "Label of horizontal axis in icon";
    parameter String label2="y" "Label of vertical axis in icon";
  protected
    Real nz[3];
    Real nnx[3];
    Real nny[3];
    Real nnz[3];
    annotation (
      Icon(Text(
          extent=[3, 97; 31, 75],
          string="%label2",
          style(color=0)), Text(
          extent=[129, 102; 157, 80],
          string="%label1",
          style(color=0))),
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.24,
        y=0.37,
        width=0.6,
        height=0.6));
  equation
    nz = cross(nx, ny);
    nnz = nz/sqrt(nz*nz);
    nnx = nx/sqrt(nx*nx);
    nny = cross(nnz, nnx);
    S_rel = transpose([nnx, nny, nnz]);
  end FrameAxes;

  model FrameAngles
    "Fixed translation and elementary rotations of frame_b with respect to frame_a"


    extends Interfaces.FrameBase;
    parameter Integer sequence[3](
      min={1,1,1},
      max={3,3,3}) = {1,2,3} "Sequence of rotations";
    parameter Real angles[3]={0,0,0}
      "Rotation angles around axes defined in sequence in [deg]";
    parameter String label1="x" "Label of horizontal axis in icon";
    parameter String label2="y" "Label of vertical axis in icon";
  protected
    parameter SI.Angle anglesRad[3]=angles*Modelica.Constants.pi/180.;
    annotation (Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]), Window(
        x=0.23,
        y=0.1,
        width=0.6,
        height=0.6));
  equation
    S_rel = Interfaces.axisRotation(sequence[3], anglesRad[3])*
      Interfaces.axisRotation(sequence[2], anglesRad[2])*
      Interfaces.axisRotation(sequence[1], anglesRad[1]);
  end FrameAngles;

  model Body "Rigid body with one cut"
    extends Interfaces.OneFrame_a;
    parameter SI.Position rCM[3]={0,0,0}
      "Vector from frame_a to center of mass, resolved in frame_a";
    parameter SI.Mass m=0 "Mass of body [kg]";
    parameter SI.Inertia I11=0 "(1,1) element of inertia tensor";
    parameter SI.Inertia I22=0 "(2,2) element of inertia tensor";
    parameter SI.Inertia I33=0 "(3,3) element of inertia tensor";
    parameter SI.Inertia I21=0 "(2,1) element of inertia tensor";
    parameter SI.Inertia I31=0 "(3,1) element of inertia tensor";
    parameter SI.Inertia I32=0 "(3,2) element of inertia tensor";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.2,
        y=0.04,
        width=0.71,
        height=0.75),
      Documentation(info="
Rigid body with one cut. All the mass and inertia properties must be
supplied with respect to the center of mass.

Parameters:
  rCM[3]: Position vector from the origin of frame_a to the center of
          mass, resolved in frame_a in [m].
  m     : Mass of body in [kg].
  Ixy   : Elements (x,y) of the inertia tensor of the body with respect to
          the center of mass, resolved in frame_a in [kgm^2].
          The following elements can be defined:
          I11, I22, I33, I21, I31, I32.
          (Move the inertial from into the center of mass by translation
          and resolve the inertia tensor in this frame).
"),
      Icon(
        Rectangle(extent=[-90, 15; 0, -15], style(
            color=8,
            gradient=2,
            fillColor=75)),
        Rectangle(extent=[0, 50; 100, -50], style(
            color=8,
            gradient=3,
            fillColor=75,
            fillPattern=1)),
        Text(extent=[0, 59; 0, 129], string="%name"),
        Text(
          extent=[0, -129; 0, -60],
          string="%=rCM",
          style(color=0))),
      Diagram(
        Line(points=[-100, -2; -100, -48]),
        Line(points=[20, 0; 20, -48]),
        Line(points=[-100, -40; 10, -40]),
        Polygon(points=[20, -40; 10, -36; 10, -44; 20, -40], style(fillColor=3
              , fillPattern=1)),
        Text(extent=[-68, -44; -16, -62], string="rCM")));
    Interfaces.BodyBase body annotation (extent=[-40, -40; 40, 40]);
  equation
    connect(frame_a, body.frame_a) annotation (points=[-105, 0; -42, 0], style(
          color=0, thickness=2));
    body.m = m;
    body.rCM = rCM;
    body.I = [I11, I21, I31; I21, I22, I32; I31, I32, I33];
  end Body;

  model Body2 "Rigid body with two cuts"
    extends Interfaces.TwoTreeFrames;
    parameter SI.Position r[3]={0,0,0}
      "Vector from frame_a to frame_b, resolved in frame_a";
    parameter SI.Position rCM[3]={0,0,0}
      "Vector from frame_a to center of mass, resolved in frame_a";
    parameter SI.Mass m=0 "Mass of body";
    parameter SI.Inertia I11=0 "(1,1) element of inertia tensor";
    parameter SI.Inertia I22=0 "(2,2) element of inertia tensor";
    parameter SI.Inertia I33=0 "(3,3) element of inertia tensor";
    parameter SI.Inertia I21=0 "(2,1) element of inertia tensor";
    parameter SI.Inertia I31=0 "(3,1) element of inertia tensor";
    parameter SI.Inertia I32=0 "(3,2) element of inertia tensor";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.24,
        y=0.1,
        width=0.6,
        height=0.73),
      Documentation(info="
Rigid body with two frames. All the mass and inertia properties must be
supplied with respect to the center of mass. All parameter vectors
have to be resolved in frame_a in [m].

Parameters:
  r[3]  : Position vector from the origin of frame_a to the origin of
          frame_b.
  rCM[3]: Position vector from the origin of frame_a to the center of
          mass.
  m     : Mass of body in [kg].
  Ixy   : Elements (x,y) of the inertia tensor of the body with respect to
          the center of mass, resolved frame_a in [kgm^2].
          The following elements can be defined:
          I11, I22, I33, I21, I31, I32.
          (Move the inertial from into the center of mass by translation
          and resolve the inertia tensor in this frame).
"),
      Icon(
        Rectangle(extent=[-90, 15; -50, -15], style(
            color=8,
            gradient=2,
            fillColor=75,
            fillPattern=1)),
        Rectangle(extent=[90, 15; 50, -15], style(
            color=8,
            gradient=2,
            fillColor=75,
            fillPattern=1)),
        Rectangle(extent=[-50, 50; 50, -50], style(
            color=8,
            gradient=3,
            fillColor=75,
            fillPattern=1)),
        Text(extent=[-100, 120; 100, 60], string="%name"),
        Text(
          extent=[-99, -60; 101, -100],
          string="r=%r",
          style(color=0))),
      Diagram(
        Line(points=[-90, 10; -90, 44]),
        Line(points=[90, 0; 90, 44]),
        Line(points=[-90, 40; 80, 40]),
        Polygon(points=[80, 44; 80, 36; 90, 40; 80, 44], style(fillColor=3,
              fillPattern=1)),
        Text(extent=[-22, 68; 20, 40], string="r"),
        Line(points=[-90, -10; -90, -90]),
        Line(points=[0, -46; 0, -90]),
        Line(points=[-90, -84; -10, -84]),
        Polygon(points=[-10, -80; -10, -88; 0, -84; -10, -80], style(fillColor=
                3, fillPattern=1)),
        Text(extent=[-60, -64; -34, -82], string="rCM")));
    FrameTranslation frameTranslation(r=r) annotation (extent=[-40, -20; 40, 20
          ]);
    Interfaces.BodyBase body annotation (extent=[-27.3333, -73.3333; 26, -20]);
  equation
    connect(frame_a, frameTranslation.frame_a) annotation (points=[-105, 0; -42
          , 0], style(color=0, thickness=2));
    connect(frame_b, frameTranslation.frame_b) annotation (points=[105, 0; 42,
          0], style(color=0, thickness=2));
    connect(frame_a, body.frame_a) annotation (points=[-105, 0; -60, 0; -60, -
          46; -28.6666, -46.6666], style(
        color=0,
        thickness=2,
        fillColor=0,
        fillPattern=1));
    body.m = m;
    body.rCM = rCM;
    body.I = [I11, I21, I31; I21, I22, I32; I31, I32, I33];
  end Body2;

  model BoxBody "Rigid body with box shape (also used for animation)"
    extends Interfaces.TwoTreeFrames;
    parameter SI.Position r[3]={0.1,0,0}
      "Vector from frame_a to frame_b, resolved in frame_a";
    parameter SI.Position r0[3]={0,0,0}
      "Vector from frame_a to left box plane, resolved in frame_a";
    parameter SI.Position LengthDirection[3]=r - r0
      "Vector in length direction, resolved in frame_a";
    parameter SI.Position WidthDirection[3]={0,1,0}
      "Vector in width direction, resolved in frame_a";
    parameter SI.Length Length=(sqrt((r - r0)*(r - r0))) "Length of box";
    parameter SI.Length Width=0.1 "Width of box";
    parameter SI.Length Height=0.1 "Height of box";
    parameter SI.Length InnerWidth=0 "Width of inner box surface";
    parameter SI.Length InnerHeight=0 "Height of inner box surface";
    parameter Real rho=7.7 "Density of box material [g/cm^3]";
    parameter Real Material[4]={1,0,0,0.5} "Color and specular coefficient";
    SI.Mass mo;
    SI.Mass mi;
    Real Sbox[3, 3];
    SI.Length l;
    SI.Length w;
    SI.Length h;
    SI.Length wi;
    SI.Length hi;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.13,
        y=0.06,
        width=0.72,
        height=0.68),
      Documentation(info="
Rigid body with  box  shape. The mass properties of the body are computed
from the box data. Optionally, the box may be hollow.
The (outer) box shape is automatically used in animation.

Parameter vectors are defined with respect to frame_a in [m].

Parameters:
  r[3]       : Position vector from the origin of frame_a to the
               origin of frame_b.
  r0[3]      : Position vector from frame_a to the mid-point of the  left
               box plane.
  LengthDirection[3]: Unit vector in direction of length (will be normalized).
  WidthDirection[3] : Unit vector in direction of width (will be normalized).
  Length     : Length of box in [m].
  Width      : Width of box in [m].
  Height     : Height of box in direction of a vector which is
               orthogonal to  LengthDirection  and  WidthDirection  in [m].
  InnerWidth : Width of inner box surface in [m] (0 <= InnerWidth < Width).
  InnerHeight: Height of inner box surface in [m] (0 <= InnerHeight < Height).
  rho        : Density of material in [g/cm^3], e.g.
                    steel: 7.7 .. 7.9
                    wood : 0.4 .. 0.8
  Material[4]: = {r, g, b, specular}.
               Color and specular coefficient of the box.
               [r,g,b] affects the color of diffuse and ambient reflected
               light. Specular is a coefficient defining white specular
               reflection. What color that is reflected also depends on the
               color of the light sources. Note, r g, b and specular are
               given in the range 0-1. Specular=1 gives a metallic appearance.
"),
      Icon(
        Rectangle(extent=[-90, 15; -50, -15], style(
            color=8,
            gradient=2,
            fillColor=75,
            fillPattern=1)),
        Rectangle(extent=[-50, 35; 30, -45], style(
            color=7,
            fillColor=46,
            fillPattern=1)),
        Polygon(points=[-50, 35; -30, 55; 50, 55; 30, 35; -50, 35], style(
            color=8,
            fillColor=75,
            fillPattern=1)),
        Polygon(points=[50, 55; 50, -25; 30, -45; 30, 35; 50, 55], style(
            color=7,
            fillColor=75,
            fillPattern=1)),
        Rectangle(extent=[40, 15; 90, -15], style(
            color=8,
            gradient=2,
            fillColor=75,
            fillPattern=1)),
        Text(extent=[-100, 130; 100, 68], string="%name"),
        Text(
          extent=[-99, -61; 99, -100],
          string="r=%r",
          style(color=0))));
    FrameTranslation frameTranslation(r=r) annotation (extent=[-60, -30; 60, 30
          ]);
    Interfaces.BodyBase body annotation (extent=[-25, -107; 33, -47]);
    VisualShape box(
      Shape="box",
      r0=r0,
      LengthDirection=LengthDirection,
      WidthDirection=WidthDirection,
      Length=Length,
      Width=Width,
      Height=Height,
      Material=Material) annotation (extent=[-20, 40; 40, 100]);
  equation
    connect(body.frame_a, frame_a) annotation (points=[-26.45, -77; -105, 0]);
    connect(frame_a, frameTranslation.frame_a) annotation (points=[-105, 0; -63
          , 0]);
    connect(frameTranslation.frame_b, frame_b) annotation (points=[63, 0; 105,
          0]);
    box.S = Sa;
    box.r = r0a;
    box.Sshape = Sbox;

    l = Length;
    w = Width;
    h = Height;
    wi = InnerWidth;
    hi = InnerHeight;

    /*Mass properties of box*/
    mo = 1000*rho*l*w*h;
    mi = 1000*rho*l*wi*hi;
    body.m = mo - mi;
    body.rCM = r0 + l/2*box.nLength;
    body.I = Sbox*diagonal({mo*(w*w + h*h) - mi*(wi*wi + hi*hi),mo*(l*l + h*h)
       - mi*(l*l + hi*hi),mo*(l*l + w*w) - mi*(l*l + wi*wi)}/12)*transpose(Sbox
      );
  end BoxBody;

  model CylinderBody
    "Rigid body with cylindrical shape (also used for animation)"
    extends Interfaces.TwoTreeFrames;
    parameter SI.Position r[3]={0.2,0,0}
      "Vector from frame_a to frame_b, resolved in frame_a";
    parameter SI.Position r0[3]={0,0,0}
      "Vector from frame_a to left circle center, resolved in frame_a";
    parameter SI.Position Axis[3]=r - r0
      "Vector in direction of cylinder axis, resolved in frame_a";
    parameter SI.Length Length=(sqrt(Axis*Axis)) "Length of cylinder";
    parameter SI.Length Radius(min=0) = 0.1 "Radius of cylinder";
    parameter SI.Length InnerRadius(
      min=0,
      max=Radius) = 0 "Inner radius of cylinder";
    parameter Real rho(min=0) = 7.7 "Density of material [g/cm^3]";
    parameter Real Material[4]={1,0,0,0.5} "Color and specular coefficient";
    Real Scyl[3, 3];
    SI.Mass mo;
    SI.Mass mi;
    SI.Inertia I22;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.09,
        y=0.01,
        width=0.83,
        height=0.73),
      Documentation(info="
Rigid body with  cylindrical  shape. The mass properties of the body are
computed from the cylinder data. Optionally, the cylinder may be hollow.
The pipe shape is automatically used in animation.

Parameter vectors are defined with respect to frame_a in [m].

Parameters:
  r[3]       : Position vector from the origin of frame_a to the origin of
               frame_b.
  r0[3]      : Position vector from the origin of frame_a to the center
               of the  left  cylinder circle.
  Axis[3]    : Unit vector in direction of the cylinder axis
               (will be normalized)
  Length     : Length of cylinder in [m].
  Radius     : Radius of cylinder in [m].
  InnerRadius: Inner radius of cylinder in [m].
  rho        : Density of material in [g/cm^3], e.g.
                  steel: 7.7 .. 7.9
                  wood : 0.4 .. 0.8
  Material(4): = {r, g, b, specular}.
               Color and specular coefficient of the box.
               [r,g,b] affects the color of diffuse and ambient reflected
               light. Specular is a coefficient defining white specular
               reflection. What color that is reflected also depends on the
               color of the light sources. Note, r g, b and specular are
               given in the range 0-1. Specular=1 gives a metallic appearance.
"),
      Icon(
        Rectangle(extent=[-90, 15; -50, -15], style(
            color=8,
            gradient=2,
            fillColor=75,
            fillPattern=1)),
        Rectangle(extent=[50, 15; 90, -15], style(
            color=8,
            gradient=2,
            fillColor=75,
            fillPattern=1)),
        Rectangle(extent=[-50, 50; 50, -50], style(
            color=2,
            gradient=2,
            fillColor=46,
            fillPattern=1)),
        Text(extent=[-102, 120; 100, 60], string="%name"),
        Text(
          extent=[-100, -59; 100, -99],
          string="r=%r",
          style(color=0))));
    FrameTranslation frameTranslation(r=r) annotation (extent=[-60, -30; 60, 30
          ]);
    Interfaces.BodyBase body annotation (extent=[-30, -101; 30, -43]);
    VisualShape box(
      r0=r0,
      Length=Length,
      Width=2*Radius,
      Height=2*Radius,
      LengthDirection=Axis,
      WidthDirection={0,1,0},
      Shape="pipe",
      Material=Material,
      Extra=InnerRadius/Radius) annotation (extent=[-20, 40; 40, 100]);
  equation
    connect(frame_a, body.frame_a) annotation (points=[-105, 0; -31.5, -72]);
    connect(frame_a, frameTranslation.frame_a) annotation (points=[-105, 0; -63
          , 0]);
    connect(frameTranslation.frame_b, frame_b) annotation (points=[63, 0; 105,
          0]);
    box.S = Sa;
    box.r = r0a;
    box.Sshape = Scyl;

    /*Mass properties of cylinder*/
    mo = 1000*rho*pi*Length*Radius*Radius;
    mi = 1000*rho*pi*Length*InnerRadius*InnerRadius;
    I22 = (mo*(Length*Length + 3*Radius*Radius) - mi*(Length*Length + 3*
      InnerRadius*InnerRadius))/12;
    body.m = mo - mi;
    body.rCM = r0 + Length/2*box.nLength;
    body.I = Scyl*diagonal({(mo*Radius*Radius - mi*InnerRadius*InnerRadius)/2,
      I22,I22})*transpose(Scyl);
  end CylinderBody;

  model ShapeBody "Rigid body with visual shape (also used for animation)"
    extends Interfaces.TwoTreeFrames;
    parameter SI.Position r[3]={0.1,0,0}
      "Vector from frame_a to frame_b, resolved in frame_a";
    parameter SI.Position rCM[3]={0,0,0}
      "Vector from frame_a to center of mass, resolved in frame_a";
    parameter SI.Mass m=0 "Mass of body";
    parameter SI.Inertia I11=0 "(1,1) element of inertia tensor";
    parameter SI.Inertia I22=0 "(2,2) element of inertia tensor";
    parameter SI.Inertia I33=0 "(3,3) element of inertia tensor";
    parameter SI.Inertia I21=0 "(2,1) element of inertia tensor";
    parameter SI.Inertia I31=0 "(3,1) element of inertia tensor";
    parameter SI.Inertia I32=0 "(3,2) element of inertia tensor";
    parameter String Shape="box" "Name of shape (see info text)";
    parameter SI.Position r0[3]={0,0,0}
      "Vector from frame_a to shape origin. resolved in frame_a";
    parameter SI.Position LengthDirection[3]=r - r0
      "Vector in length direction, resolved in frame_a";
    parameter SI.Position WidthDirection[3]={0,1,0}
      "Vector in width direction, resolved in frame_a";
    parameter SI.Length Length=(sqrt((r - r0)*(r - r0))) "Length of shape";
    parameter SI.Length Width=0.1 "Width of shape";
    parameter SI.Length Height=0.1 "Height of shape";
    parameter Real Material[4]={1,0,0,0.5} "Color and specular coefficient";
    parameter Real Extra=0.0 "Additional parameter for cone and pipe";
    annotation (Documentation(info="
Rigid body with two cuts and an additional shape used in animation.
All the mass and inertia properties must be supplied with respect
to the center of mass. All parameter vectors are resolved in frame_a
in [m].

Parameters:
  r[3]         : Position vector from the origin of frame_a to the origin of
                 frame_b.
  rCM[3]       : Position vector from the origin of frame_a to the center of
                 mass.
  m            : Mass of body in [kg].
  Ixy          : Elements (x,y) of the inertia tensor of the body with respect to
                 the center of mass, resolved in the inertial frame in the home
                 position in [kgm^2]. The following elements can be defined:
                 I11, I22, I33, I21, I31, I32.
                 (Move the inertial from into the center of mass by translation
                 and resolve the inertia tensor in this frame).

  Shape        : Type of visual shape. Predefined shapes are
                   Shape = \"box\"
                           \"sphere\"
                           \"cylinder\"
                           \"cone\"
                           \"pipe\"
                           \"beam\"
                           \"gearwheel\"
                           \"wirebox\"
                 External shapes are specified as DXF-files (only 3DFace is supported).
                 External shapes must be named \"1\", \"2\"  etc.. The corresponding definitions
                 should be in files \"1.dxf\", \"2.dxf\" etc.Since the DXF-files contain color
                 and dimensions for the individual faces, the corresponding information
                 in the model is currently ignored, but the specular coefficient is
                 utilized. The DXF-files must be found in the current directory.

  r0[3]        : Position vector from the origin of frame_a to the origin
                 of the visual object.
  LengthDirection[3]: Unit vector in direction of length (will be normalized).
  WidthDirection[3] : Unit vector in direction of width (will be normalized).
  Length       : Length of visual shape in [m].
  Width        : Width of visual shape in [m].
  Height       : Height of visual shape in direction of a vector which is
                 orthogonal to  LengthDirection  and  WidthDirection.
  Material[4]  : = {r, g, b, specular} specifies the color of the shape.
                 [r,g,b] affects the color of diffuse and ambient reflected
                 light. Specular is a coefficient defining white specular
                 reflection. What color that is reflected also depends on the
                 color of the light sources. Note, r g, b and specular are
                 given in the range 0 .. 1. Specular=1 gives a metallic appearance.
  Extra        : Additional parameter for cone and pipe.
                 \"pipe\"     : A hollow cylinder. Extra = InnerRadius/Radius of the cylinder.
                 \"gearwheel\": A ring with gear wheel teeth. Extra = number of teeth.
"), Icon(
        Rectangle(extent=[-90, 15; -50, -15], style(
            color=8,
            gradient=2,
            fillColor=75,
            fillPattern=1)),
        Polygon(points=[-50, 34; -50, -60; 0, -40; 40, -60; 40, 36; 0, 12; -50
              , 34], style(
            color=7,
            fillColor=46,
            fillPattern=1)),
        Polygon(points=[-50, 34; -30, 46; 10, 30; 60, 62; 40, 36; 0, 12; -50,
              34], style(
            color=7,
            fillColor=75,
            fillPattern=1)),
        Polygon(points=[58, 60; 40, 36; 40, -60; 58, -36; 58, 60], style(
            color=7,
            fillColor=75,
            fillPattern=1)),
        Rectangle(extent=[48, 15; 90, -15], style(
            color=8,
            gradient=2,
            fillColor=75,
            fillPattern=1)),
        Text(extent=[-100, 120; 100, 61], string="%name=%r"),
        Text(
          extent=[-100, -61; 100, -99],
          string="%Shape",
          style(color=0))));
    Body2 body(
      r=r,
      rCM=rCM,
      m=m,
      I11=I11,
      I22=I22,
      I33=I33,
      I21=I21,
      I31=I31,
      I32=I32) annotation (extent=[-40, -40; 40, 40]);
    Parts.Shape vis(
      Shape=Shape,
      r0=r0,
      LengthDirection=LengthDirection,
      WidthDirection=WidthDirection,
      Length=Length,
      Width=Width,
      Height=Height,
      Material=Material,
      Extra=Extra) annotation (extent=[-29, -100; 31, -40]);
  equation
    connect(frame_a, body.frame_a) annotation (points=[-105, 0; -42, 0]);
    connect(frame_b, body.frame_b) annotation (points=[105, 0; 42, 0]);
    connect(vis.frame_a, frame_a) annotation (points=[-30.5, -70; -70, -70; -70
          , 0; -105, 0]);
  end ShapeBody;

  model Shape "General animation shape"
    extends Interfaces.OneFrame_a;
    parameter String Shape="box" "Name of shape (see info text)";
    parameter Real r0[3]={0,0,0} "Vector from frame_a to shape origin [m]";
    parameter Real LengthDirection[3]={1,0,0} "Vector in length direction";
    parameter Real WidthDirection[3]={0,1,0} "Vector in width direction";
    parameter Real Length=1 "Length of shape [m]";
    parameter Real Width=0.1 "Width of shape [m]";
    parameter Real Height=0.1 "Height of shape [m]";
    parameter Real Material[4]={1,0,0,0.5} "Color and specular coefficient";
    parameter Real Extra=0.0 "Additional parameter for cone and pipe";
    Real nLength[3];
    Real nWidth[3];
    Real nHeight[3];
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.02,
        y=0,
        width=0.79,
        height=0.89),
      Documentation(info="A variety of shapes can be defined for animation.
Parameter vectors are defined with respect to frame_a in [m].

Parameters:
  Shape        : Type of visual shape. Predefined shapes are
                   Shape = \"box\"
                           \"sphere\"
                           \"cylinder\"
                           \"cone\"
                           \"pipe\"
                           \"beam\"
                           \"gearwheel\"
                           \"wirebox\"
                 External shapes are specified as DXF-files (only 3DFace is supported).
                 External shapes must be named \"1\", \"2\"  etc.. The corresponding definitions
                 should be in files \"1.dxf\", \"2.dxf\" etc.Since the DXF-files contain color
                 and dimensions for the individual faces, the corresponding information
                 in the model is currently ignored, but the specular coefficient is
                 utilized. The DXF-files must be found in the current directory.
  r0[3]        : Position vector from the origin of frame_a to the origin
                 of the visual object.
  LengthDirection[3]: Unit vector in direction of length (will be normalized).
  WidthDirection[3] : Unit vector in direction of width (will be normalized).
  Length       : Length of visual shape in [m].
  Width        : Width of visual shape in [m].
  Height       : Height of visual shape in direction of a vector which is
                 orthogonal to  LengthDirection  and  WidthDirection .
  Material[4]  : = {r, g, b, specular} specifies the color of the shape.
                 [r,g,b] affects the color of diffuse and ambient reflected
                 light. Specular is a coefficient defining white specular
                 reflection. What color that is reflected also depends on the
                 color of the light sources. Note, r g, b and specular are
                 given in the range 0 .. 1. Specular=1 gives a metallic appearance.
  Extra        : Additional parameter for cone and pipe.
                 \"pipe\"     : A hollow cylinder. Extra = InnerRadius/Radius of the cylinder.
                 \"gearwheel\": A ring with gear wheel teeth. Extra = number of teeth.

In the class, the unit vectors in direction of the shape axes are computed
and are provided as terminal variables to be used in the calling object:
  nLength(3)   : Unit vector in direction of  AxisLength .
  nWidth (3)   : Unit vector orthogonal to  nLength .
  nHeight(3)   : Unit vector orthogonal to  nLength  and  nWidth.
"),
      Icon(
        Polygon(points=[-90, 34; -90, -60; 0, -40; 60, -60; 60, 34; 0, 12; -90
              , 34], style(
            color=7,
            fillColor=46,
            fillPattern=1)),
        Polygon(points=[-88, 34; -54, 46; 10, 30; 84, 56; 60, 32; 0, 12; -88,
              34], style(
            color=7,
            fillColor=9,
            fillPattern=1)),
        Polygon(points=[82, 54; 60, 32; 60, -60; 82, -32; 82, 54], style(
            color=7,
            fillColor=9,
            fillPattern=1)),
        Text(extent=[-100, 120; 100, 60], string="%name"),
        Text(
          extent=[-100, -61; 100, -99],
          string="%Shape",
          style(color=0))));
    VisualShape vis(
      Shape=Shape,
      r0=r0,
      LengthDirection=LengthDirection,
      WidthDirection=WidthDirection,
      Length=Length,
      Width=Width,
      Height=Height,
      Material=Material,
      Extra=Extra) annotation (extent=[-40, -20; 20, 40]);
  equation
    vis.S = Sa;
    vis.r = r0a;
    vis.nLength = nLength;
    vis.nWidth = nWidth;
    vis.nHeight = nHeight;

    /*No forces and torques*/
    fa = zeros(3);
    ta = zeros(3);
  end Shape;
end Parts;
