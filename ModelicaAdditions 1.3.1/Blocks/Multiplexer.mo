package Multiplexer "Combine and split signal connectors of type Real"
  extends Modelica.Icons.Library;

  annotation (
    Coordsys(
      extent=[0, 0; 278, 458],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.05,
      y=0.08,
      width=0.22,
      height=0.49,
      library=1,
      autolayout=1),
    Documentation(info="
<HTML>
<p>
This package contains components to <b>combine</b> and <b>split</b> signal connectors
of type <b>Real</b>.
</p>

<p>
This package is not part of the Modelica standard library, because
it is planned to have just one multiplexer and one demultiplexer
element, once there is better support for vector connectors of
unknown length in Modelica.
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
       Dieter Moormann.</li>
</ul>
<br>


<p><b>Copyright (C) 2000, DLR.</b></p>

<p><i>
The ModelicaAdditions.Blocks.Multiplexer package is <b>free</b> software;
it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  block Multiplex2 "Multiplexer block for two input connectors"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n1=1 "dimension of input signal connector 1";
    parameter Integer n2=1 "dimension of input signal connector 2";
    Modelica.Blocks.Interfaces.InPort inPort1(final n=n1)
      "Connector of Real input signals 1" annotation (extent=[-140, 40; -100,
          80]);
    Modelica.Blocks.Interfaces.InPort inPort2(final n=n2)
      "Connector of Real input signals 2" annotation (extent=[-140, -80; -100,
          -40]);
    Modelica.Blocks.Interfaces.OutPort outPort(final n=n1 + n2)
      "Connector of Real output signals" annotation (extent=[100, -10; 120, 10]
      );
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.2,
        y=0.34,
        width=0.56,
        height=0.6),
      Documentation(info="<HTML>
<p>
The output connector is the <b>concatenation</b> of the two input connectors.
Note, that the dimensions of the input connector signals have to be
explicitly defined via parameters n1 and n2.
</p>
</HTML>
"),
      Icon(
        Line(points=[8, 0; 102, 0]),
        Ellipse(extent=[-14, 16; 16, -14], style(fillColor=73)),
        Line(points=[-98, 60; -60, 60; -4, 6]),
        Line(points=[-98, -60; -60, -60; -4, -4])),
      Diagram(
        Line(points=[-98, 60; -60, 60; -4, 6]),
        Line(points=[-98, -60; -60, -60; -4, -4]),
        Line(points=[8, 0; 102, 0]),
        Ellipse(extent=[-14, 16; 16, -14], style(fillColor=73))));
  equation
    [outPort.signal] = [inPort1.signal; inPort2.signal];
  end Multiplex2;
  block Multiplex3 "Multiplexer block for three input connectors"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n1=1 "dimension of input signal connector 1";
    parameter Integer n2=1 "dimension of input signal connector 2";
    parameter Integer n3=1 "dimension of input signal connector 3";
    Modelica.Blocks.Interfaces.InPort inPort1(final n=n1)
      "Connector of Real input signals 1" annotation (extent=[-140, 50; -100,
          90]);
    Modelica.Blocks.Interfaces.InPort inPort2(final n=n2)
      "Connector of Real input signals 2" annotation (extent=[-140, -20; -100,
          20]);
    Modelica.Blocks.Interfaces.InPort inPort3(final n=n3)
      "Connector of Real input signals 3" annotation (extent=[-140, -90; -100,
          -50]);
    Modelica.Blocks.Interfaces.OutPort outPort(final n=n1 + n2 + n3)
      "Connector of Real output signals" annotation (extent=[100, -10; 120, 10]
      );
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.23,
        y=0.03,
        width=0.56,
        height=0.6),
      Documentation(info="<HTML>
<p>
The output connector is the <b>concatenation</b> of the three input connectors.
Note, that the dimensions of the input connector signals have to be
explicitly defined via parameters n1, n2 and n3.
</HTML>
"),
      Icon(
        Line(points=[8, 0; 102, 0]),
        Line(points=[-100, 70; -60, 70; -4, 6]),
        Line(points=[-100, 0; -12, 0]),
        Line(points=[-100, -70; -62, -70; -4, -4]),
        Ellipse(extent=[-14, 16; 16, -14], style(fillColor=73))),
      Diagram(
        Line(points=[-100, 70; -60, 70; -4, 6]),
        Line(points=[-100, -70; -62, -70; -4, -4]),
        Line(points=[8, 0; 102, 0]),
        Ellipse(extent=[-14, 16; 16, -14], style(fillColor=73)),
        Line(points=[-100, 0; -12, 0])));
  equation
    [outPort.signal] = [inPort1.signal; inPort2.signal; inPort3.signal];
  end Multiplex3;
  block Multiplex4 "Multiplexer block for four input connectors"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n1=1 "dimension of input signal connector 1";
    parameter Integer n2=1 "dimension of input signal connector 2";
    parameter Integer n3=1 "dimension of input signal connector 3";
    parameter Integer n4=1 "dimension of input signal connector 4";
    Modelica.Blocks.Interfaces.InPort inPort1(final n=n1)
      "Connector of Real input signals 1" annotation (extent=[-140, 70; -100,
          110]);
    Modelica.Blocks.Interfaces.InPort inPort2(final n=n2)
      "Connector of Real input signals 2" annotation (extent=[-140, 10; -100,
          50]);
    Modelica.Blocks.Interfaces.InPort inPort3(final n=n3)
      "Connector of Real input signals 3" annotation (extent=[-140, -50; -100,
          -10]);
    Modelica.Blocks.Interfaces.InPort inPort4(final n=n4)
      "Connector of Real input signals 4" annotation (extent=[-140, -110; -100
          , -70]);
    Modelica.Blocks.Interfaces.OutPort outPort(final n=n1 + n2 + n3 + n4)
      "Connector of Real output signals" annotation (extent=[100, -10; 120, 10]
      );
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.33,
        y=0.1,
        width=0.59,
        height=0.67),
      Documentation(info="<HTML>
<p>
The output connector is the <b>concatenation</b> of the four input connectors.
Note, that the dimensions of the input connector signals have to be
explicitly defined via parameters n1, n2, n3 and n4.
</p>
</HTML>
"),
      Icon(
        Line(points=[8, 0; 102, 0]),
        Line(points=[-100, 90; -60, 90; -3, 4]),
        Line(points=[-100, 30; -60, 30; -9, 0]),
        Line(points=[-99, -30; -59, -30; -10, -5]),
        Line(points=[-100, -90; -60, -90; -5, -6]),
        Ellipse(extent=[-15, 15; 15, -15], style(fillColor=73))),
      Diagram(
        Line(points=[-100, 90; -60, 90; -3, 4]),
        Line(points=[-100, -90; -60, -90; -5, -6]),
        Line(points=[8, 0; 102, 0]),
        Ellipse(extent=[-15, 15; 15, -15], style(fillColor=73)),
        Line(points=[-100, 30; -60, 30; -9, 0]),
        Line(points=[-99, -30; -59, -30; -10, -5])));
  equation
    [outPort.signal] = [inPort1.signal; inPort2.signal; inPort3.signal;
      inPort4.signal];
  end Multiplex4;
  block Multiplex5 "Multiplexer block for five input connectors"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n1=1 "dimension of input signal connector 1";
    parameter Integer n2=1 "dimension of input signal connector 2";
    parameter Integer n3=1 "dimension of input signal connector 3";
    parameter Integer n4=1 "dimension of input signal connector 4";
    parameter Integer n5=1 "dimension of input signal connector 5";
    Modelica.Blocks.Interfaces.InPort inPort1(final n=n1)
      "Connector of Real input signals 1" annotation (extent=[-140, 80; -100,
          120]);
    Modelica.Blocks.Interfaces.InPort inPort2(final n=n2)
      "Connector of Real input signals 2" annotation (extent=[-140, 30; -100,
          70]);
    Modelica.Blocks.Interfaces.InPort inPort3(final n=n3)
      "Connector of Real input signals 3" annotation (extent=[-140, -20; -100,
          20]);
    Modelica.Blocks.Interfaces.InPort inPort4(final n=n4)
      "Connector of Real input signals 4" annotation (extent=[-140, -70; -100,
          -30]);
    Modelica.Blocks.Interfaces.InPort inPort5(final n=n5)
      "Connector of Real input signals 5" annotation (extent=[-140, -120; -100
          , -80]);
    Modelica.Blocks.Interfaces.OutPort outPort(final n=n1 + n2 + n3 + n4 + n5)
       "Connector of Real output signals" annotation (extent=[100, -10; 120, 10
          ]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.26,
        y=0.12,
        width=0.59,
        height=0.68),
      Documentation(info="<HTML>
<p>
The output connector is the <b>concatenation</b> of the five input connectors.
Note, that the dimensions of the input connector signals have to be
explicitly defined via parameters n1, n2, n3, n4 and n5.
</p>
</HTML>
"),
      Icon(
        Line(points=[8, 0; 102, 0]),
        Line(points=[-100, 100; -60, 100; -4, 6]),
        Line(points=[-99, 50; -60, 50; -8, 5]),
        Line(points=[-100, 0; -7, 0]),
        Line(points=[-99, -50; -60, -50; -9, -6]),
        Line(points=[-100, -100; -60, -100; -4, -4]),
        Ellipse(extent=[-15, 15; 15, -15], style(fillColor=73))),
      Diagram(
        Line(points=[-100, 100; -60, 100; -4, 6]),
        Line(points=[-100, -100; -60, -100; -4, -4]),
        Line(points=[8, 0; 102, 0]),
        Ellipse(extent=[-15, 15; 15, -15], style(fillColor=73)),
        Line(points=[-99, 50; -60, 50; -8, 5]),
        Line(points=[-100, 0; -7, 0]),
        Line(points=[-99, -50; -60, -50; -9, -6])));
  equation
    [outPort.signal] = [inPort1.signal; inPort2.signal; inPort3.signal;
      inPort4.signal; inPort5.signal];
  end Multiplex5;
  block Multiplex6 "Multiplexer block for six input connectors"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n1=1 "dimension of input signal connector 1";
    parameter Integer n2=1 "dimension of input signal connector 2";
    parameter Integer n3=1 "dimension of input signal connector 3";
    parameter Integer n4=1 "dimension of input signal connector 4";
    parameter Integer n5=1 "dimension of input signal connector 5";
    parameter Integer n6=1 "dimension of input signal connector 6";
    Modelica.Blocks.Interfaces.InPort inPort1(final n=n1)
      "Connector of Real input signals 1" annotation (extent=[-124, 73; -100,
          97]);
    Modelica.Blocks.Interfaces.InPort inPort2(final n=n2)
      "Connector of Real input signals 2" annotation (extent=[-124, 39; -100,
          63]);
    Modelica.Blocks.Interfaces.InPort inPort3(final n=n3)
      "Connector of Real input signals 3" annotation (extent=[-124, 5; -100, 29
          ]);
    Modelica.Blocks.Interfaces.InPort inPort4(final n=n4)
      "Connector of Real input signals 4" annotation (extent=[-124, -29; -100,
          -5]);
    Modelica.Blocks.Interfaces.InPort inPort5(final n=n5)
      "Connector of Real input signals 5" annotation (extent=[-124, -63; -100,
          -39]);
    Modelica.Blocks.Interfaces.InPort inPort6(final n=n6)
      "Connector of Real input signals 6" annotation (extent=[-124, -97; -100,
          -73]);
    Modelica.Blocks.Interfaces.OutPort outPort(final n=n1 + n2 + n3 + n4 + n5
           + n6) "Connector of Real output signals" annotation (extent=[100, -
          10; 120, 10]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.26,
        y=0.12,
        width=0.59,
        height=0.68),
      Documentation(info="<HTML>
<p>
The output connector is the <b>concatenation</b> of the six input connectors.
Note, that the dimensions of the input connector signals have to be
explicitly defined via parameters n1, n2, n3, n4, n5 and n6.
</p>
</HTML>
"),
      Icon(
        Line(points=[8, 0; 102, 0]),
        Ellipse(extent=[-15, 15; 15, -15], style(fillColor=73)),
        Line(points=[-99, 85; -61, 85; -3, 11]),
        Line(points=[-100, 51; -61, 51; -7, 6]),
        Line(points=[-101, 17; -60, 17; -9, 2]),
        Line(points=[-100, -18; -60, -18; -11, -4]),
        Line(points=[-99, -50; -60, -50; -9, -6]),
        Line(points=[-100, -85; -60, -85; -3, -10])),
      Diagram(
        Line(points=[-99, 85; -61, 85; -3, 11]),
        Line(points=[-100, -85; -60, -85; -3, -10]),
        Line(points=[8, 0; 102, 0]),
        Ellipse(extent=[-15, 15; 15, -15], style(fillColor=73)),
        Line(points=[-100, 51; -61, 51; -7, 6]),
        Line(points=[-99, -50; -60, -50; -9, -6]),
        Line(points=[-101, 17; -60, 17; -9, 2]),
        Line(points=[-100, -18; -60, -18; -11, -4])));
  equation
    [outPort.signal] = [inPort1.signal; inPort2.signal; inPort3.signal;
      inPort4.signal; inPort5.signal; inPort6.signal];
  end Multiplex6;
  block DeMultiplex2 "DeMultiplexer block for two output connectors"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n1=1 "dimension of output signal connector 1";
    parameter Integer n2=1 "dimension of output signal connector 2";
    Modelica.Blocks.Interfaces.InPort inPort(final n=n1 + n2)
      "Connector of Real input signals" annotation (extent=[-140, -20; -100, 20
          ]);
    Modelica.Blocks.Interfaces.OutPort outPort1(final n=n1)
      "Connector of Real output signals 1" annotation (extent=[100, 50; 120, 70
          ]);
    Modelica.Blocks.Interfaces.OutPort outPort2(final n=n2)
      "Connector of Real output signals 2" annotation (extent=[100, -70; 120, -
          50]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.35,
        y=0.14,
        width=0.63,
        height=0.59),
      Documentation(info="<HTML>
<p>
The input connector is <b>splitted</b> up into two output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1 and n2.
</p>
</HTML>
"),
      Icon(
        Line(points=[100, 60; 60, 60; 10, 8]),
        Ellipse(extent=[-14, 16; 16, -14], style(fillColor=73)),
        Line(points=[100, -60; 60, -60; 8, -8]),
        Line(points=[-100, 0; -6, 0])),
      Diagram(
        Line(points=[100, 60; 60, 60; 10, 8]),
        Line(points=[100, -60; 60, -60; 8, -8]),
        Line(points=[-100, 0; -6, 0]),
        Ellipse(extent=[-14, 16; 16, -14], style(fillColor=73))));
  equation
    [inPort.signal] = [outPort1.signal; outPort2.signal];
  end DeMultiplex2;
  block DeMultiplex3 "DeMultiplexer block for three output connectors"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n1=1 "dimension of output signal connector 1";
    parameter Integer n2=1 "dimension of output signal connector 2";
    parameter Integer n3=1 "dimension of output signal connector 3";
    Modelica.Blocks.Interfaces.InPort inPort(final n=n1 + n2 + n3)
      "Connector of Real input signals" annotation (extent=[-140, -20; -100, 20
          ]);
    Modelica.Blocks.Interfaces.OutPort outPort1(final n=n1)
      "Connector of Real output signals 1" annotation (extent=[100, 60; 120, 80
          ]);
    Modelica.Blocks.Interfaces.OutPort outPort2(final n=n2)
      "Connector of Real output signals 2" annotation (extent=[100, -10; 120,
          10]);
    Modelica.Blocks.Interfaces.OutPort outPort3(final n=n3)
      "Connector of Real output signals 3" annotation (extent=[100, -80; 120, -
          60]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.19,
        y=0.08,
        width=0.65,
        height=0.68),
      Documentation(info="<HTML>
<p>
The input connector is <b>splitted</b> up into three output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1, n2 and n3.
</p>
</HTML>
"),
      Icon(
        Ellipse(extent=[-14, 16; 16, -14], style(fillColor=73)),
        Line(points=[-100, 0; -6, 0]),
        Line(points=[100, 70; 60, 70; 4, 5]),
        Line(points=[0, 0; 101, 0]),
        Line(points=[100, -70; 61, -70; 5, -5])),
      Diagram(
        Line(points=[100, 70; 60, 70; 4, 5]),
        Line(points=[100, -70; 61, -70; 5, -5]),
        Line(points=[-100, 0; -6, 0]),
        Ellipse(extent=[-16, 15; 14, -15], style(fillColor=73)),
        Line(points=[0, 0; 101, 0])));
  equation
    [inPort.signal] = [outPort1.signal; outPort2.signal; outPort3.signal];
  end DeMultiplex3;
  block DeMultiplex4 "DeMultiplexer block for four output connectors"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n1=1 "dimension of output signal connector 1";
    parameter Integer n2=1 "dimension of output signal connector 2";
    parameter Integer n3=1 "dimension of output signal connector 3";
    parameter Integer n4=1 "dimension of output signal connector 4";
    Modelica.Blocks.Interfaces.InPort inPort(final n=n1 + n2 + n3 + n4)
      "Connector of Real input signals" annotation (extent=[-140, -20; -100, 20
          ]);
    Modelica.Blocks.Interfaces.OutPort outPort1(final n=n1)
      "Connector of Real output signals 1" annotation (extent=[100, 80; 120,
          100]);
    Modelica.Blocks.Interfaces.OutPort outPort2(final n=n2)
      "Connector of Real output signals 2" annotation (extent=[100, 20; 120, 40
          ]);
    Modelica.Blocks.Interfaces.OutPort outPort3(final n=n3)
      "Connector of Real output signals 3" annotation (extent=[100, -40; 120,
          -20]);
    Modelica.Blocks.Interfaces.OutPort outPort4(final n=n4)
      "Connector of Real output signals 4" annotation (extent=[100, -100; 120,
          -80]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.29,
        y=0.12,
        width=0.63,
        height=0.59),
      Documentation(info="<HTML>
<p>
The input connector is <b>splitted</b> up into four output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1, n2, n3 and n4.
</HTML>
"),
      Icon(
        Ellipse(extent=[-14, 16; 16, -14], style(fillColor=73)),
        Line(points=[-100, 0; -6, 0]),
        Line(points=[100, 90; 60, 90; 6, 5]),
        Line(points=[100, 30; 60, 30; 9, 2]),
        Line(points=[100, -30; 60, -30; 8, -4]),
        Line(points=[99, -90; 60, -90; 6, -6])),
      Diagram(
        Line(points=[100, 90; 60, 90; 6, 5]),
        Line(points=[99, -90; 60, -90; 6, -6]),
        Line(points=[-100, 0; -6, 0]),
        Line(points=[100, 30; 60, 30; 9, 2]),
        Line(points=[100, -30; 60, -30; 8, -4]),
        Ellipse(extent=[-16, 15; 14, -15], style(fillColor=73))));
  equation
    [inPort.signal] = [outPort1.signal; outPort2.signal; outPort3.signal;
      outPort4.signal];
  end DeMultiplex4;
  block DeMultiplex5 "DeMultiplexer block for five output connectors"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n1=1 "dimension of output signal connector 1";
    parameter Integer n2=1 "dimension of output signal connector 2";
    parameter Integer n3=1 "dimension of output signal connector 3";
    parameter Integer n4=1 "dimension of output signal connector 4";
    parameter Integer n5=1 "dimension of output signal connector 5";
    Modelica.Blocks.Interfaces.InPort inPort(final n=n1 + n2 + n3 + n4 + n5)
      "Connector of Real input signals" annotation (extent=[-140, -20; -100, 20
          ]);
    Modelica.Blocks.Interfaces.OutPort outPort1(final n=n1)
      "Connector of Real output signals 1" annotation (extent=[100, 70; 120, 90
          ]);
    Modelica.Blocks.Interfaces.OutPort outPort2(final n=n2)
      "Connector of Real output signals 2" annotation (extent=[100, 30; 120, 50
          ]);
    Modelica.Blocks.Interfaces.OutPort outPort3(final n=n3)
      "Connector of Real output signals 3" annotation (extent=[100, -10; 120,
          10]);
    Modelica.Blocks.Interfaces.OutPort outPort4(final n=n4)
      "Connector of Real output signals 4" annotation (extent=[100, -50; 120, -
          30]);
    Modelica.Blocks.Interfaces.OutPort outPort5(final n=n5)
      "Connector of Real output signals 5" annotation (extent=[100, -90; 120, -
          70]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.15,
        y=0.16,
        width=0.63,
        height=0.59),
      Documentation(info="<HTML>
<p>
The input connector is <b>splitted</b> up into five output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1, n2, n3, n4 and n5.
</HTML>
"),
      Icon(
        Ellipse(extent=[-14, 16; 16, -14], style(fillColor=73)),
        Line(points=[-100, 0; -6, 0]),
        Line(points=[99, 80; 60, 80; 6, 5]),
        Line(points=[100, 40; 60, 40; 10, 3]),
        Line(points=[100, 0; 10, 0]),
        Line(points=[100, -40; 61, -40; 11, -7]),
        Line(points=[100, -80; 60, -80; 7, -5])),
      Diagram(
        Line(points=[99, 80; 60, 80; 6, 5]),
        Line(points=[100, -80; 60, -80; 7, -5]),
        Line(points=[-100, 0; -6, 0]),
        Ellipse(extent=[-14, 15; 16, -15], style(fillColor=73)),
        Line(points=[100, 40; 60, 40; 10, 3]),
        Line(points=[100, 0; 10, 0]),
        Line(points=[100, -40; 61, -40; 11, -7])));
  equation
    [inPort.signal] = [outPort1.signal; outPort2.signal; outPort3.signal;
      outPort4.signal; outPort5.signal];
  end DeMultiplex5;
  block DeMultiplex6 "DeMultiplexer block for six output connectors"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n1=1 "dimension of output signal connector 1";
    parameter Integer n2=1 "dimension of output signal connector 2";
    parameter Integer n3=1 "dimension of output signal connector 3";
    parameter Integer n4=1 "dimension of output signal connector 4";
    parameter Integer n5=1 "dimension of output signal connector 5";
    parameter Integer n6=1 "dimension of output signal connector 6";
    Modelica.Blocks.Interfaces.InPort inPort(final n=n1 + n2 + n3 + n4 + n5 +
          n6) "Connector of Real input signals" annotation (extent=[-140, -20;
          -100, 20]);
    Modelica.Blocks.Interfaces.OutPort outPort1(final n=n1)
      "Connector of Real output signals 1" annotation (extent=[100, 80; 120,
          100]);
    Modelica.Blocks.Interfaces.OutPort outPort2(final n=n2)
      "Connector of Real output signals 2" annotation (extent=[100, 44; 120, 64
          ]);
    Modelica.Blocks.Interfaces.OutPort outPort3(final n=n3)
      "Connector of Real output signals 3" annotation (extent=[100, 8; 120, 28]
      );
    Modelica.Blocks.Interfaces.OutPort outPort4(final n=n4)
      "Connector of Real output signals 4" annotation (extent=[100, -28; 120, -
          8]);
    Modelica.Blocks.Interfaces.OutPort outPort5(final n=n5)
      "Connector of Real output signals 5" annotation (extent=[100, -64; 120, -
          44]);
    Modelica.Blocks.Interfaces.OutPort outPort6(final n=n6)
      "Connector of Real output signals 6" annotation (extent=[100, -100; 120,
          -80]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.15,
        y=0.16,
        width=0.63,
        height=0.59),
      Documentation(info="<HTML>
<p>
The input connector is <b>splitted</b> up into six output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1, n2, n3, n4, n5 and n6.
</HTML>
"),
      Icon(
        Ellipse(extent=[-14, 16; 16, -14], style(fillColor=73)),
        Line(points=[-100, 0; -6, 0]),
        Line(points=[99, 90; 60, 90; 5, 10]),
        Line(points=[100, 53; 60, 53; 8, 6]),
        Line(points=[100, 18; 59, 18; 7, 2]),
        Line(points=[100, -19; 60, -19; 13, -2]),
        Line(points=[99, -54; 60, -54; 9, -1]),
        Line(points=[100, -91; 60, -91; 3, -7])),
      Diagram(
        Line(points=[99, 90; 60, 90; 5, 10]),
        Line(points=[100, -91; 60, -91; 3, -7]),
        Line(points=[-100, 0; -6, 0]),
        Ellipse(extent=[-14, 15; 16, -15], style(fillColor=73)),
        Line(points=[100, 53; 60, 53; 8, 6]),
        Line(points=[99, -54; 60, -54; 9, -1]),
        Line(points=[100, 18; 59, 18; 7, 2]),
        Line(points=[100, -19; 60, -19; 13, -2])));
  equation
    [inPort.signal] = [outPort1.signal; outPort2.signal; outPort3.signal;
      outPort4.signal; outPort5.signal; outPort6.signal];
  end DeMultiplex6;
end Multiplexer;
