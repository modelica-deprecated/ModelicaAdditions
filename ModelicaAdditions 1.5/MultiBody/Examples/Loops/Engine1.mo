encapsulated model Engine1
  import ModelicaAdditions.MultiBody.CutJoints;
  import ModelicaAdditions.MultiBody.Parts;
  import ModelicaAdditions.MultiBody.Examples.Loops.Utilities;

  extends Utilities.Engine;
  Parts.ShapeBody rodBody(
    r={L,0,0},
    rCM={L/2,0,0},
    m=0.5,
    I33=0.0018,
    Width=0.02,
    Height=0.01) annotation (extent=[4, 20; -16, 40]);
  CutJoints.ConnectingRod2 rod(
    L=L,
    na={0,0,1},
    r_rela(start={-0.2,0,0}, each fixed=false)) annotation (extent=[20, 0; 0,
        20]);
equation
  connect(crank.frame_b, rod.frame_b) annotation (points=[-17.5, 10; -0.5, 10])
    ;
  connect(rod.frame_a, cyl.frame_b) annotation (points=[20.5, 10; 70, 10; 70, -
        70; 60.5, -70]);
  connect(rod.frame_c, rodBody.frame_a) annotation (points=[12.1, 12.1; 12, 30
        ; 4.5, 30]);
  annotation (Documentation(info="Use the following settings:

experiment StopTime=0.2 Interval=0.002 Tolerance=1.E-8


Perform 'simulate' and then see animation in
Animation window.

  Plot the following variables:

  AngVelDegS: Angular velocity of motor shaft [rev/min]
  x         : position of cylinder [m]
  press     : pressure in cylinder [bar]
"),Commands(file="Engine1.mos" "Simulate and plot x and V"));
end Engine1;
