model Fourbar1
  extends Modelica.Icons.Example;
  package SIunits = Modelica.SIunits ;
  parameter SIunits.Length L=(sqrt(1 + 0.3*0.3 + 0.1*0.1))
    "Length of connecting rod";
  output SIunits.Angle j1q "angle of revolute joint j1";
  output SIunits.Position j2q "distance of prismatic joint j2";
  output SIunits.AngularVelocity j1qd "axis speed of revolute joint j1";
  output SIunits.Velocity j2qd "axis velocity of prismatic joint j2";
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.25,
      y=0,
      width=0.58,
      height=0.67),
    Documentation(info="Simulate for 1 second (100 output points)
"));
  ModelicaAdditions.MultiBody.Parts.InertialSystem inertial annotation (extent
      =[-80, -80; -60, -60]);
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
  ModelicaAdditions.MultiBody.Parts.CylinderBody b3(r={L,0,0}, Radius=0.05)
    annotation (extent=[-16, 40; -36, 60]);
  ModelicaAdditions.MultiBody.CutJoints.ConnectingRod2 barC(L=L, na={0,1,0})
    annotation (extent=[0, 20; -20, 40]);
equation
  connect(inertial.frame_b, b0.frame_a) annotation (points=[-59.5, -70; -20.5
        , -70]);
equation
  connect(b0.frame_b, j2.frame_a) annotation (points=[0.5, -70; 9.5, -70]);
equation
  connect(j2.frame_b, b2.frame_a) annotation (points=[30.5, -70; 50, -70; 50,
        -60.5]);
equation
  connect(j1.frame_b, b1.frame_a) annotation (points=[-33.5, -30; -30, -30; -
        30, -10.5]);
equation
  connect(j1.frame_a, inertial.frame_b) annotation (points=[-54.5, -30; -59.5
        , -30; -59.5, -70]);
equation
  connect(b1.frame_b, barC.frame_b) annotation (points=[-30, 10.5; -30, 30; -
        20.5, 30]);
equation
  connect(barC.frame_a, b2.frame_b) annotation (points=[0.5, 30; 50, 30; 50, -
        39.5]);
equation
  connect(b3.frame_a, barC.frame_c) annotation (points=[-15.5, 50; -8, 50; -
        7.9, 32.1]);
equation
  j1q = j1.q;
  j2q = j2.q;
  j1qd = j1.qd;
  j2qd = j2.qd;
end Fourbar1;
