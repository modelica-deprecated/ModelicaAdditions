package Logical
  extends Modelica.Icons.Library;
  package SIunits = Modelica.SIunits ;

  annotation (
    Coordsys(
      extent=[0, 0; 274, 568],
      grid=[1, 1],
      component=[20, 20]),
    Window(
      x=0.05,
      y=0.06,
      width=0.22,
      height=0.6,
      library=1,
      autolayout=1),
    Documentation(info="
<HTML>
<p>
This package contains components to operate on <b>Boolean signals</b>.
</p>

<p>
This package is not part of the Modelica standard library, because it is
planned to vectorize all components and to support alternatively
the American symbols for the logical operators.
</p>

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
<li><i>June 14, 2000</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized based on an existing Dymola library of
       Dieter Moormann and Hilding Elmqvist.</li>
</ul>
<br>


<p><b>Copyright (C) 2000, DLR.</b></p>

<p><i>
The ModelicaAdditions.Blocks.Logical package is <b>free</b> software;
it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  package Interfaces
    extends Modelica.Icons.Library;

    partial block BooleanSI2SO
      "2 Single Input / 1 Single Output Boolean control block"
      extends Modelica.Blocks.Interfaces.BooleanBlockIcon;

      Modelica.Blocks.Interfaces.BooleanInPort inPort1(final n=1)
        "Connector of Boolean input signal 1" annotation (extent=[-140, 40; -
            100, 80]);
      Modelica.Blocks.Interfaces.BooleanInPort inPort2(final n=1)
        "Connector of Boolean input signal 2" annotation (extent=[-140, -80; -
            100, -40]);
      Modelica.Blocks.Interfaces.BooleanOutPort outPort(final n=1)
        "Connector of Boolean output signal" annotation (extent=[100, -10; 120
            , 10]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.19,
          y=0.16,
          width=0.6,
          height=0.6),
        Icon(Rectangle(extent=[-70, -70; 70, 70], style(
              color=81,
              pattern=1,
              fillColor=30))));

    protected
      Boolean u1=inPort1.signal[1] "Input signal 1";
      Boolean u2=inPort2.signal[1] "Input signal 2";
      Boolean y=outPort.signal[1] "Output signal";
    end BooleanSI2SO;
    model Comparision
      extends Modelica.Blocks.Interfaces.BooleanBlockIcon;

      parameter Real threshold=0 "comparision with respect to threshold";
      Modelica.Blocks.Interfaces.InPort inPort(final n=1)
        "Connector of Real input signal" annotation (extent=[-140, -20; -100,
            20]);
      Modelica.Blocks.Interfaces.BooleanOutPort outPort(final n=1)
        "Connector of Boolean output signal" annotation (extent=[100, -10; 120
            , 10]);

    protected
      Real u=inPort.signal[1] "Input signal";
      Boolean y=outPort.signal[1] "Output signal";
    end Comparision;
    annotation (Coordsys(
        extent=[0, 0; 299, 230],
        grid=[1, 1],
        component=[20, 20]), Window(
        x=0.07,
        y=0.1,
        width=0.24,
        height=0.27,
        library=1,
        autolayout=1));
  end Interfaces;
  block NOT "Logical NOT Block"
    extends Modelica.Blocks.Interfaces.BooleanSISO;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.37,
        y=0.1,
        width=0.55,
        height=0.65),
      Documentation(info="
Logical NOT Block

The output y is true, if the input u is false.
The output y is false, if the input u is true.

+---------------------------+
|   input         output    |
|            ->             |
|     u             y       |
+---------------------------+
|    true          false    |
|    false         true     |
+----------------------------
"),
      Icon(
        Rectangle(extent=[-70, -70; 70, 70], style(
            color=81,
            pattern=1,
            fillColor=30)),
        Text(
          extent=[-100, 32; 100, -28],
          string="1",
          style(color=0)),
        Ellipse(extent=[-90, 20; -50, -20], style(
            color=81,
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Line(points=[-100, 0; -90, 0], style(color=81)),
        Line(points=[70, 0; 100, 0], style(color=81))),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60], style(
            color=81,
            fillColor=30,
            fillPattern=1)),
        Text(
          extent=[-100, 20; 100, -20],
          string="1",
          style(color=0)),
        Ellipse(extent=[-80, 20; -40, -20], style(
            color=81,
            thickness=2,
            gradient=1,
            fillColor=1,
            fillPattern=1)),
        Line(points=[-100, 0; -80, 0], style(color=81)),
        Line(points=[60, 0; 100, 0], style(color=81))));
  equation
    y = not u;
  end NOT;
  block OR "Logical OR Block"
    extends Interfaces.BooleanSI2SO;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.35,
        y=0.17,
        width=0.43,
        height=0.5),
      Documentation(info="
Logical OR Block

The output y is false, if the first input u1 and the
second input u2 are both false.
In all other cases the output y is true.

+---------------------------------+
|     input             output    |
|                  ->             |
|   u1     u2            y        |
+---------------------------------+
|   true   true          true     |
|   true   false         true     |
|   false  true          true     |
|   false  false         false    |
+---------------------------------+
"),
      Icon(
        Text(
          extent=[-100, 70; 100, 10],
          string="1",
          style(color=0)),
        Line(points=[70, 0; 100, 0], style(color=81)),
        Line(points=[-100, 60; -70, 60], style(color=81)),
        Line(points=[-70, -60; -100, -60], style(color=81))),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60], style(
            color=81,
            fillColor=30,
            fillPattern=1)),
        Text(
          extent=[-100, 60; 100, 20],
          string="1",
          style(color=0)),
        Line(points=[60, 0; 100, 0], style(color=81)),
        Line(points=[-100, 60; -60, 60], style(color=81)),
        Line(points=[-100, -60; -60, -60], style(color=81))));
  equation
    y = u1 or u2;
  end OR;
  block AND "Logical AND Block"
    extends Interfaces.BooleanSI2SO;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.35,
        y=0.08,
        width=0.55,
        height=0.65),
      Documentation(info="
Logical AND Block

The output y is true, if the first input u1 and
the second input u2 are both true.
In all other cases the output y is false.

+---------------------------------+
|     input             output    |
|                  ->             |
|   u1     u2            y        |
+---------------------------------+
|   true   true          true     |
|   true   false         false    |
|   false  true          false    |
|   false  false         false    |
+---------------------------------+
"),
      Icon(
        Text(
          extent=[-100, 70; 100, 10],
          string="&",
          style(color=0)),
        Line(points=[70, 0; 100, 0], style(color=81)),
        Line(points=[-100, 60; -70, 60], style(color=81)),
        Line(points=[-100, -60; -70, -60], style(color=81))),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60], style(
            color=81,
            fillColor=30,
            fillPattern=1)),
        Text(
          extent=[-100, 60; 100, 20],
          string="&",
          style(color=0)),
        Line(points=[60, 0; 100, 0], style(color=81)),
        Line(points=[-100, 60; -60, 60], style(color=81)),
        Line(points=[-100, -58; -60, -58], style(color=81))));
  equation
    y = u1 and u2;
  end AND;
  block XOR "Logical Exclusive OR Block"
    extends Interfaces.BooleanSI2SO;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.32,
        y=0.06,
        width=0.55,
        height=0.65),
      Documentation(info="
Logical Exclusive OR Block

The output y is false, if the first input u1 and
the second input u2 are both false or both true.
In all other cases the output y is true.

+---------------------------------+
|     input             output    |
|                  ->             |
|   u1     u2            y        |
+---------------------------------+
|   true   true          false    |
|   true   false         true     |
|   false  true          true     |
|   false  false         false    |
+---------------------------------+
"),
      Icon(
        Text(
          extent=[-100, 70; 100, 10],
          string="=1",
          style(color=0)),
        Line(points=[70, 0; 100, 0], style(color=85)),
        Line(points=[-100, 60; -70, 60], style(color=85)),
        Line(points=[-100, -60; -70, -60], style(color=85))),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60], style(
            color=81,
            fillColor=30,
            fillPattern=1)),
        Text(
          extent=[-100, 60; 100, 20],
          string="=1",
          style(color=0)),
        Line(points=[60, 0; 100, 0], style(color=81)),
        Line(points=[-100, 60; -60, 60], style(color=81)),
        Line(points=[-100, -60; -60, -60], style(color=81))));
  equation
    y = if (u1 and u2) or (not u1 and not u2) then false else true;
  end XOR;
  block NOR "Logical NOR Block"
    extends Interfaces.BooleanSI2SO;
    NOT logicalNOT annotation (extent=[26, -30; 86, 30]);
    OR logicalOR annotation (extent=[-60, -30; 0, 30]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.35,
        y=0.11,
        width=0.55,
        height=0.65),
      Documentation(info="
Logical NOR Block

The output y is true, if the first input u1 and
the second input u2 are both false.
In all other cases the output y is true.

+---------------------------------+
|     input             output    |
|                  ->             |
|   u1     u2            y        |
+---------------------------------+
|   true   true          false    |
|   true   false         false    |
|   false  true          false    |
|   false  false         true     |
+---------------------------------+
"),
      Icon(
        Text(
          extent=[-100, 70; 100, 10],
          string="1",
          style(color=0)),
        Ellipse(extent=[50, 20; 90, -20], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Line(points=[90, 0; 100, 0], style(color=81)),
        Line(points=[-100, 60; -70, 60], style(color=81)),
        Line(points=[-100, -60; -70, -60], style(color=81))));
  equation
    connect(logicalOR.outPort, logicalNOT.inPort) annotation (points=[3, 0;
          20, 0], style(color=81, thickness=2));
  equation
    connect(logicalNOT.outPort, outPort) annotation (points=[89, 0; 110, 0]
        , style(color=81, thickness=2));
  equation
    connect(inPort1, logicalOR.inPort1) annotation (points=[-120, 60; -80,
          60; -80, 18; -66, 18], style(color=81, thickness=2));
  equation
    connect(inPort2, logicalOR.inPort2) annotation (points=[-120, -60; -80,
          -60; -80, -18; -66, -18], style(color=81, thickness=2));
  end NOR;
  block NAND "Logical NAND Block"
    extends Interfaces.BooleanSI2SO;
    NOT logicalNOT annotation (extent=[20, -30; 80, 30]);
    AND logicalAND annotation (extent=[-60, -30; 0, 30]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.25,
        y=0.24,
        width=0.55,
        height=0.65),
      Documentation(info="
Logical NAND Block

The output y is false, if the first input u1 and
the second input u2 are both true.
In all other cases the output y is true.

+---------------------------------+
|     input             output    |
|                  ->             |
|   u1     u2            y        |
+---------------------------------+
|   true   true          false    |
|   true   false         true     |
|   false  true          true     |
|   false  false         true     |
+---------------------------------+
"),
      Icon(
        Text(
          extent=[-100, 70; 100, 10],
          string="&",
          style(color=0)),
        Ellipse(extent=[50, 20; 90, -20], style(
            color=1,
            gradient=3,
            fillColor=1,
            fillPattern=1)),
        Line(points=[90, 0; 100, 0], style(color=85)),
        Line(points=[-100, 60; -70, 60], style(color=85)),
        Line(points=[-100, -60; -70, -60], style(color=85))));
  equation
    connect(logicalNOT.outPort, outPort) annotation (points=[83, 0; 110, 0]
        , style(color=81, thickness=2));
  equation
    connect(inPort1, logicalAND.inPort1) annotation (points=[-120, 60; -80,
          60; -80, 18; -66, 18], style(color=81, thickness=2));
  equation
    connect(inPort2, logicalAND.inPort2) annotation (points=[-120, -60; -80
          , -60; -80, -18; -66, -18], style(color=81, thickness=2));
  equation
    connect(logicalAND.outPort, logicalNOT.inPort) annotation (points=[3, 0
          ; 14, 0], style(color=81, thickness=2));
  end NAND;
  block LogicalSwitch "Logical Switch"
    extends Modelica.Blocks.Interfaces.BooleanBlockIcon;

    Modelica.Blocks.Interfaces.BooleanInPort inPort1(final n=1, signal(final
          start={true})) "Connector of Boolean input signal 1" annotation (
        extent=[-140, 50; -100, 90]);
    Modelica.Blocks.Interfaces.BooleanInPort inPort2(final n=1, signal(final
          start={true})) "Connector of Boolean input signal 2" annotation (
        extent=[-140, -20; -100, 20]);
    Modelica.Blocks.Interfaces.BooleanInPort inPort3(final n=1, signal(final
          start={true})) "Connector of Boolean input signal 3" annotation (
        extent=[-140, -90; -100, -50]);
    Modelica.Blocks.Interfaces.BooleanOutPort outPort(final n=1, signal(final
          start={true})) "Connector of Boolean output signal" annotation (
        extent=[100, -10; 120, 10]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.33,
        y=0.27,
        width=0.6,
        height=0.6),
      Documentation(info="
The LogicalSwitch switches, depending on the
Boolean inPort2 connector (the middle connector),
between the two possible input signals
inPort1 (upper connector) and inPort3 (lower connector).

If inPort2 is true, outPort is set equal to
inPort1, else it is set equal to
inPort2.
"),
      Icon(
        Line(points=[12, 0; 100, 0], style(
            color=81,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-100, 0; -40, 0], style(
            color=81,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-100, -70; -40, -70; -40, -70], style(
            color=81,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-40, 12; -40, -10], style(color=81)),
        Line(points=[-100, 70; -40, 70], style(color=81)),
        Line(points=[-40, 70; 6, 2], style(color=85, thickness=4)),
        Ellipse(extent=[2, 8; 18, -6], style(fillColor=0, fillPattern=1))),
      Diagram(
        Rectangle(extent=[-58, 60; 60, -60], style(
            color=85,
            fillColor=30,
            fillPattern=1)),
        Line(points=[-100, 0; -60, 0]),
        Line(points=[62, 0; 100, 0]),
        Line(points=[36, 0; 100, 0], style(
            color=85,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-100, 0; -40, 0], style(
            color=85,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-40, 12; -40, -10], style(color=85)),
        Line(points=[-22, 40; 6, -2], style(color=81, thickness=4)),
        Ellipse(extent=[-2, 6; 14, -8], style(fillColor=0, fillPattern=1)),
        Line(points=[-98, 70; -74, 70; -74, 42; -24, 42], style(color=85)),
        Line(points=[-98, -70; -72, -70; -72, -38; -18, -38], style(color=85))
        ));
  protected
    Boolean u1(start=true) = inPort1.signal[1] "Input signal 1";
    Boolean u2(start=true) = inPort2.signal[1] "Input signal 2";
    Boolean u3(start=true) = inPort3.signal[1] "Input signal 3";
    Boolean y(start=true) = outPort.signal[1] "Output signal";
  equation

    y = if u2 then u1 else u3;
  end LogicalSwitch;
  block Switch "Switch between two Real signal vectors"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n=1 "size of input and output Real signal vectors";
    Modelica.Blocks.Interfaces.InPort inPort1(final n=n)
      "Connector of Real input signal 1" annotation (extent=[-140, 50; -100, 90
          ]);
    Modelica.Blocks.Interfaces.BooleanInPort inPort2(final n=1, signal(final
          start={true})) "Connector of Boolean input signal 2" annotation (
        extent=[-140, -20; -100, 20]);
    Modelica.Blocks.Interfaces.InPort inPort3(final n=n)
      "Connector of Real input signal 3" annotation (extent=[-140, -90; -100, -
          50]);
    Modelica.Blocks.Interfaces.OutPort outPort(final n=n)
      "Connector of Real output signal" annotation (extent=[100, -10; 120, 10])
      ;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.08,
        y=0.07,
        width=0.6,
        height=0.6),
      Documentation(info="
The Logical.Switch switches, depending on the
logical connector inPort2 (the middle connector)
between the two possible input signals
inPort1 (upper connector) and inPort3 (lower connector).

If inPort2 is true, the outPort is set equal to
inPort1, else it is set equal to
inPort3.
"),
      Icon(
        Line(points=[12, 0; 100, 0], style(
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-100, 0; -40, 0], style(
            color=85,
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-100, -70; -40, -70; -40, -70], style(
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-40, 12; -40, -10], style(color=85)),
        Line(points=[-98, 70; -38, 70]),
        Line(points=[-38, 70; 6, 2], style(thickness=4)),
        Ellipse(extent=[2, 8; 18, -6], style(fillColor=0, fillPattern=1))),
      Diagram(
        Rectangle(extent=[-58, 60; 60, -60], style(fillColor=30, fillPattern=1
            )),
        Line(points=[-100, 0; -40, 0], style(color=85)),
        Line(points=[62, 0; 100, 0]),
        Line(points=[36, 0; 100, 0], style(
            pattern=1,
            thickness=1,
            arrow=0)),
        Line(points=[-40, 12; -40, -10], style(color=85)),
        Line(points=[-22, 40; 6, -2], style(thickness=4)),
        Ellipse(extent=[-2, 6; 14, -8], style(fillColor=0, fillPattern=1)),
        Line(points=[-102, 80; -74, 80; -74, 40; -22, 40]),
        Line(points=[-102, -80; -72, -80; -72, -38; -18, -38])));

  protected
    Real u1[n]=inPort1.signal "Input signal 1";
    Boolean u2(start=true) = inPort2.signal[1] "Input signal 2";
    Real u3[n]=inPort3.signal "Input signal 3";
    Real y[n]=outPort.signal "Output signal";
  equation
    y = if u2 then u1 else u3;
  end Switch;
  block Boolean2Real "Convert Boolean to Real signals"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n=1 "size of input and output signal vectors";
    parameter Real realTrue=1.0 "Output signal for true Boolean input";
    parameter Real realFalse=0.0 "Output signal for false Boolean input";

    Modelica.Blocks.Interfaces.BooleanInPort inPort(final n=n)
      "Connector of Boolean input signals" annotation (extent=[-140, -20; -100
          , 20]);
    Modelica.Blocks.Interfaces.OutPort outPort(final n=n)
      "Connector of Real output signals" annotation (extent=[100, -10; 120, 10]
      );
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.24,
        y=0.26,
        width=0.6,
        height=0.6),
      Documentation(info="
The Boolean2Real block transforms Boolean to Real signals.

If the Boolean input is true, the Real output is
the value of parameter realTrue, otherwise it is realFalse.
"),
      Icon(
        Text(extent=[-62, -8; 138, -48], string="Signal"),
        Text(
          extent=[-130, 48; 70, 8],
          string="Logical",
          style(color=1)),
        Text(extent=[-100, 20; 100, -20], string="=>")),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=30, fillPattern=1
            )),
        Line(points=[-100, 0; -60, 0]),
        Line(points=[62, 0; 100, 0]),
        Line(points=[60, 0; 100, 0], style(
            pattern=1,
            thickness=1,
            arrow=0)),
        Text(
          extent=[-94, 30; 26, 10],
          string="Logical",
          style(color=1)),
        Text(extent=[-60, 10; 60, -10], string="=>"),
        Text(extent=[-28, -10; 92, -30], string="Signal")));

  protected
    Boolean u[n](start=fill(true, n)) = inPort.signal "Input signals";
    Real y[n]=outPort.signal "Output signals";
  equation
    for i in 1:n loop
      y[i] = if u[i] then realTrue else realFalse;
    end for;
  end Boolean2Real;
  model GreaterThan
    extends Interfaces.Comparision;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.3,
        y=0.13,
        width=0.6,
        height=0.6),
      Icon(Text(
          extent=[-70, -50; 70, 50],
          string="> %threshold",
          style(color=0))),
      Diagram(Text(
          extent=[-80, -40; 80, 40],
          string="> %threshold",
          style(color=0))));
  equation
    y = u > threshold;
  end GreaterThan;
  model GreaterEqual
    extends Interfaces.Comparision;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.33,
        y=0.38,
        width=0.6,
        height=0.6),
      Icon(Text(
          extent=[-70, -50; 70, 50],
          string=">= %threshold",
          style(color=0))),
      Diagram(Text(
          extent=[-80, -40; 80, 40],
          string=">= %threshold",
          style(color=0, pattern=0))));
  equation
    y = u >= threshold;
  end GreaterEqual;
  model LessThan
    extends Interfaces.Comparision;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(Text(
          extent=[-70, -50; 70, 50],
          string="< %threshold",
          style(color=0))),
      Diagram(Text(
          extent=[-80, -40; 80, 40],
          string="< %threshold",
          style(color=0))),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6));
  equation
    y = u < threshold;
  end LessThan;
  model LessEqual
    extends Interfaces.Comparision;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Icon(Text(
          extent=[-70, -50; 70, 50],
          string="<= %threshold",
          style(color=0))),
      Diagram(Text(
          extent=[-80, -40; 80, 40],
          string="<= %threshold",
          style(color=0))),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6));
  equation
    y = u <= threshold;
  end LessEqual;
end Logical;
