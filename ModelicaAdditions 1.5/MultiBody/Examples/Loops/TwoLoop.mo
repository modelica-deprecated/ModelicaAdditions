encapsulated model TwoLoop
  import Modelica.Mechanics.Rotational;
  import Modelica.Blocks.Sources;
  import ModelicaAdditions.MultiBody.CutJoints;
  import ModelicaAdditions.MultiBody.Joints;
  import ModelicaAdditions.MultiBody.Parts;

  annotation (
    Coordsys(
      extent=[-200, -200; 200, 200],
      grid=[2, 2],
      component=[20, 20]),
    Documentation(info="Use

experiment StopTime=1.6 NumberOfIntervals=200

Perform 'simulate' and then see animation in
Animation window.

plot j1.q and j1.qd
"),Commands(file="TwoLoop.mos" "Simulate and plot angle and rotation of revolute joint"),
    Icon(
      Rectangle(extent=[-200, -200; 160, 100]),
      Polygon(points=[-200, 100; -158, 140; 200, 140; 160, 100; -200, 100]),
      Polygon(points=[200, 140; 200, -160; 160, -200; 160, 100; 200, 140]),
      Text(
        extent=[-170, 68; 132, -172],
        string="Example",
        style(color=3)),
      Text(
        extent=[-200, 240; 198, 140],
        string="%name",
        style(color=1))));
  Parts.InertialSystem inertial annotation (extent=[-200, -60; -180, -40]);
  Joints.Revolute j1(n={0,0,1}, startValueFixed=true) annotation (extent=[-60,
        -40; -40, -20]);
  Parts.CylinderBody b1(r={0.1,0.5,-0.5}, Radius=0.02) annotation (extent=[-40
        , 0; -20, 20], rotation=90);
  CutJoints.ConnectingRod2 j2(L=1.1, na={1,0,0}) annotation (extent=[-20, 40; 0
        , 60]);
  Parts.CylinderBody b2(
    r={1.1,0,0},
    Radius=0.02,
    Material={0,1,0,0.5}) annotation (extent=[-2, 80; 18, 100]);
  Parts.ShapeBody b3(
    r={-0.2,0,0},
    Width=0.04,
    Height=0.04,
    Material={0,0,1,0.5}) annotation (extent=[40, 0; 20, 20]);
  Joints.Prismatic j3(n={1,0,0}) annotation (extent=[20, -60; 40, -40]);
  Parts.ShapeBody b5(
    r={1.8,0,0},
    Width=0.02,
    Height=0.02,
    Material={0.5,0.5,0.5,0.5}) annotation (extent=[-20, -60; 0, -40]);
  Parts.CylinderBody b6(r={0,-0.3,0}, Radius=0.03) annotation (extent=[100, -20
        ; 120, 0], rotation=90);
  Joints.Prismatic j5(n={0,0,1}, qq(start=-0.5, fixed=false)) annotation (
      extent=[140, -60; 120, -40]);
  Parts.ShapeBody b7(
    r={0,0,-0.3},
    Width=0.03,
    Height=0.03,
    Material={0,1,0,0.5}) annotation (extent=[170, -60; 150, -40]);
  CutJoints.Spherical j4 annotation (extent=[64, 0; 84, 20]);
  Joints.Revolute j6(n={-1,0,0}) annotation (extent=[176, -80; 196, -60],
      rotation=90);
  Joints.Revolute j7(n={0,1,0}) annotation (extent=[154, -100; 174, -80]);
  Parts.ShapeBody b4(
    r={0,0,0.5},
    Width=0.02,
    Height=0.02,
    Material={0.5,0.5,0.5,0.5}) annotation (extent=[20, -100; 40, -80]);
  Parts.Shape shape(
    LengthDirection={0,0,0.4},
    Width=0.02,
    Height=0.02) annotation (extent=[120, -40; 140, -20]);
  Parts.FrameAxes frame(nx={1,-1,1}) annotation (extent=[-152, -60; -132, -40])
    ;
  Rotational.Torque torque annotation (extent=[-140, 0; -120, 20]);
  Rotational.IdealGear gear(ratio=10) annotation (extent=[-110, 0; -90, 20]);
  Rotational.Inertia shaft(J=0.5) annotation (extent=[-80, 0; -60, 20]);
  Sources.Constant constIn(k={10}) annotation (extent=[-178, 0; -158, 20]);
  Parts.FrameTranslation b8(r={-0.8,0,0}) annotation (extent=[-100, -60; -80, -
        40]);
equation
  connect(b1.frame_a, j1.frame_b) annotation (points=[-30, -0.5; -30, -30; -
        39.5, -30]);
  connect(j2.frame_c, b2.frame_a) annotation (points=[-12.1, 52.1; -12, 90; -
        2.5, 90]);
  connect(b1.frame_b, j2.frame_a) annotation (points=[-30, 20.5; -30, 50; -20.5
        , 50]);
  connect(b5.frame_b, j3.frame_a) annotation (points=[0.5, -50; 19.5, -50]);
  connect(b6.frame_b, j4.frame_b) annotation (points=[110, 0.5; 110, 10; 84.5,
        10]);
  connect(j5.frame_b, b6.frame_a) annotation (points=[119.5, -50; 110, -50; 110
        , -20.5]);
  connect(b7.frame_b, j5.frame_a) annotation (points=[149.5, -50; 140.5, -50]);
  connect(j6.frame_b, b7.frame_a) annotation (points=[186, -59.5; 186, -50;
        170.5, -50]);
  connect(j7.frame_b, j6.frame_a) annotation (points=[174.5, -90; 186, -90; 186
        , -80.5]);
  connect(b5.frame_b, b4.frame_a) annotation (points=[0.5, -50; 10, -50; 10, -
        90; 19.5, -90]);
  connect(b4.frame_b, j7.frame_a) annotation (points=[40.5, -90; 153.5, -90]);
  connect(inertial.frame_b, frame.frame_a) annotation (points=[-179.5, -50; -
        152.5, -50]);
  connect(constIn.outPort, torque.inPort) annotation (points=[-157, 10; -142,
        10]);
  connect(torque.flange_b, gear.flange_a) annotation (points=[-120, 10; -110,
        10]);
  connect(gear.flange_b, shaft.flange_a) annotation (points=[-90, 10; -80, 10])
    ;
  connect(shaft.flange_b, j1.axis) annotation (points=[-60, 10; -50, 10; -50, -
        23]);
  connect(j3.frame_b, j4.frame_a) annotation (points=[40.5, -50; 52, -50; 52,
        10; 63.5, 10]);
  connect(j3.frame_b, b3.frame_a) annotation (points=[40.5, -50; 52, -50; 52,
        10; 40.5, 10]);
  connect(b3.frame_b, j2.frame_b) annotation (points=[19.5, 10; 10, 10; 10, 50
        ; 0.5, 50]);
  connect(frame.frame_b, b8.frame_a) annotation (points=[-131.5, -50; -100.5, -
        50]);
  connect(b8.frame_b, b5.frame_a) annotation (points=[-79.5, -50; -20.5, -50]);
  connect(b8.frame_b, j1.frame_a) annotation (points=[-79.5, -50; -68, -50; -68
        , -30; -60.5, -30]);
  connect(j5.frame_b, shape.frame_a) annotation (points=[119.5, -50; 110, -50;
        110, -30; 119.5, -30]);
end TwoLoop;
