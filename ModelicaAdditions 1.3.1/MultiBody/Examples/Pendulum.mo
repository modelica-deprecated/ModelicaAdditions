model Pendulum
  extends Modelica.Icons.Example;
  parameter Real L=0.8 "length of box";
  parameter Real d=1.0 "damping constant";
  annotation (Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]), Window(
      x=0.28,
      y=0.02,
      width=0.54,
      height=0.57));
  MultiBody.Parts.InertialSystem inertial annotation (extent=[-100, 20; -80,
        40]);
  MultiBody.Parts.BoxBody boxBody(r={L,0,0}) annotation (extent=[-20, 20; 0,
        40]);
  MultiBody.Joints.Revolute revolute(n={0,0,1}) annotation (extent=[-60, 20; -
        40, 40]);
  Modelica.Mechanics.Rotational.Damper damper(d=d) annotation (extent=[-60, 60
        ; -40, 80]);
equation
  connect(inertial.frame_b, revolute.frame_a) annotation (points=[-79.5, 30; -
        60.5, 30]);
equation
  connect(revolute.frame_b, boxBody.frame_a) annotation (points=[-39.5, 30; -
        20.5, 30]);
equation
  connect(damper.flange_b, revolute.axis) annotation (points=[-40, 70; -40, 50
        ; -50, 50; -50, 37]);
equation
  connect(damper.flange_a, revolute.bearing) annotation (points=[-60, 70; -60
        , 50; -56, 50; -56, 37]);
end Pendulum;
