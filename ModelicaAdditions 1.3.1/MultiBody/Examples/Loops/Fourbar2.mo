model Fourbar2
  extends Modelica.Icons.Example;
  package SIunits = Modelica.SIunits ;
  output SIunits.Angle j1q "angle of revolute joint j1";
  output SIunits.Position j2q "distance of prismatic joint j2";
  output SIunits.AngularVelocity j1qd "axis speed of revolute joint j1";
  output SIunits.Velocity j2qd "axis velocity of prismatic joint j2";
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[1, 1],
      component=[20, 20]),
    Window(
      x=0.2,
      y=0,
      width=0.67,
      height=0.7),
    Documentation(info="Simulate for 1 second (100 output points)
"));
  ModelicaAdditions.MultiBody.Parts.InertialSystem inertial annotation (extent
      =[-100, -80; -80, -60]);
  ModelicaAdditions.MultiBody.Joints.Revolute j1(
    n={1,0,0},
    qd(start=20),
    startValueFixed=true) annotation (extent=[-54, -40; -34, -20]);
  ModelicaAdditions.MultiBody.Joints.Prismatic j2(n={1,0,0}) annotation (
      extent=[10, -80; 30, -60]);
  ModelicaAdditions.MultiBody.Parts.CylinderBody b1(r={0,0.5,0.1}, Radius=0.05
    ) annotation (extent=[-40, -10; -20, 10], rotation=90);
  ModelicaAdditions.MultiBody.Parts.CylinderBody b2(r={0,0.2,0}, Radius=0.05)
    annotation (extent=[40, -60; 60, -40], rotation=90);
  ModelicaAdditions.MultiBody.Parts.BoxBody b0(
    r={1,0,0},
    Width=0.01,
    Height=0.01,
    Material={0,0,1,0.5}) annotation (extent=[-20, -80; 0, -60]);
  ModelicaAdditions.MultiBody.CutJoints.Spherical sphereC annotation (extent=[
        -20, 20; 0, 40]);
  ModelicaAdditions.MultiBody.Parts.CylinderBody b3(
    r={-1,0.3,0.1},
    Radius=0.05,
    Material={0,1,0,0.5}) annotation (extent=[40, 20; 20, 40]);
  ModelicaAdditions.MultiBody.Joints.Revolute rev(n={0,1,0}) annotation (
      extent=[40, -32; 60, -12], rotation=90);
  ModelicaAdditions.MultiBody.Joints.Revolute rev1 annotation (extent=[60, 0;
        80, 20]);
equation
  connect(inertial.frame_b, b0.frame_a) annotation (points=[-79.5, -70; -20.5
        , -70]);
equation
  connect(b0.frame_b, j2.frame_a) annotation (points=[0.5, -70; 9.5, -70]);
equation
  connect(j2.frame_b, b2.frame_a) annotation (points=[30.5, -70; 50, -70; 50,
        -60.5]);
equation
  connect(b1.frame_b, sphereC.frame_a) annotation (points=[-30, 10.5; -30, 30
        ; -20.5, 30]);
equation
  connect(j1.frame_b, b1.frame_a) annotation (points=[-33.5, -30; -30, -30; -
        30, -10.5]);
equation
  connect(rev.frame_a, b2.frame_b) annotation (points=[50, -32.5; 50, -39.5]);
equation
  connect(rev.frame_b, rev1.frame_a) annotation (points=[50, -11.5; 50, 10;
        59.5, 10]);
equation
  connect(b3.frame_b, sphereC.frame_b) annotation (points=[19.5, 30; 0.5, 30])
    ;
equation
  connect(rev1.frame_b, b3.frame_a) annotation (points=[80.5, 10; 90, 10; 90,
        30; 40.5, 30]);
equation
  connect(inertial.frame_b, j1.frame_a) annotation (points=[-79.5, -70; -66, -
        70; -66, -30; -54.5, -30]);
equation
  j1q = j1.q;
  j2q = j2.q;
  j1qd = j1.qd;
  j2qd = j2.qd;
end Fourbar2;
