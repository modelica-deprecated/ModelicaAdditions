package Visualizers "For animation of across vector quantities."

  extends Modelica.Icons.Library;
  annotation (Documentation(info="Special classes that store
vector, acceleration, angular velocity,
and angular acceleration at a cut.

By connecting these to a cut they animate the
relevant quantities in the cut.

The class also contain sensors for forces, torques,
and a sensor that measure both forces and torques.

Note that these sensors measure the forces and torques
transmitted through the sensor. This is necessary
since forces and torques are flow quantities.

"));
  model Velocity
    extends Interfaces.OneFrame_a;
    annotation (Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]), Icon(
        Polygon(points=[6, 74; 18, 89; 21, 68; 16, 70; 2, 23; -2, 24; 11, 72; 6
              , 74], style(color=73, fillColor=73)),
        Text(extent=[-73, 33; 83, -22], string="%name"),
        Rectangle(extent=[-100, 100; 101, -100], style(fillPattern=0))));
    VisualVector velocity(
      Material={0,0,1,0.5},
      category="velocity",
      r=r0a,
      Size=va,
      S=Sa) annotation (extent=[-60, 10; -20, -30]);
  equation
    fa = zeros(3);
    ta = zeros(3);
  end Velocity;

  model Acceleration
    extends Interfaces.OneFrame_a;
    annotation (Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]), Icon(
        Polygon(points=[6, 74; 18, 89; 21, 68; 16, 70; 2, 23; -2, 24; 11, 72; 6
              , 74], style(color=49, fillColor=49)),
        Text(extent=[-73, 33; 83, -22], string="%name"),
        Rectangle(extent=[-100, 100; 101, -100], style(fillPattern=0))));
    VisualVector acceleration(
      Material={1,1,0,0.5},
      category="acceleration",
      r=r0a,
      Size=aa,
      S=Sa) annotation (extent=[-60, 10; -20, -30]);
  equation
    fa = zeros(3);
    ta = zeros(3);
  end Acceleration;

  model AngularVelocity
    extends Interfaces.OneFrame_a;
    annotation (Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]), Icon(
        Polygon(points=[-6, 74; -18, 89; -21, 68; -16, 70; -2, 23; 2, 24; -11,
              72; -6, 74], style(color=65, fillColor=65)),
        Text(extent=[-73, 33; 83, -22], string="%name"),
        Rectangle(extent=[-100, 100; 101, -100], style(fillPattern=0))));
    VisualVector angular_velocity(
      Material={0,1,1,0.5},
      category="angular velocity",
      r=r0a,
      Size=wa,
      S=Sa) annotation (extent=[-49, 20; -10, -19]);
  equation
    fa = zeros(3);
    ta = zeros(3);
  end AngularVelocity;

  model AngularAcceleration
    extends Interfaces.OneFrame_a;
    annotation (Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]), Icon(
        Polygon(points=[-6, 74; -18, 89; -21, 68; -16, 70; -2, 23; 2, 24; -11,
              72; -6, 74], style(color=81, fillColor=81)),
        Text(extent=[-73, 33; 83, -22], string="%name"),
        Rectangle(extent=[-100, 100; 101, -100], style(fillPattern=0))));
    VisualVector angular_acceleration(
      Material={1,0,1,0.5},
      category="angular acceleration",
      r=r0a,
      Size=za,
      S=Sa) annotation (extent=[-40, 10; 0, -30]);
  equation
    fa = zeros(3);
    ta = zeros(3);
  end AngularAcceleration;

  model ForceTorqueSensor
    extends Interfaces.TwoTreeFrames;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Diagram(Line(points=[-100, 0; 104, 0], style(
            color=0,
            thickness=4,
            fillColor=0)), Text(extent=[-40, -20; 30, -40], string=
              "r=0 (fixed)")),
      Icon(
        Polygon(points=[6, 74; 18, 89; 21, 68; 16, 70; 2, 23; -2, 24; 11, 72; 6
              , 74], style(color=41, fillColor=41)),
        Polygon(points=[-6, 74; -18, 89; -21, 68; -16, 70; -2, 23; 2, 24; -11,
              72; -6, 74], style(color=57, fillColor=57)),
        Text(extent=[-73, 33; 83, -22], string="%name"),
        Rectangle(extent=[-100, 100; 101, -100], style(fillPattern=0))));
    VisualVector force(
      category="force",
      r=r0a,
      Size=fa,
      S=Sa) annotation (extent=[-70, 90; -50, 70]);
    VisualVector torque(
      Material={0,1,0,0.5},
      category="torque",
      r=r0a,
      Size=ta,
      S=Sa) annotation (extent=[-70, 60; -50, 40]);
  equation
    Sb = Sa;
    wb = wa;
    zb = za;

    r0b = r0a;
    vb = va;
    ab = aa;
    fa = fb;
    ta = tb;
  end ForceTorqueSensor;

  model ForceSensor
    extends Interfaces.TwoTreeFrames;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Diagram(Line(points=[-100, 0; 104, 0], style(
            color=0,
            thickness=4,
            fillColor=0)), Text(extent=[-40, -20; 30, -40], string=
              "r=0 (fixed)")),
      Icon(
        Polygon(points=[6, 74; 18, 89; 21, 68; 16, 70; 2, 23; -2, 24; 11, 72; 6
              , 74], style(color=41, fillColor=41)),
        Text(extent=[-73, 33; 83, -22], string="%name"),
        Rectangle(extent=[-100, 100; 101, -100], style(fillPattern=0))));
    VisualVector force(
      category="force",
      r=r0a,
      Size=fa,
      S=Sa) annotation (extent=[-70, 90; -50, 70]);
  equation
    // Similar to FrameTranslation with r=0.
    Sb = Sa;
    wb = wa;
    zb = za;

    r0b = r0a;
    vb = va;
    ab = aa;
    fa = fb;
    ta = tb;
  end ForceSensor;

  model TorqueSensor
    extends Interfaces.TwoTreeFrames;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Diagram(Line(points=[-100, 0; 104, 0], style(
            color=0,
            thickness=4,
            fillColor=0)), Text(extent=[-40, -20; 30, -40], string=
              "r=0 (fixed)")),
      Icon(
        Polygon(points=[-6, 74; -18, 89; -21, 68; -16, 70; -2, 23; 2, 24; -11,
              72; -6, 74], style(color=57, fillColor=57)),
        Text(extent=[-73, 33; 83, -22], string="%name"),
        Rectangle(extent=[-100, 100; 101, -100], style(fillPattern=0))));
    VisualVector torque(
      Material={0,1,0,0.5},
      category="torque",
      r=r0a,
      Size=ta,
      S=Sa) annotation (extent=[-70, 60; -50, 40]);
  equation
    // Similar to FrameTranslation with r=0.
    Sb = Sa;
    wb = wa;
    zb = za;

    r0b = r0a;
    vb = va;
    ab = aa;
    fa = fb;
    ta = tb;
  end TorqueSensor;
end Visualizers;
