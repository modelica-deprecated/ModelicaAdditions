encapsulated model Engine2
  import ModelicaAdditions.MultiBody.CutJoints;
  import ModelicaAdditions.MultiBody.Joints;
  import ModelicaAdditions.MultiBody.Parts;
  import ModelicaAdditions.MultiBody.Examples.Loops.Utilities;

  extends Utilities.Engine;
  CutJoints.Spherical spherical annotation (extent=[0, 0; 20, 20]);
  Parts.ShapeBody connectingRod(
    r={-L,0,0},
    rCM={-L/2,0,0},
    m=0.5,
    I33=0.0018,
    Width=0.02,
    Height=0.01) annotation (extent=[72, 0; 52, 20]);
  Joints.Universal univ(nx={0,0,1}, ny={0,1,0}) annotation (extent=[70, -28; 90
        , -8], rotation=90);
equation
  connect(crank.frame_b, spherical.frame_a) annotation (points=[-17.5, 10; -0.5
        , 10]);
  connect(spherical.frame_b, connectingRod.frame_b) annotation (points=[20.5,
        10; 51.5, 10]);
  connect(cyl.frame_b, univ.frame_a) annotation (points=[60.5, -70; 68, -70; 68
        , -40; 80, -40; 80, -28.5]);
  connect(univ.frame_b, connectingRod.frame_a) annotation (points=[80, -7.5; 80
        , 10; 72.5, 10]);
  annotation (Documentation(info="Use the following settings:

experiment StopTime=0.2 Interval=0.002 Tolerance=1.E-8


Perform 'simulate' and then see animation in
Animation window.

  Plot the following variables:

  AngVelDegS: Angular velocity of motor shaft [rev/min]
  x         : position of cylinder [m]
  press     : pressure in cylinder [bar]
"),Commands(file="Engine2.mos" "Simulate and plot x, V"));
end Engine2;
