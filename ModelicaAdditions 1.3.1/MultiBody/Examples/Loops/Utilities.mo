package Utilities
  extends Modelica.Icons.Library;
  package SIunits = Modelica.SIunits ;

  model GasForce
    extends Modelica.Mechanics.Translational.Interfaces.Compliant;
    parameter SIunits.Length L "Length of cylinder";
    parameter SIunits.Length d "diameter of cylinder";
    parameter Real k0=0.01;
    parameter Real k1=1;
    parameter Real k=1;
    constant Real PI=3.14159265;
    SIunits.Position x;
    SIunits.Density dens;
    SIunits.Pressure press "cylinder pressure";
    SIunits.Volume V;
    SIunits.Temperature T;
    SIunits.Velocity v_rel;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.22,
        y=0.18,
        width=0.69,
        height=0.71),
      Icon(
        Rectangle(extent=[-90, 50; 90, -50], style(
            color=0,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 50; -20, -50], style(fillColor=3, fillPattern=1
            )),
        Rectangle(extent=[-90, 10; -40, -10], style(fillColor=3, fillPattern=1
            )),
        Polygon(points=[60, 2; 54, 2; 0, 2; 0, 10; -20, 0; 0, -10; 0, -4; 60,
              -4; 60, 2], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Text(extent=[-100, 120; 100, 60], string="%name")),
      Diagram(
        Rectangle(extent=[-90, 50; 90, -50], style(
            color=0,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 50; -20, -50], style(fillColor=3, fillPattern=1
            )),
        Rectangle(extent=[-90, 10; -40, -10], style(fillColor=3, fillPattern=1
            )),
        Polygon(points=[60, 2; 54, 2; 0, 2; 0, 10; -20, 0; 0, -10; 0, -4; 60,
              -4; 60, 2], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Text(extent=[-100, 120; 100, 60], string="%name")));
  equation
    x = 1 - s_rel/L;
    v_rel = der(s_rel);

    press = if v_rel < 0 then (if x < 0.987 then 177.4132*x^4 - 287.2189*x^3
       + 151.8252*x^2 - 24.9973*x + 2.4 else 2836360*x^4 - 10569296*x^3 +
      14761814*x^2 - 9158505*x + 2129670) else (if x > 0.93 then -3929704*x^4
       + 14748765*x^3 - 20747000*x^2 + 12964477*x - 3036495 else 145.930*x^4 -
      131.707*x^3 + 17.3438*x^2 + 17.9272*x + 2.4);

    f = -1.0E5*press*PI*d^2/4;

    V = k0 + k1*(1 - x);
    dens = 1/V;
    press*V = k*T;
  end GasForce;
  partial model Engine
    extends Modelica.Icons.Example;
    parameter Real D=0.1;
    parameter Real e=0.05;
    parameter Real L=0.2;
    parameter Real Load=20;
    constant Real PI=Modelica.Constants.pi;
    output Real AngVelDegS;
    output Real x;
    output Real press;
    output Real T;
    output Real V;
    output Real dens;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.12,
        y=0.02,
        width=0.61,
        height=0.72),
      Documentation(info="Use the following settings:

experiment StopTime=0.2 Interval=0.002 Tolerance=1.E-8


Perform 'simulate' and then see animation in
Animation window.

  Plot the following variables:

  AngVelDegS: Angular velocity of motor shaft [rev/min]
  x         : position of cylinder [m]
  press     : pressure in cylinder [bar]
"));
    MultiBody.Parts.InertialSystem inertial(g=0) annotation (extent=[-80, -80
          ; -60, -60]);
    MultiBody.Joints.Revolute r1(startValueFixed=true, qd(start=-157))
      annotation (extent=[-50, -40; -30, -20], rotation=90);
    MultiBody.Joints.Prismatic cyl(n={-1,0,0}) annotation (extent=[40, -80; 60
          , -60]);
    MultiBody.Parts.FrameTranslation trans(r={sqrt((D/2 + L)^2 - e^2),-e,0})
      annotation (extent=[-10, -80; 10, -60]);
    MultiBody.Parts.ShapeBody piston(
      r={0.1,0,0},
      m=0.3,
      I33=0.0001,
      Shape="cylinder",
      Width=0.05,
      Height=0.05) annotation (extent=[80, -80; 100, -60]);
    MultiBody.Parts.ShapeBody crank(
      r={D/2,0,0},
      Width=0.01,
      Height=0.01,
      Material={0,0,1,0.5}) annotation (extent=[-38, 0; -18, 20]);
    MultiBody.Examples.Loops.Utilities.GasForce gasForce(L=(sqrt((L + D/2)^2
           - e^2) - sqrt((L - D/2)^2 - e^2)), d=0.05) annotation (extent=[44, -
          56; 56, -44]);
    Modelica.Mechanics.Rotational.Inertia flyWheel(J=0.0025) annotation (
        extent=[-74, -40; -54, -20]);
    Modelica.Mechanics.Rotational.Torque torque annotation (extent=[-100, -40
          ; -80, -20]);
  equation
    connect(inertial.frame_b, r1.frame_a) annotation (points=[-59.5, -70; -
          40, -70; -40, -40.5]);
  equation
    connect(inertial.frame_b, trans.frame_a) annotation (points=[-59.5, -70
          ; -10.5, -70]);
  equation
    connect(trans.frame_b, cyl.frame_a) annotation (points=[10.5, -70; 39.5
          , -70]);
  equation
    connect(cyl.frame_b, piston.frame_a) annotation (points=[60.5, -70; 79.5
          , -70]);
  equation
    connect(cyl.bearing, gasForce.flange_a) annotation (points=[47, -64; 47
          , -60; 40, -60; 40, -50; 44, -50]);
  equation
    connect(cyl.axis, gasForce.flange_b) annotation (points=[57, -64; 57, -
          60; 60, -60; 60, -50; 56, -50]);
  equation
    connect(flyWheel.flange_b, r1.axis) annotation (points=[-54, -30; -47, -
          30]);
  equation
    connect(torque.flange_b, flyWheel.flange_a) annotation (points=[-80, -30
          ; -74, -30]);
  equation
    connect(r1.frame_b, crank.frame_a) annotation (points=[-40, -19.5; -40,
          10; -38.5, 10]);
  equation
    torque.tau = (if r1.qd > 0 then -1 else 1)*Load;

    AngVelDegS = -r1.qd*60/(2*PI);
    /*rev/min*/

    x = gasForce.s_rel;
    press = gasForce.press;
    T = gasForce.T;
    V = gasForce.V;
    dens = gasForce.dens;
  end Engine;
  annotation (Coordsys(
      extent=[0, 0; 243, 185],
      grid=[1, 1],
      component=[20, 20]), Window(
      x=0.1,
      y=0.18,
      width=0.2,
      height=0.23,
      library=1,
      autolayout=1));
end Utilities;
