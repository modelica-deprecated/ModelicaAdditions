encapsulated model Pendulum
  import Modelica.Icons;
  import Modelica.Mechanics.Rotational;
  import ModelicaAdditions.MultiBody.Joints;
  import ModelicaAdditions.MultiBody.Parts;

  extends Icons.Example;
  parameter Real L=0.8 "length of box";
  parameter Real d=1.0 "damping constant";
  Parts.InertialSystem inertial annotation (extent=[-100, 20; -80, 40]);
  Parts.BoxBody boxBody(r={L,0,0}) annotation (extent=[-20, 20; 0, 40]);
  Joints.Revolute revolute(n={0,0,1}) annotation (extent=[-60, 20; -40, 40]);
  Rotational.Damper damper(d=d) annotation (extent=[-60, 60; -40, 80]);
equation
  connect(inertial.frame_b, revolute.frame_a) annotation (points=[-79.5, 30; -
        60.5, 30]);
  connect(revolute.frame_b, boxBody.frame_a) annotation (points=[-39.5, 30; -
        20.5, 30]);
  connect(damper.flange_b, revolute.axis) annotation (points=[-40, 70; -40, 50
        ; -50, 50; -50, 37]);
  connect(damper.flange_a, revolute.bearing) annotation (points=[-60, 70; -60,
        50; -56, 50; -56, 37]);
end Pendulum;
