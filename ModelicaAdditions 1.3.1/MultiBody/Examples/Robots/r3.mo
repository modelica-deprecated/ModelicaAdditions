package r3 "Models of the Manutec r3 robot"
  extends Modelica.Icons.Library;
  package SIunits = Modelica.SIunits ;

  annotation (
    Coordsys(
      extent=[0, 0; 220, 376],
      grid=[1, 1],
      component=[20, 20]),
    Window(
      x=0.1,
      y=0.18,
      width=0.18,
      height=0.41,
      library=1,
      autolayout=1),
    Documentation(info="<HTML>
<p>
This package contains models of the robot r3 of the company Manutec.
It is used to demonstrate in which way complex robot models should
be built up by testing first the components of the model
individually before composing them together. The following models are
available:
</p>

<pre>
   <b>axisType1</b>        Test one axis (controller, motor, gearbox) of structure 1.
   <b>axisType2</b>        Test one axis (controller, motor, gearbox) of structure 2.
   <b>inverseDynamics</b>  Test mechanical structure
                    (predefined joint angle time functions).
   <b>robot</b>            Test complete robot model.
</pre>

<p>
The parameters of this robot have been determined by measurements
in the laboratory of DLR. The measurement procedure is described in:
</p>

<pre>
   Tuerk S. (1990): Zur Modellierung der Dynamik von Robotern mit
       rotatorischen Gelenken. Fortschrittberichte VDI, Reihe 8, Nr. 211,
       VDI-Verlag 1990.
</pre>

<p>
The robot model is described in detail in
</p>

<pre>
   Otter M. (1995): Objektorientierte Modellierung mechatronischer
       Systeme am Beispiel geregelter Roboter. Dissertation,
       Fortschrittberichte VDI, Reihe 20, Nr. 147, VDI-Verlag 1995.
       This report can be downloaded as compressed postscript file
       from: http://www.op.dlr.de/FF-DR-ER/staff/otter/publications.html
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
<li><i>June 20, 2000</i>
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
  model axisType1
    "Test one axis of r3 robot (controller, motor, gearbox) of structure 1."
    extends Modelica.Icons.Example;
    output Real refq "reference joint angle in [deg]";
    output Real q "actual joint angle in [deg]";
    output Real eq "joint angle error in [deg]";
    output Real refqd "reference joint angular velocity in [rad/s]";
    output Real qd "actual joint angular velocity in [rad/s]";
    output Real eqd "joint angular velocity error in [rad/s]";
    constant Real pi=Modelica.Constants.pi;
    constant Real rad2deg=180/pi;

    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.13,
        y=0.11,
        width=0.58,
        height=0.66),
      Documentation(info="<HTML>
<p>
The robot r3 has 2 different model structures of its axes.
Axis type 1 is checked with this model.
Simulate for 0.8 s.
</p>
</HTML>
"),
      Diagram);
    Components.AxisType1 axis1 annotation (extent=[-33, 0; -13, 20]);
    Modelica.Blocks.Sources.KinematicPTP PTP(
      deltaq={pi/2},
      qd_max={3},
      qdd_max={50}) annotation (extent=[-69, 0; -49, 20]);
    Modelica.Mechanics.Rotational.Inertia load(J=5) annotation (extent=[0, 0;
          20, 20]);
  equation
    connect(PTP.outPort, axis1.inPort_a_ref) annotation (points=[-48, 10;
          -35, 10]);
  equation
    connect(axis1.flange, load.flange_a) annotation (points=[-13, 10; 0, 10]
        , style(color=10, thickness=2));
  equation
    refq = axis1.phi_ref*rad2deg;
    q = axis1.flange.phi*rad2deg;
    eq = refq - q;

    refqd = axis1.w_ref;
    qd = der(axis1.flange.phi);
    eqd = refqd - qd;
  end axisType1;
  model axisType2
    "Test one axis of r3 robot (controller, motor, gearbox) of structure 2."
    extends Modelica.Icons.Example;
    output Real refq "reference joint angle in [deg]";
    output Real q "actual joint angle in [deg]";
    output Real eq "joint angle error in [deg]";
    output Real refqd "reference joint angular velocity in [rad/s]";
    output Real qd "actual joint angular velocity in [rad/s]";
    output Real eqd "joint angular velocity error in [rad/s]";
    constant Real pi=Modelica.Constants.pi;
    constant Real rad2deg=180/pi;

    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.22,
        y=0.14,
        width=0.58,
        height=0.66),
      Documentation(info="<HTML>
<p>
The robot r3 has 2 different model structures of its axes.
Axis type 2 is checked with this model.
Simulate for 0.8 s.
</p>
</HTML>
"));
    Components.AxisType2 axis2 annotation (extent=[-20, 20; 0, 40]);
    Modelica.Mechanics.Rotational.Inertia load(J=1) annotation (extent=[20, 20
          ; 40, 40]);
    Modelica.Blocks.Sources.KinematicPTP PTP(
      deltaq={pi/2},
      qd_max={3},
      qdd_max={50}) annotation (extent=[-59, 20; -39, 40]);
  equation
    connect(axis2.flange, load.flange_a) annotation (points=[0, 30; 20, 30])
      ;
  equation
    connect(PTP.outPort, axis2.inPort_a_ref) annotation (points=[-38, 30;
          -21.9, 30]);
  equation
    refq = axis2.phi_ref*rad2deg;
    q = axis2.flange.phi*rad2deg;
    eq = refq - q;

    refqd = axis2.w_ref;
    qd = der(axis2.flange.phi);
    eqd = refqd - qd;
  end axisType2;
  model inverseDynamics
    "Test of the mechanical structure model using time-dependent joint motion"
    extends Modelica.Icons.Example;
    constant Real deg2rad=Modelica.Constants.pi/180;

    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.39,
        y=0.06,
        width=0.56,
        height=0.69),
      Documentation(info="<HTML>
<p>
This model is used to test the mechanical structure of the
Manutec r3 robot. The 6 joints are forced to move according
to a pre-defined motion, i.e., the inverse dynamics of the
robot is computed. <br>
Simulate for 1.2 seconds.
</p>
</HTML>
"));


      ModelicaAdditions.MultiBody.Examples.Robots.r3.Components.MechanicalStructure
       mechanics annotation (extent=[10, -40; 100, 50]);
    Modelica.Blocks.Sources.KinematicPTP PTP(
      deltaq={180,180,-100,120,120,120}*deg2rad,
      qd_max={3,3,4.5,3,4,3},
      qdd_max={50,50,50,50,50,50}) annotation (extent=[-100, -4; -80, 16]);
    ModelicaAdditions.Blocks.Multiplexer.DeMultiplex6 deMux annotation (extent
        =[-71, 16; -50, -4]);
    Modelica.Mechanics.Rotational.Accelerate accelerate1(phi_start=-120*
          deg2rad) annotation (extent=[-30, -80; -10, -60]);
    Modelica.Mechanics.Rotational.Accelerate accelerate2(phi_start=-90*deg2rad
      ) annotation (extent=[-30, -50; -10, -30]);
    Modelica.Mechanics.Rotational.Accelerate accelerate3(phi_start=0)
      annotation (extent=[-30, -20; -10, 0]);
    Modelica.Mechanics.Rotational.Accelerate accelerate4(phi_start=-60*deg2rad
      ) annotation (extent=[-30, 10; -10, 30]);
    Modelica.Mechanics.Rotational.Accelerate accelerate5(phi_start=-90*deg2rad
      ) annotation (extent=[-30, 40; -10, 60]);
    Modelica.Mechanics.Rotational.Accelerate accelerate6(phi_start=-90*deg2rad
      ) annotation (extent=[-30, 70; -10, 90]);
  equation
    connect(PTP.outPort, deMux.inPort) annotation (points=[-79, 6; -73.1, 6]
      );
  equation
    connect(deMux.outPort6, accelerate6.inPort) annotation (points=[-48.95,
          15; -46, 15; -46, 80; -32, 80]);
  equation
    connect(deMux.outPort5, accelerate5.inPort) annotation (points=[-48.95,
          11.4; -44, 11.4; -44, 50; -32, 50]);
  equation
    connect(deMux.outPort4, accelerate4.inPort) annotation (points=[-48.95,
          7.8; -42, 7.8; -42, 20; -32, 20]);
  equation
    connect(deMux.outPort3, accelerate3.inPort) annotation (points=[-48.95,
          4.2; -42, 4.2; -42, -10; -32, -10]);
  equation
    connect(deMux.outPort2, accelerate2.inPort) annotation (points=[-48.95,
          0.6; -44, 0.6; -44, -40; -32, -40]);
  equation
    connect(accelerate1.inPort, deMux.outPort1) annotation (points=[-32, -70
          ; -46, -70; -46, -3; -48.95, -3]);
  equation
    connect(accelerate2.flange_b, mechanics.axis2) annotation (points=[-10,
          -40; -5, -40; -5, -19.75; 7.75, -19.75], style(color=10, thickness=2)
      );
  equation
    connect(accelerate1.flange_b, mechanics.axis1) annotation (points=[-10,
          -70; 0, -70; 0, -33; 7.75, -33.25], style(color=10, thickness=2));
  equation
    connect(accelerate3.flange_b, mechanics.axis3) annotation (points=[-10,
          -10; -5, -10; -5, -6.25; 7.75, -6.25], style(color=10, thickness=2));
  equation
    connect(accelerate4.flange_b, mechanics.axis4) annotation (points=[-10,
          20; -5, 20; -5, 7; 7.75, 7.25], style(color=10, thickness=2));
  equation
    connect(accelerate5.flange_b, mechanics.axis5) annotation (points=[-10,
          50; -2, 50; -2, 20.75; 7.75, 20.75], style(color=10, thickness=2));
  equation
    connect(accelerate6.flange_b, mechanics.axis6) annotation (points=[-10,
          80; 2, 80; 2, 34.25; 7.75, 34.25], style(color=10, thickness=2));
  end inverseDynamics;
  model robot "Detailled model of Manutec r3 robot with reference path"
    extends Modelica.Icons.Example;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.18,
        y=0.01,
        width=0.67,
        height=0.76),
      Documentation(info="<HTML>
<p>
Complete model of Mantuec r3 robot, including
controller, motor, gearbox, 3D-mechanics model.
Simulate for 1.3 s.
</p>
</HTML>
"));
    ModelicaAdditions.MultiBody.Examples.Robots.r3.Components.FullRobot robot(
        q0={-1,0.43,1.57,0,-2,0}) annotation (extent=[-30, -70; 100, 60]);
    ModelicaAdditions.Tables.CombiTableTime a_ref1(table=[0, 30; 0.1, 30; 0.1
          , 0; 0.74, 0; 0.74, -13.96; 1.12, -13.96; 1.12, 28.75; 1.2, 28.75;
          1.2, 0; 1.3, 0]) annotation (extent=[-91, -90; -70, -70]);
    ModelicaAdditions.Tables.CombiTableTime a_ref2(table=[0, -15; 0.1, -15;
          0.1, 0; 1.1, 0; 1.1, 15; 1.2, 15; 1.2, 0; 1.3, 0]) annotation (extent
        =[-91, -60; -70, -40]);
    ModelicaAdditions.Tables.CombiTableTime a_ref3(table=[0, 30; 0.15, 30;
          0.15, -21.56; 0.6, -21.56; 0.6, 0; 0.9, 0; 0.9, 17.33; 1.2, 17.33;
          1.2, 0; 1.3, 0]) annotation (extent=[-90, -30; -69, -10]);
    ModelicaAdditions.Tables.CombiTableTime a_ref4(table=[0, -80; 0.04, -80;
          0.04, 0; 0.54, 0; 0.54, 71.11; 0.63, 71.11; 0.63, 0; 1.14, 0; 1.14, -
          53.33; 1.2, -53.33; 1.2, 0; 1.3, 0]) annotation (extent=[-91, 0; -70
          , 20]);
    ModelicaAdditions.Tables.CombiTableTime a_ref5(table=[0, 105; 0.04, 105;
          0.04, 0; 1.02, 0; 1.02, -68.33; 1.14, -68.33; 1.14, 66.67; 1.2, 66.67
          ; 1.2, 0; 1.3, 0]) annotation (extent=[-90, 30; -69, 50]);
    ModelicaAdditions.Tables.CombiTableTime a_ref6(table=[0, -95; 0.04, -95;
          0.04, 0; 0.54, 0; 0.54, 84.44; 0.63, 84.44; 0.63, 0; 1.14, 0; 1.14, -
          63.33; 1.2, -63.33; 1.2, 0; 1.3, 0]) annotation (extent=[-91, 60; -70
          , 80]);
  equation
    connect(a_ref1.outPort, robot.a_ref1) annotation (points=[-68.95, -80;
          -50, -80; -50, -57; -33.25, -57]);
  equation
    connect(a_ref2.outPort, robot.a_ref2) annotation (points=[-68.95, -50;
          -60, -50; -60, -37.5; -33.25, -37.5]);
  equation
    connect(a_ref3.outPort, robot.a_ref3) annotation (points=[-67.95, -20;
          -50, -20; -50, -18; -33.25, -18]);
  equation
    connect(a_ref4.outPort, robot.a_ref4) annotation (points=[-68.95, 10;
          -50, 10; -50, 1.5; -33.25, 1.5]);
  equation
    connect(a_ref5.outPort, robot.a_ref5) annotation (points=[-67.95, 40;
          -60, 40; -60, 21; -33.25, 21]);
  equation
    connect(a_ref6.outPort, robot.a_ref6) annotation (points=[-68.95, 70;
          -50, 70; -50, 40.5; -33.25, 40.5]);
  end robot;
  package Components "Library of components for the Manutec r3 robot"
    extends Modelica.Icons.Library;

    model GearType1 "Motor inertia and gearbox model for r3 joints 1,2,3 "
      extends Modelica.Mechanics.Rotational.Interfaces.TwoFlanges;
      parameter SIunits.Inertia J=0.0013 "moment of inertia of motor";
      parameter Real i=-105 "gear ratio";
      parameter Real c=43 "spring constant";
      parameter Real d=0.005 "damper constant";
      parameter SIunits.Torque Rv0=0.4
        "viscous friction torque at zero velocity";
      parameter Real Rv1=(0.13/160)
        "viscous friction coefficient in [Nms/rad] (R=Rv0+Rv1*abs(qd))";
      parameter Real peak=1
        "peak*Rv0 = maximum static friction torque (peak >= 1)";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.14,
          y=0,
          width=0.71,
          height=0.71),
        Documentation(info="
Models the gearbox used in the first three joints with all its effects,
like elasticity and friction.

Coulomb friction is approximated by a friction element acting
at the \"motor\"-side. In reality, bearing friction should be
also incorporated at the driven side of the gearbox. However,
this would require considerable more effort for the measurement
of the friction parameters.

Default values for all parameters are given for joint 1.

Model relativeStates is used to define the relative angle
and relative angular velocity across the spring (=gear elasticity)
as state variables. The reason is, that a default initial
value of zero of these states makes always sense.
If the absolute angle and the absolute angular velocity of model
Jmotor would be used as states, and the load angle (= joint angle of
robot) is NOT zero, one has always to ensure that the initial values
of the motor angle and of the joint angle are modified correspondingly.
Otherwise, the spring has an unrealistic deflection at initial time.
Since relative quantities are used as state variables, this simplifies
the definition of initial values considerably.

"),
        Icon(
          Rectangle(extent=[-90, 10; -60, -10], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[-60, 10; -60, 20; -40, 40; -40, -40; -60, -20; -60,
                10], style(
              color=10,
              gradient=2,
              fillColor=10,
              fillPattern=1)),
          Rectangle(extent=[-40, 60; 40, -60], style(
              color=3,
              pattern=1,
              thickness=1,
              gradient=2,
              arrow=0,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[60, 20; 40, 40; 40, -40; 60, -20; 60, 20], style(
              color=10,
              fillColor=10,
              fillPattern=1)),
          Rectangle(extent=[60, 10; 90, -10], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[-60, -90; -50, -90; -20, -30; 20, -30; 48, -90; 60,
                -90; 60, -100; -60, -100; -60, -90], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Text(extent=[0, 128; 0, 68], string="%name"),
          Text(extent=[-36, 40; 36, -30], string="1")),
        Diagram(Text(
            extent=[72, 30; 130, 22],
            string="flange of joint axis",
            style(color=0)), Text(
            extent=[-124, 28; -66, 20],
            string="flange of motor axis",
            style(color=0))));
      Modelica.Mechanics.Rotational.Inertia Jmotor(J=J) annotation (extent=[-
            74, -10; -54, 10]);
      Modelica.Mechanics.Rotational.IdealGear gear(ratio=i) annotation (extent
          =[50, -10; 70, 10]);
      Modelica.Mechanics.Rotational.SpringDamper spring(c=c, d=d) annotation (
          extent=[0, -10; 20, 10]);
      Modelica.Mechanics.Rotational.RelativeStates relativeStates annotation (extent=[0, 30; 20, 50]);
      Modelica.Mechanics.Rotational.BearingFriction bearingFriction(tau_pos=[0
            , Rv0; 1, Rv0 + Rv1]) annotation (extent=[-40, -10; -20, 10]);
    equation
      connect(spring.flange_b, gear.flange_a) annotation (points=[20, 0;
            50, 0]);
    equation
      connect(relativeStates.flange_b, spring.flange_b) annotation (points
          =[20, 40; 30, 40; 30, 0; 20, 0]);
    equation
      connect(relativeStates.flange_a, spring.flange_a) annotation (points
          =[0, 40; -10, 40; -10, 0; 0, 0]);
    equation
      connect(bearingFriction.flange_b, spring.flange_a) annotation (
          points=[-20, 0; 0, 0]);
    equation
      connect(Jmotor.flange_b, bearingFriction.flange_a) annotation (
          points=[-54, 0; -40, 0]);
    equation
      connect(Jmotor.flange_a, flange_a) annotation (points=[-74, 0; -100
            , 0]);
    equation
      connect(gear.flange_b, flange_b) annotation (points=[70, 0; 100, 0])
        ;
    end GearType1;
    model GearType2 "Motor inertia and gearbox model for r3 joints 4,5,6  "
      extends Modelica.Mechanics.Rotational.Interfaces.TwoFlanges;
      parameter SIunits.Inertia J=1.6e-4 "moment of inertia of motor";
      parameter Real i=-99 "gear ratio";
      parameter SIunits.Torque Rv0=21.8
        "viscous friction torque at zero velocity";
      parameter Real Rv1=9.8
        "viscous friction coefficient in [Nms/rad] (R=Rv0+Rv1*abs(qd))";
      parameter Real peak=(26.7/21.8)
        "peak*Rv0 = maximum static friction torque (peak >= 1)";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.15,
          y=0.01,
          width=0.63,
          height=0.63),
        Documentation(info="The elasticity and damping in the gearboxes of the outermost
three joints of the robot is neglected.

Default values for all parameters are given for joint 4.
"),
        Icon(
          Rectangle(extent=[-90, 10; -60, -10], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[-60, 10; -60, 20; -40, 40; -40, -40; -60, -20; -60,
                10], style(
              color=10,
              gradient=2,
              fillColor=10,
              fillPattern=1)),
          Rectangle(extent=[-40, 60; 40, -60], style(
              color=3,
              pattern=1,
              thickness=1,
              gradient=2,
              arrow=0,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[60, 20; 40, 40; 40, -40; 60, -20; 60, 20], style(
              color=10,
              fillColor=10,
              fillPattern=1)),
          Rectangle(extent=[60, 10; 90, -10], style(
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[-60, -90; -50, -90; -20, -30; 20, -30; 48, -90; 60,
                -90; 60, -100; -60, -100; -60, -90], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Text(extent=[0, 128; 0, 68], string="%name"),
          Text(extent=[-36, 40; 38, -30], string="2")),
        Diagram);
      Modelica.Mechanics.Rotational.Inertia Jmotor(J=J) annotation (extent=[-
            60, -10; -40, 10]);
      Modelica.Mechanics.Rotational.IdealGear gear(ratio=i) annotation (extent
          =[-8, -10; 12, 10]);
      Modelica.Mechanics.Rotational.BearingFriction bearingFriction(tau_pos=[0
            , Rv0; 1, Rv0 + Rv1], peak=peak) annotation (extent=[40, -10; 60,
            10]);
    equation
      connect(Jmotor.flange_a, flange_a) annotation (points=[-60, 0; -100
            , 0]);
    equation
      connect(gear.flange_b, bearingFriction.flange_a) annotation (points=
            [12, 0; 40, 0]);
    equation
      connect(bearingFriction.flange_b, flange_b) annotation (points=[60,
            0; 100, 0]);
    equation
      connect(Jmotor.flange_b, gear.flange_a) annotation (points=[-40, 0;
            -8, 0]);
    end GearType2;
    model Motor "Motor model including current controller of r3 motors "
      extends Modelica.Icons.MotorIcon;
      parameter Real k=1.1616 "gain of motor";
      parameter Real wm=4590 "time constant of motor";
      parameter Real D=0.6 "damping constant of motor";

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.15,
          y=0.02,
          width=0.68,
          height=0.8),
        Documentation(info=" Default values are given for the motor of joint 1.
The input of the motor is the desired current
(the actual current is proportional to the torque
produced by the motor).
"),
        Icon(
          Text(extent=[0, 120; 0, 60], string="%name"),
          Line(points=[50, -10; 50, -89]),
          Line(points=[80, -90; 80, -10])),
        Diagram(Text(
            extent=[-134, 35; -104, 18],
            string="(reference current)",
            style(color=0))));
      Modelica.Blocks.Interfaces.InPort i_ref annotation (extent=[-139, -20; -
            100, 20]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_motor
        annotation (extent=[90, -10; 110, 10]);
      Modelica.Blocks.Interfaces.OutPort outPort_w annotation (extent=[40, -
            109; 60, -89], rotation=-90);
      Modelica.Blocks.Interfaces.OutPort outPort_phi annotation (extent=[70, -
            110; 90, -90], rotation=-90);
      Modelica.Electrical.Analog.Sources.SignalVoltage Vs annotation (extent=[
            -66, -10; -86, 10], rotation=-90);
      Modelica.Electrical.Analog.Ideal.IdealOpAmp diff annotation (extent=[-50
            , 15; -30, 35]);
      Modelica.Electrical.Analog.Ideal.IdealOpAmp power annotation (extent=[30
            , 15; 50, 35]);
      Modelica.Electrical.Analog.Basic.EMF emf(k=k) annotation (extent=[60, -
            10; 80, 10]);
      Modelica.Electrical.Analog.Basic.Inductor La(L=(250/(2*D*wm)))
        annotation (extent=[60, 20; 80, 40], rotation=-90);
      Modelica.Electrical.Analog.Basic.Resistor Ra(R=250) annotation (extent=[
            60, 50; 80, 70], rotation=-90);
      Modelica.Electrical.Analog.Basic.Resistor Rd2(R=100) annotation (extent=
            [-72, 22; -57, 38]);
      Modelica.Electrical.Analog.Basic.Capacitor C(C=0.004*D/wm) annotation (
          extent=[0, 36; 20, 56]);
      Modelica.Electrical.Analog.Ideal.IdealOpAmp OpI annotation (extent=[0,
            10; 20, 30]);
      Modelica.Electrical.Analog.Basic.Resistor Rd1(R=100) annotation (extent=
            [-49, 37; -34, 53]);
      Modelica.Electrical.Analog.Basic.Resistor Ri(R=10) annotation (extent=[-
            23, 17; -8, 33]);
      Modelica.Electrical.Analog.Basic.Resistor Rp1(R=200) annotation (extent=
            [31, 38; 46, 54]);
      Modelica.Electrical.Analog.Basic.Resistor Rp2(R=50) annotation (extent=[
            18, 64; 32, 80], rotation=90);
      Modelica.Electrical.Analog.Basic.Resistor Rd4(R=100) annotation (extent=
            [-41, -15; -26, 1]);
      Modelica.Electrical.Analog.Sources.SignalVoltage hall2 annotation (
          extent=[-45, -40; -65, -60], rotation=90);
      Modelica.Electrical.Analog.Basic.Resistor Rd3(R=100) annotation (extent=
            [-62, -30; -48, -14], rotation=90);
      Modelica.Electrical.Analog.Basic.Ground g1 annotation (extent=[-86, -37
            ; -66, -17]);
      Modelica.Electrical.Analog.Basic.Ground g2 annotation (extent=[-65, -90
            ; -45, -70]);
      Modelica.Electrical.Analog.Basic.Ground g3 annotation (extent=[-20, -27
            ; 0, -7]);
      Modelica.Electrical.Analog.Sensors.CurrentSensor hall1 annotation (
          extent=[20, -60; 40, -40], rotation=-90);
      Modelica.Electrical.Analog.Basic.Ground g4 annotation (extent=[20, -84;
            40, -64]);
      Modelica.Electrical.Analog.Basic.Ground g5 annotation (extent=[15, 83;
            35, 103], rotation=180);
      Modelica.Mechanics.Rotational.Sensors.AngleSensor phi annotation (extent
          =[80, -60; 100, -40], rotation=-90);
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor w annotation (extent=[
            60, -60; 80, -40], rotation=-90);
    equation
      connect(La.n, emf.p) annotation (points=[70, 20; 70, 10]);
    equation
      connect(Ra.n, La.p) annotation (points=[70, 50; 70, 40]);
    equation
      connect(Rd2.n, diff.n1) annotation (points=[-57, 30; -50, 30]);
    equation
      connect(C.n, OpI.p2) annotation (points=[20, 46; 20, 20]);
    equation
      connect(OpI.p2, power.p1) annotation (points=[20, 20; 30, 20]);
    equation
      connect(Vs.p, Rd2.p) annotation (points=[-76, 10; -76, 30; -72, 30])
        ;
    equation
      connect(diff.n1, Rd1.p) annotation (points=[-50, 30; -54, 30; -54,
            45; -49, 45]);
    equation
      connect(Rd1.n, diff.p2) annotation (points=[-34, 45; -30, 45; -30,
            25]);
    equation
      connect(diff.p2, Ri.p) annotation (points=[-30, 25; -23, 25]);
    equation
      connect(Ri.n, OpI.n1) annotation (points=[-8, 25; 0, 25]);
    equation
      connect(OpI.n1, C.p) annotation (points=[0, 25; 0, 46]);
    equation
      connect(power.n1, Rp1.p) annotation (points=[30, 30; 25, 30; 25, 46
            ; 31, 46]);
    equation
      connect(power.p2, Rp1.n) annotation (points=[50, 25; 50, 46; 46, 46]
        );
    equation
      connect(Rp1.p, Rp2.p) annotation (points=[31, 46; 25, 46; 25, 64]);
    equation
      connect(power.p2, Ra.p) annotation (points=[50, 25; 56, 25; 56, 80;
            70, 80; 70, 70]);
    equation
      connect(Rd3.p, hall2.p) annotation (points=[-55, -30; -55, -40]);
    equation
      connect(Rd3.n, diff.p1) annotation (points=[-55, -14; -55, 20; -50,
            20]);
    equation
      connect(Rd3.n, Rd4.p) annotation (points=[-55, -14; -55, -7; -41, -7
            ]);
    equation
      connect(Vs.n, g1.p) annotation (points=[-76, -10; -76, -17]);
    equation
      connect(g2.p, hall2.n) annotation (points=[-55, -70; -55, -60]);
    equation
      connect(Rd4.n, g3.p) annotation (points=[-26, -7; -10, -7]);
    equation
      connect(g3.p, OpI.p1) annotation (points=[-10, -7; -10, 15; 0, 15]);
    equation
      connect(hall1.outPort, hall2.inPort) annotation (points=[20, -50; -
            48, -50], style(
          pattern=3,
          thickness=1,
          arrow=0));
    equation
      connect(g5.p, Rp2.n) annotation (points=[25, 83; 25, 80]);
    equation
      connect(emf.n, hall1.p) annotation (points=[70, -10; 70, -24; 30, -
            24; 30, -40]);
    equation
      connect(hall1.n, g4.p) annotation (points=[30, -60; 30, -64]);
    equation
      connect(emf.flange_b, phi.flange_a) annotation (points=[80, 0; 80, 0
            ; 80, -40; 90, -40; 90, -40], style(pattern=3));
    equation
      connect(emf.flange_b, w.flange_a) annotation (points=[80, 0; 80, 0;
            80, -40; 70, -40; 70, -40], style(pattern=3));
    equation
      connect(w.outPort, outPort_w) annotation (points=[70, -61; 50, -61;
            50, -99], style(pattern=3));
    equation
      connect(phi.outPort, outPort_phi) annotation (points=[90, -61; 90, -
            80.5; 80, -80.5; 80, -100], style(pattern=3));
    equation
      connect(flange_motor, emf.flange_b) annotation (points=[100, 0; 80,
            0], style(color=0, thickness=2));
    equation
      connect(OpI.n2, power.n2) annotation (points=[10, 10; 10, 4; 40, 4;
            40, 15]);
    equation
      connect(OpI.p1, OpI.n2) annotation (points=[0, 15; 0, 10; 10, 10]);
    equation
      connect(OpI.p1, diff.n2) annotation (points=[0, 15; -40, 15]);
    equation
      connect(Vs.inPort, i_ref) annotation (points=[-83, 4.44089e-016; -
            119.5, 0], style(pattern=3));
    end Motor;
    model Control "Controller model of r3 robot "
      extends Modelica.Blocks.Interfaces.BlockIcon;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.24,
          y=0.02,
          width=0.47,
          height=0.68),
        Documentation(info="<HTML>
<p>
For the robot 6 identical controllers are used.
Therefore, this class has no parameters.
</p>

<p>
In reality, the position controller is realized in digital
form (components Kv, Kd). For efficiency reasons, this
controller part is modelled as continuous component.
By simulation it has been shown, that the difference in the
results is below the plot accuracy.
</p>
</HTML>
"),
        Icon(
          Rectangle(extent=[-40, 70; 44, 28], style(fillColor=7, fillPattern=1
              )),
          Rectangle(extent=[-40, -20; 44, -62], style(fillColor=7, fillPattern
                =1)),
          Line(points=[44, 46; 78, 46; 78, -42; 44, -42]),
          Line(points=[-40, -42; -76, -42; -76, 48; -40, 48]),
          Polygon(points=[44, -42; 64, -32; 64, -50; 44, -42], style(fillColor
                =3, fillPattern=1)),
          Polygon(points=[-40, 48; -60, 56; -60, 40; -40, 48], style(fillColor
                =3, fillPattern=1))),
        Diagram);
      Modelica.Blocks.Interfaces.InPort phi_ref annotation (extent=[-140, -20
            ; -100, 20]);
      Modelica.Blocks.Interfaces.InPort w_ref annotation (extent=[-140, 50; -
            100, 90]);
      Modelica.Blocks.Interfaces.InPort phi annotation (extent=[-100, -140; -
            60, -100], rotation=90);
      Modelica.Blocks.Interfaces.InPort w annotation (extent=[50, -140; 90, -
            100], rotation=90);
      Modelica.Blocks.Interfaces.OutPort i_ref annotation (extent=[100, -10;
            120, 10]);
      Modelica.Blocks.Continuous.TransferFunction rate2(b={9.95e-3,1}, a={
            0.56e-3,1}) annotation (extent=[30, -10; 50, 10]);
      Modelica.Blocks.Continuous.Integrator rate3(k={340.8}) annotation (
          extent=[60, -10; 80, 10]);
      Modelica.Blocks.Continuous.TransferFunction rate1(b={40e-3,1}, a={
            20.2e-3,1}) annotation (extent=[36, -60; 16, -40]);
      Modelica.Blocks.Continuous.FirstOrder tacho1(k={0.03}, T={8.475e-4})
        annotation (extent=[90, -60; 70, -40]);
      Modelica.Blocks.Math.Gain Kd(k={0.03}) annotation (extent=[-70, 60; -50
            , 80]);
      Modelica.Blocks.Math.Feedback wSum annotation (extent=[0, -10; 20, 10]);
      Modelica.Blocks.Math.Add sum annotation (extent=[-24, -10; -4, 10]);
      Modelica.Blocks.Math.Feedback pSum annotation (extent=[-90, -10; -70, 10
            ]);
      Modelica.Blocks.Math.Gain Kv(k={0.3}) annotation (extent=[-66, -10; -46
            , 10]);
      Modelica.Blocks.Continuous.TransferFunction tacho2(a={1/(2014*2014),2*
            0.294/2014,1}) annotation (extent=[63, -60; 43, -40]);
    equation
      connect(rate2.outPort, rate3.inPort) annotation (points=[51, 0; 58,
            0]);
    equation
      connect(wSum.outPort, rate2.inPort) annotation (points=[19, 0; 28, 0
            ]);
    equation
      connect(sum.outPort, wSum.inPort1) annotation (points=[-3, 0; 2, 0])
        ;
    equation
      connect(Kd.outPort, sum.inPort1) annotation (points=[-49, 70; -34,
            70; -34, 6; -26, 6]);
    equation
      connect(rate3.outPort, i_ref) annotation (points=[81, 0; 110, 0]);
    equation
      connect(rate1.outPort, wSum.inPort2) annotation (points=[15, -50; 10
            , -50; 10, -8]);
    equation
      connect(Kv.inPort, pSum.outPort) annotation (points=[-68, 0; -71, 0]
        );
    equation
      connect(tacho1.outPort, tacho2.inPort) annotation (points=[69, -50;
            65, -50]);
    equation
      connect(tacho2.outPort, rate1.inPort) annotation (points=[42, -50;
            38, -50]);
    equation
      connect(Kv.outPort, sum.inPort2) annotation (points=[-45, 0; -40, 0
            ; -40, -6; -26, -6]);
    equation
      connect(Kd.inPort, w_ref) annotation (points=[-72, 70; -120, 70]);
    equation
      connect(pSum.inPort1, phi_ref) annotation (points=[-88, 0; -120, 0])
        ;
    equation
      connect(pSum.inPort2, phi) annotation (points=[-80, -8; -80, -120]);
    equation
      connect(tacho1.inPort, w) annotation (points=[92, -50; 100, -50; 100
            , -80; 70, -80; 70, -120]);
    end Control;
    model AxisType1 "Axis model of the r3 joints 1,2,3 "
      parameter SIunits.Angle phi_ref0=0
        "initial value of reference and joint angle";
      parameter SIunits.AngularVelocity w_ref0=0
        "initial value of reference and joint speed";
      parameter Real k=1.1616 "gain of motor";
      parameter Real w=4590 "time constant of motor";
      parameter Real D=0.6 "damping constant of motor";
      parameter Real J=0.0013 "moment of inertia of motor in [kgm^2]";
      parameter Real i=-105 "gear ratio";
      parameter Real c=43 "spring constant";
      parameter Real cd=0.005 "damper constant";
      parameter Real Rv0=0.4
        "viscous friction torque at zero velocity in [Nm]";
      parameter Real Rv1=(0.13/160)
        "viscous friction coefficient in [Nms/rad]";
      parameter Real peak=1
        "peak*Rv0 = maximum static friction torque (peak >= 1)";
      SIunits.AngularAcceleration a_ref;
      SIunits.AngularVelocity w_ref;
      SIunits.Angle phi_ref;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.34,
          y=0.02,
          width=0.59,
          height=0.65),
        Documentation(info="<HTML>
<p>
The axis model consists of the <b>controller</b>, the <b>motor</b> including current
controller and the <b>gearbox</b> including gear elasticity and bearing friction.
The only difference to the axis model of joints 4,5,6 (= model axisType2) is
that elasticity and damping in the gear boxes are not neglected.
The component <b>States</b> is a dummy inertia, i.e., the inertia is zero,
to define that the absolute angle and the absolute angular velocity of the
driven gear flange are used as <b>states</b>.
</p>

<p>
The input signal of this component is the desired angular acceleration
of the joint (= reference acceleration). From the acceleration, the
reference position and reference velocity are computed via integration.
The reference input is an acceleration, because the reference signals
have to be \"smooth\" (position has to be differentiable at least 2 times).
Otherwise, the gear elasticity leads to significant oscillations which
are not acceptable.
</p>

<p>
Default values of the parameters are given for the axis of joint 1.
</p>
</HTML>
"),
        Icon(
          Rectangle(extent=[-100, 40; 91, -41], style(
              color=9,
              gradient=2,
              fillColor=9,
              fillPattern=1)),
          Text(extent=[0, 110; 0, 50], string="%name"),
          Text(extent=[-81, 32; 80, -32], string="1")),
        Diagram);
      Modelica.Blocks.Interfaces.InPort inPort_a_ref annotation (extent=[-140
            , -20; -100, 20]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
          extent=[90, -10; 110, 10]);
      GearType1 r3Gear1(
        J=J,
        i=i,
        c=c,
        d=cd,
        Rv0=Rv0,
        Rv1=Rv1,
        peak=peak) annotation (extent=[40, -10; 60, 10]);
      Motor r3Motor(
        k=k,
        wm=w,
        D=D) annotation (extent=[15, -10; 35, 10]);
      Control r3Control annotation (extent=[-13, -10; 7, 10]);
      Modelica.Blocks.Continuous.Integrator integrator1(y(final start={w_ref0}
          )) annotation (extent=[-94, -10; -74, 10]);
      Modelica.Blocks.Continuous.Integrator integrator2(y(final start={
              phi_ref0})) annotation (extent=[-66, -10; -46, 10]);
      Modelica.Blocks.Math.Gain k2(k={i}) annotation (extent=[-54, 20; -34, 40
            ]);
      Modelica.Blocks.Math.Gain k1(k={i}) annotation (extent=[-39, -10; -19,
            10]);
      Modelica.Mechanics.Rotational.Inertia states(
        J=0,
        phi(start=phi_ref0, fixed=true),
        w(start=w_ref0, fixed=true)) annotation (extent=[65, -10; 85, 10]);
    equation
      connect(k1.outPort, r3Control.phi_ref) annotation (points=[-18, 0;
            -15, 0]);
    equation
      connect(r3Motor.outPort_w, r3Control.w) annotation (points=[30, -9.9
            ; 30, -20; 4, -20; 4, -12]);
    equation
      connect(r3Motor.outPort_phi, r3Control.phi) annotation (points=[33,
            -10; 33, -30; -11, -30; -11, -12]);
    equation
      connect(integrator1.outPort, integrator2.inPort) annotation (points=
            [-73, 0; -68, 0]);
    equation
      connect(r3Control.i_ref, r3Motor.i_ref) annotation (points=[8, 0;
            13.05, 0]);
    equation
      connect(integrator2.outPort, k1.inPort) annotation (points=[-45, 0;
            -41, 0]);
    equation
      connect(integrator1.outPort, k2.inPort) annotation (points=[-73, 0;
            -71, 0; -71, 30; -56, 30]);
    equation
      connect(r3Motor.flange_motor, r3Gear1.flange_a) annotation (points=[
            35, 0; 40, 0], style(color=10, thickness=2));
    equation
      connect(integrator1.inPort, inPort_a_ref) annotation (points=[-96, 0
            ; -120, 0]);
    equation
      connect(k2.outPort, r3Control.w_ref) annotation (points=[-33, 30;
            -24, 30; -24, 7; -15, 7]);
    equation
      connect(r3Gear1.flange_b, states.flange_a) annotation (points=[60, 0
            ; 65, 0], style(color=10, thickness=2));
    equation
      connect(states.flange_b, flange) annotation (points=[85, 0; 100, 0]
          , style(color=10, thickness=2));
    equation
      a_ref = inPort_a_ref.signal[1];
      w_ref = integrator1.outPort.signal[1];
      phi_ref = integrator2.outPort.signal[1];
    end AxisType1;
    model AxisType2 "Axis model of the r3 joints 4,5,6 "
      parameter SIunits.Angle phi_ref0=0
        "initial value of reference and of joint angle";
      parameter SIunits.AngularVelocity w_ref0=0
        "initial value of reference and joint speed";
      parameter Real k=0.2365 "gain of motor";
      parameter Real w=6250 "time constant of motor";
      parameter Real D=0.55 "damping constant of motor";
      parameter Real J=1.6e-4 "moment of inertia of motor in [kgm^2]";
      parameter Real i=-99 "gear ratio";
      parameter Real Rv0=21.8
        "viscous friction torque at zero velocity in [Nm]";
      parameter Real Rv1=9.8
        "viscous friction coefficient in [Nms/rad] (R=Rv0+Rv1*abs(qd))";
      parameter Real peak=(26.7/21.8)
        "peak*Rv0 = maximum static friction torque (peak >= 1)";
      SIunits.AngularAcceleration a_ref;
      SIunits.AngularVelocity w_ref;
      SIunits.Angle phi_ref;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.16,
          y=0.01,
          width=0.66,
          height=0.76),
        Documentation(info="<HTML>
<p>
The axis model consists of the <b>controller</b>, the <b>motor</b> including current
controller and the <b>gearbox</b> including gear elasticity and bearing friction.
The only difference to the axis model of joints 1,2,3 (= model axisType1) is
elasticity and damping in the gear boxes are neglected.
The component <b>States</b> is a dummy inertia, i.e., the inertia is zero,
to define that the absolute angle and the absolute angular velocity of the
driven gear flange are used as <b>states</b>.
</p>

<p>
The input signal of this component is the desired angular acceleration
of the joint (= reference acceleration). From the acceleration, the
reference position and reference velocity are computed via integration.
The reference input is an acceleration, because the reference signals
have to be \"smooth\" (position has to be differentiable at least 2 times).
Otherwise, the gear elasticity leads to significant oscillations which
are not acceptable.
</p>

<p>
Default values of the parameters are given for the axis of joint 1.
</p>
</HTML>

"),
        Icon(
          Rectangle(extent=[-100, 40; 91, -41], style(
              color=9,
              gradient=2,
              fillColor=9,
              fillPattern=1)),
          Text(extent=[0, 111; 0, 50], string="%name"),
          Text(extent=[-81, 32; 80, -32], string="2")),
        Diagram);
      Modelica.Blocks.Interfaces.InPort inPort_a_ref annotation (extent=[-139
            , -20; -99, 20]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
          extent=[90, -10; 110, 10]);
      GearType2 r3Gear2(
        J=J,
        i=i,
        Rv0=Rv0,
        Rv1=Rv1,
        peak=peak) annotation (extent=[41, -10; 61, 10]);
      Motor r3Motor(
        k=k,
        wm=w,
        D=D) annotation (extent=[15, -10; 35, 10]);
      Control r3Control annotation (extent=[-12, -10; 8, 10]);
      Modelica.Blocks.Continuous.Integrator integrator1(y(final start={w_ref0}
          )) annotation (extent=[-94, -10; -74, 10]);
      Modelica.Blocks.Continuous.Integrator integrator2(y(final start={
              phi_ref0})) annotation (extent=[-66, -10; -46, 10]);
      Modelica.Blocks.Math.Gain k2(k={i}) annotation (extent=[-50, 20; -30, 40
            ]);
      Modelica.Blocks.Math.Gain k1(k={i}) annotation (extent=[-39, -10; -19,
            10]);
      Modelica.Mechanics.Rotational.Inertia states(
        J=0,
        phi(start=phi_ref0, fixed=true),
        w(start=w_ref0, fixed=true)) annotation (extent=[65, -10; 85, 10]);
    equation
      connect(integrator1.outPort, integrator2.inPort) annotation (points=
            [-73, 0; -68, 0]);
    equation
      connect(r3Control.i_ref, r3Motor.i_ref) annotation (points=[9, 0;
            13.05, 0]);
    equation
      connect(r3Motor.flange_motor, r3Gear2.flange_a) annotation (points=[
            35, 0; 41, 0], style(color=10, thickness=2));
    equation
      connect(k1.outPort, r3Control.phi_ref) annotation (points=[-18, 0;
            -14, 0]);
    equation
      connect(integrator2.outPort, k1.inPort) annotation (points=[-45, 0;
            -41, 0]);
    equation
      connect(integrator1.outPort, k2.inPort) annotation (points=[-73, 0;
            -72, 0; -72, 30; -52, 30]);
    equation
      connect(r3Motor.outPort_w, r3Control.w) annotation (points=[30, -9.9
            ; 30, -20; 5, -20; 5, -12]);
    equation
      connect(r3Motor.outPort_phi, r3Control.phi) annotation (points=[33,
            -10; 33, -30; -10, -30; -10, -12]);
    equation
      connect(k2.outPort, r3Control.w_ref) annotation (points=[-29, 30;
            -22, 30; -22, 7; -14, 7]);
    equation
      connect(integrator1.inPort, inPort_a_ref) annotation (points=[-96, 0
            ; -119, 0]);
    equation
      connect(r3Gear2.flange_b, states.flange_a) annotation (points=[61, 0
            ; 65, 0], style(color=10, thickness=2));
    equation
      connect(states.flange_b, flange) annotation (points=[85, 0; 100, 0]
          , style(color=10, thickness=2));
    equation
      a_ref = inPort_a_ref.signal[1];
      w_ref = integrator1.outPort.signal[1];
      phi_ref = integrator2.outPort.signal[1];
    end AxisType2;
    model MechanicalStructure "Model of the mechanical part of the r3 robot "
      package SIunits = Modelica.SIunits ;
      parameter SIunits.Length loadSize[3]={0.125,0.05,0.05}
        "size of (steel) load box";
      SIunits.Angle q[6] "joint angles";
      SIunits.AngularVelocity qd[6] "joint speeds";
      SIunits.AngularAcceleration qdd[6] "joint accelerations";
      SIunits.Torque tau[6] "joint driving torques";
      annotation (
        Coordsys(
          extent=[-200, -200; 200, 200],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.2,
          y=0,
          width=0.69,
          height=0.83),
        Documentation(info="<HTML>
<p>
This model contains the mechanical components of the r3 robot
(multibody system) including animation information.
</p>
</HTML>
"),
        Icon(
          Rectangle(extent=[-200, 200; 200, -200], style(
              gradient=0,
              fillColor=8,
              fillPattern=1)),
          Text(extent=[-200, 280; 200, 200], string="%name"),
          Text(extent=[-200, -150; -140, -190], string="1"),
          Text(extent=[-200, -30; -140, -70], string="3"),
          Text(extent=[-200, -90; -140, -130], string="2"),
          Text(extent=[-200, 90; -140, 50], string="5"),
          Text(extent=[-200, 28; -140, -12], string="4"),
          Text(extent=[-198, 150; -138, 110], string="6"),
          Rectangle(extent=[-24, -138; -4, -118], style(gradient=1, fillColor=
                  8)),
          Rectangle(extent=[-4, -118; 8, -18], style(gradient=1, fillColor=49)
            ),
          Rectangle(extent=[-24, -130; -4, -124], style(color=0, fillColor=0))
            ,
          Rectangle(extent=[-24, -118; -4, -98], style(gradient=2, fillColor=8
              )),
          Rectangle(extent=[-18, -118; -12, -98], style(pattern=0, fillColor=0
              )),
          Rectangle(extent=[-24, -38; -4, -18], style(gradient=2, fillColor=8)
            ),
          Rectangle(extent=[-18, -38; -12, -18], style(pattern=0, fillColor=0)
            ),
          Rectangle(extent=[-24, -18; -4, 2], style(gradient=1, fillColor=8))
            ,
          Rectangle(extent=[-24, -10; -4, -4], style(color=0, fillColor=0)),
          Rectangle(extent=[-20, 2; -8, 82], style(
              pattern=0,
              gradient=1,
              fillColor=49)),
          Rectangle(extent=[-24, 82; -4, 102], style(gradient=2, fillColor=8))
            ,
          Rectangle(extent=[-18, 82; -12, 102], style(pattern=0, fillColor=0))
            ,
          Rectangle(extent=[-24, 102; -4, 122], style(gradient=1, fillColor=8)
            ),
          Rectangle(extent=[-24, 110; -4, 116], style(color=0, fillColor=0)))
          ,
        Diagram);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis1 annotation (
          extent=[-220, -180; -200, -160]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis2 annotation (
          extent=[-220, -120; -200, -100]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis3 annotation (
          extent=[-220, -60; -200, -40]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis4 annotation (
          extent=[-220, 0; -200, 20]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis5 annotation (
          extent=[-220, 60; -200, 80]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis6 annotation (
          extent=[-220, 120; -200, 140]);
      ModelicaAdditions.MultiBody.Parts.InertialSystem inertial annotation (
          extent=[-100, -200; -80, -180]);
      ModelicaAdditions.MultiBody.Joints.Revolute r1(n={0,1,0}) annotation (
          extent=[-80, -170; -60, -150], rotation=90);
      ModelicaAdditions.MultiBody.Joints.Revolute r2(n={1,0,0}) annotation (
          extent=[-60, -110; -40, -90]);
      ModelicaAdditions.MultiBody.Joints.Revolute r3(n={1,0,0}) annotation (
          extent=[-60, -40; -40, -20], rotation=180);
      ModelicaAdditions.MultiBody.Joints.Revolute r4(n={0,1,0}) annotation (
          extent=[-80, 0; -60, 20], rotation=90);
      ModelicaAdditions.MultiBody.Joints.Revolute r5(n={1,0,0}) annotation (
          extent=[-60, 70; -40, 90]);
      ModelicaAdditions.MultiBody.Joints.Revolute r6(n={0,1,0}) annotation (
          extent=[-70, 120; -50, 140], rotation=90);
      ModelicaAdditions.MultiBody.Parts.Shape b0(
        Shape="cylinder",
        r0={0,-0.4,0},
        LengthDirection={0,1,0},
        WidthDirection={1,0,0},
        Length=0.225,
        Width=0.3,
        Height=0.3,
        Material={0,0,1,1}) annotation (extent=[-50, -180; -30, -160],
          rotation=90);
      ModelicaAdditions.MultiBody.Parts.ShapeBody b1(
        r={0,0,0},
        I22=1.16,
        Shape="box",
        r0={0,-0.175,0},
        LengthDirection={0,1,0},
        WidthDirection={1,0,0},
        Length=0.25,
        Width=0.15,
        Height=0.2,
        Material={1,0,0,0.5}) annotation (extent=[-80, -140; -60, -120],
          rotation=90);
      ModelicaAdditions.MultiBody.Parts.ShapeBody b2(
        r={0,0.5,0},
        rCM={0.172,0.205,0},
        m=56.5,
        I11=2.58,
        I22=0.64,
        I33=2.73,
        I21=-0.46,
        Shape="beam",
        r0={0.15,0,0},
        LengthDirection={0,1,0},
        WidthDirection={0,0,1},
        Length=0.5,
        Width=0.2,
        Height=0.15,
        Material={1,0.7,0,1}) annotation (extent=[-30, -80; -10, -60],
          rotation=90);
      ModelicaAdditions.MultiBody.Parts.ShapeBody b3(
        r={0,0,0},
        rCM={0.064,-0.034,0},
        m=26.4,
        I11=0.279,
        I22=0.245,
        I33=0.413,
        I21=-0.070,
        Shape="box",
        r0={0,-0.075,0},
        LengthDirection={0,1,0},
        WidthDirection={1,0,0},
        Length=0.15,
        Width=0.15,
        Height=0.15,
        Material={1,0,0,0.5}) annotation (extent=[-100, -20; -80, 0], rotation
          =90);
      ModelicaAdditions.MultiBody.Parts.ShapeBody b4(
        r={0,0.73,0},
        rCM={0,0.32,0},
        m=28.7,
        I11=1.67,
        I22=0.081,
        I33=1.67,
        Shape="cylinder",
        r0={0,0.075,0},
        LengthDirection={0,1,0},
        WidthDirection={1,0,0},
        Length=0.73,
        Width=0.1,
        Height=0.1,
        Material={1,0.7,0,1}) annotation (extent=[-80, 40; -60, 60], rotation=
            90);
      ModelicaAdditions.MultiBody.Parts.ShapeBody b5(
        r={0,0,0},
        rCM={0,0.023,0},
        m=5.2,
        I11=1.25,
        I22=0.81,
        I33=1.53,
        Shape="box",
        r0={0,-0.075,0},
        LengthDirection={0,1,0},
        WidthDirection={1,0,0},
        Length=0.225,
        Width=0.075,
        Height=0.1,
        Material={0,0,1,0.5}) annotation (extent=[-30, 80; -10, 100], rotation
          =90);
      ModelicaAdditions.MultiBody.Parts.BoxBody load(
        r={0,0,0},
        r0={0,0.15,0},
        LengthDirection={0,1,0},
        WidthDirection={1,0,0},
        Length=(loadSize[1]),
        Width=(loadSize[2]),
        Height=(loadSize[3]),
        Material={1,0,0,0.5}) annotation (extent=[-70, 160; -50, 180],
          rotation=90);
    equation
      connect(inertial.frame_b, b0.frame_a) annotation (points=[-79.5, -
            190; -40, -190; -40, -180.5], style(
          color=0,
          thickness=2,
          fillColor=4,
          fillPattern=1));
    equation
      connect(r1.frame_a, inertial.frame_b) annotation (points=[-70, -
            170.5; -70, -190; -79.5, -190], style(
          color=0,
          thickness=2,
          fillColor=4,
          fillPattern=1));
    equation
      connect(r1.frame_b, b1.frame_a) annotation (points=[-70, -149.5; -70
            , -140.5], style(
          color=0,
          thickness=2,
          fillColor=4,
          fillPattern=1));
    equation
      connect(b1.frame_b, r2.frame_a) annotation (points=[-70, -119.5; -70
            , -100; -60.5, -100], style(
          color=0,
          thickness=2,
          fillColor=4,
          fillPattern=1));
    equation
      connect(r2.frame_b, b2.frame_a) annotation (points=[-39.5, -100; -20
            , -100; -20, -80.5], style(
          color=0,
          thickness=2,
          fillColor=4,
          fillPattern=1));
    equation
      connect(b2.frame_b, r3.frame_a) annotation (points=[-20, -59.5; -20
            , -30; -39.5, -30], style(color=0, thickness=2));
    equation
      connect(r3.frame_b, b3.frame_a) annotation (points=[-60.5, -30; -90
            , -30; -90, -20.5], style(color=0, thickness=2));
    equation
      connect(r4.frame_b, b4.frame_a) annotation (points=[-70, 20.5; -70,
            39.5], style(
          color=0,
          thickness=2,
          fillColor=4,
          fillPattern=1));
    equation
      connect(r3.frame_b, r4.frame_a) annotation (points=[-60.5, -30; -70
            , -30; -70, -0.5], style(color=0, thickness=2));
    equation
      connect(b4.frame_b, r5.frame_a) annotation (points=[-70, 60.5; -70,
            80; -60.5, 80], style(
          color=0,
          thickness=2,
          fillColor=4,
          fillPattern=1));
    equation
      connect(r5.frame_b, b5.frame_a) annotation (points=[-39.5, 80; -22,
            80; -20, 79.5], style(
          color=0,
          thickness=2,
          fillColor=4,
          fillPattern=1));
    equation
      connect(r6.frame_b, load.frame_a) annotation (points=[-60, 140.5; -
            60, 159.5], style(
          color=0,
          thickness=2,
          fillColor=4,
          fillPattern=1));
    equation
      connect(r5.frame_b, r6.frame_a) annotation (points=[-39.5, 80; -40,
            90; -40, 100; -60, 100; -60, 119.5], style(
          color=0,
          thickness=2,
          fillColor=4,
          fillPattern=1));
    equation
      connect(r1.axis, axis1) annotation (points=[-77, -160; -152, -160; -
            152, -170; -210, -170], style(color=10, thickness=2));
    equation
      connect(r2.axis, axis2) annotation (points=[-50, -93; -50, -80; -152
            , -80; -152, -110; -210, -110], style(color=10, thickness=2));
    equation
      connect(r4.axis, axis4) annotation (points=[-77, 10; -152, 10; -152
            , 10; -210, 10], style(color=10, thickness=2));
    equation
      connect(r5.axis, axis5) annotation (points=[-50, 87; -50, 94; -152,
            94; -152, 70; -210, 70], style(color=10, thickness=2));
    equation
      connect(r6.axis, axis6) annotation (points=[-67, 130; -210, 130],
          style(color=10, thickness=2));
    equation
      connect(r3.axis, axis3) annotation (points=[-50, -37; -50, -50; -210
            , -50], style(color=10, thickness=2));
    equation
      q = {r1.q,r2.q,r3.q,r4.q,r5.q,r6.q};
      qd = der(q);
      qdd = der(qd);
      tau = {r1.axis.tau,r2.axis.tau,r3.axis.tau,r4.axis.tau,r5.axis.tau,r6.
        axis.tau};
    end MechanicalStructure;
    model TwoPuls
      extends Modelica.Blocks.Interfaces.SO;
      parameter Real T1=1;
      parameter Real T2=1;
      parameter Real Height=1;
      annotation (
        Coordsys(extent=[-100, -100; 100, 100]),
        Window(
          x=0.26,
          y=0.25,
          width=0.6,
          height=0.6),
        Icon(Line(points=[-80, 0; -80, 60; -40, 60; -40, 0; 0, 0; 0, -60; 40,
                -60; 40, 0; 80, 0])));
    equation
      y = if time < T1 then Height else if time < T1 + T2 then 0.0 else
        if time < T1 + T2 + T1 then -Height else 0;
    end TwoPuls;
    annotation (Coordsys(
        extent=[0, 0; 263, 381],
        grid=[1, 1],
        component=[20, 20]), Window(
        x=0.12,
        y=0.22,
        width=0.21,
        height=0.42,
        library=1,
        autolayout=1));
    model FullRobot "Complete model of Manutec r3 robot "
      parameter SIunits.Angle q0[6] "initial joint angles";
      output SIunits.Angle q_ref[6] "reference values of joint angles";
      output SIunits.AngularVelocity qd_ref[6]
        "reference values of joint speeds";
      output SIunits.AngularAcceleration qdd_ref[6]
        "reference values of joint accelerations";
      output SIunits.Angle eq[6] "control errors of joint angles";
      output SIunits.AngularVelocity eqd[6] "control errors of joint speeds";

      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Documentation(info="<HTML>
<p>
Complete model of Mantuec r3 robot, including
controller, motor, gearbox, 3D-mechanics model.
The input connectors <b>a_refX</b> are the <b>reference accelerations</b>, i.e., the desired
accelerations, for the 6 joint axes. Via parameter <b>q0</b> the initial
joint angles are defined.
</p>
</HTML>
"),
        Window(
          x=0.18,
          y=0.01,
          width=0.76,
          height=0.88),
        Icon(
          Rectangle(extent=[-100, 90; 100, -100], style(fillColor=8)),
          Text(extent=[0, 154; 0, 94], string="%name"),
          Rectangle(extent=[-20, 56; 0, 73], style(gradient=1, fillColor=8)),
          Rectangle(extent=[-20, 62; 0, 68], style(color=0, fillColor=0)),
          Rectangle(extent=[-20, 41; 0, 56], style(gradient=2, fillColor=8)),
          Rectangle(extent=[-14, 42; -7, 56], style(pattern=0, fillColor=0)),
          Rectangle(extent=[-16, 10; -5, 42], style(
              pattern=0,
              gradient=1,
              fillColor=49)),
          Rectangle(extent=[0, -69; 12, -7], style(gradient=1, fillColor=49))
            ,
          Rectangle(extent=[-20, -7; 0, 10], style(gradient=1, fillColor=8)),
          Rectangle(extent=[-20, -1; 0, 5], style(color=0, fillColor=0)),
          Rectangle(extent=[-14, -21; -7, -7], style(pattern=0, fillColor=0))
            ,
          Rectangle(extent=[-20, -22; 0, -7], style(gradient=2, fillColor=8))
            ,
          Rectangle(extent=[-14, -22; -7, -8], style(pattern=0, fillColor=0))
            ,
          Rectangle(extent=[-20, -69; 0, -54], style(gradient=2, fillColor=8))
            ,
          Rectangle(extent=[-14, -69; -7, -55], style(pattern=0, fillColor=0))
            ,
          Rectangle(extent=[-20, -85; 0, -68], style(gradient=1, fillColor=8))
            ,
          Rectangle(extent=[-20, -79; 0, -73], style(color=0, fillColor=0))));

        ModelicaAdditions.MultiBody.Examples.Robots.r3.Components.MechanicalStructure
         mechanics annotation (extent=[-40, -90; 100, 50]);
      ModelicaAdditions.MultiBody.Examples.Robots.r3.Components.AxisType1
        axis1(phi_ref0=q0[1]) annotation (extent=[-90, -90; -70, -70]);
      ModelicaAdditions.MultiBody.Examples.Robots.r3.Components.AxisType1
        axis2(
        w=5500,
        i=210,
        c=8,
        cd=0.01,
        Rv0=0.5,
        Rv1=(0.1/130),
        phi_ref0=q0[2]) annotation (extent=[-90, -60; -70, -40]);
      ModelicaAdditions.MultiBody.Examples.Robots.r3.Components.AxisType1
        axis3(
        w=5500,
        i=60,
        c=58,
        cd=0.04,
        Rv0=0.7,
        Rv1=(0.2/130),
        phi_ref0=q0[3]) annotation (extent=[-90, -30; -70, -10]);
      ModelicaAdditions.MultiBody.Examples.Robots.r3.Components.AxisType2
        axis4(phi_ref0=q0[4]) annotation (extent=[-90, 0; -70, 20]);
      ModelicaAdditions.MultiBody.Examples.Robots.r3.Components.AxisType2
        axis5(
        k=0.2608,
        J=1.8e-4,
        i=79.2,
        Rv0=30.1,
        Rv1=0.03,
        peak=(39.6/30.1),
        phi_ref0=q0[5]) annotation (extent=[-90, 30; -70, 50]);
      ModelicaAdditions.MultiBody.Examples.Robots.r3.Components.AxisType2
        axis6(
        k=0.0842,
        w=7400,
        D=0.27,
        J=4.3e-5,
        i=-99,
        Rv0=10.9,
        Rv1=3.92,
        peak=(16.8/10.9),
        phi_ref0=q0[6]) annotation (extent=[-90, 60; -70, 80]);
      Modelica.Blocks.Interfaces.InPort a_ref1 annotation (extent=[-110, -85;
            -100, -75]);
      Modelica.Blocks.Interfaces.InPort a_ref2 annotation (extent=[-110, -55;
            -100, -45]);
      Modelica.Blocks.Interfaces.InPort a_ref3 annotation (extent=[-110, -25;
            -100, -15]);
      Modelica.Blocks.Interfaces.InPort a_ref4 annotation (extent=[-110, 5;
            -100, 15]);
      Modelica.Blocks.Interfaces.InPort a_ref5 annotation (extent=[-110, 35;
            -100, 45]);
      Modelica.Blocks.Interfaces.InPort a_ref6 annotation (extent=[-110, 65;
            -100, 75]);
    equation
      connect(axis1.flange, mechanics.axis1) annotation (points=[-70, -80
            ; -56.75, -80; -56.75, -79.5; -43.5, -79.5], style(color=0,
            thickness=2));
    equation
      connect(axis2.flange, mechanics.axis2) annotation (points=[-70, -50
            ; -60, -50; -60, -58.5; -43.5, -58.5], style(color=0, thickness=2))
        ;
    equation
      connect(axis3.flange, mechanics.axis3) annotation (points=[-70, -20
            ; -60, -20; -60, -37.5; -43.5, -37.5], style(color=0, thickness=2))
        ;
    equation
      connect(axis4.flange, mechanics.axis4) annotation (points=[-70, 10;
            -60, 10; -60, -16.5; -43.5, -16.5], style(color=0, thickness=2));
    equation
      connect(axis5.flange, mechanics.axis5) annotation (points=[-70, 40;
            -57, 40; -57, 4.5; -43.5, 4.5], style(color=0, thickness=2));
    equation
      connect(axis6.flange, mechanics.axis6) annotation (points=[-70, 70;
            -53, 70; -53, 25.5; -43.5, 25.5], style(color=0, thickness=2));
    equation
      connect(axis1.inPort_a_ref, a_ref1) annotation (points=[-92, -80;
            -105, -80]);
    equation
      connect(axis6.inPort_a_ref, a_ref6) annotation (points=[-91.9, 70;
            -105, 70]);
    equation
      connect(axis5.inPort_a_ref, a_ref5) annotation (points=[-91.9, 40;
            -105, 40]);
    equation
      connect(axis4.inPort_a_ref, a_ref4) annotation (points=[-91.9, 10;
            -105, 10]);
    equation
      connect(axis3.inPort_a_ref, a_ref3) annotation (points=[-92, -20;
            -105, -20]);
    equation
      connect(axis2.inPort_a_ref, a_ref2) annotation (points=[-92, -50;
            -105, -50]);
    equation
      q_ref = {axis1.phi_ref,axis2.phi_ref,axis3.phi_ref,axis4.phi_ref,
        axis5.phi_ref,axis6.phi_ref};
      qd_ref = {axis1.w_ref,axis2.w_ref,axis3.w_ref,axis4.w_ref,axis5.w_ref,
        axis6.w_ref};
      qdd_ref = {a_ref1.signal[1],a_ref2.signal[1],a_ref3.signal[1],a_ref4.
        signal[1],a_ref5.signal[1],a_ref6.signal[1]};
      eq = q_ref - mechanics.q;
      eqd = qd_ref - mechanics.qd;
    end FullRobot;
    model SimpleControl "Simple PD-controller to control one axis"
      package SIunits = Modelica.SIunits ;
      parameter Real k=0 "gain of P-controller";
      parameter Real d=0
        "gain of D-controller (= velocity dependent damping in the joint)";
      output SIunits.Angle q_ref "reference angle";
      output SIunits.Angle q "actual joint angle";
      output SIunits.AngularVelocity qd "actual joint speed";
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Documentation(info="
"),
        Icon(Rectangle(extent=[-100, -60; 100, 60], style(
              color=0,
              gradient=2,
              fillColor=76)), Text(extent=[0, 131; 0, 70], string="%name")),
        Window(
          x=0.43,
          y=0.1,
          width=0.47,
          height=0.54));
      Modelica.Blocks.Interfaces.InPort inPort_q_ref annotation (extent=[-140
            , -20; -100, 20]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
          extent=[100, -10; 120, 10]);
    equation
      q_ref = inPort_q_ref.signal[1];
      q = flange.phi;
      qd = der(q);
      flange.tau = k*(q - q_ref) + d*qd;
    end SimpleControl;
  end Components;
end r3;
