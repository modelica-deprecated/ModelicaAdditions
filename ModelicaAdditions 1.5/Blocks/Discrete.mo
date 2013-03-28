package Discrete "Discrete input/output blocks with fixed sample period"

  extends Modelica.Icons.Library;

  annotation (Documentation(info="<html>
<p>
This package contains <b>discrete control blocks</b>
with <b>fixed sample period</b>.
Every component of this package is structured in the following way:
</p>

<ol>
<li> A component has <b>continuous real</b> input and output signals.</li>
<li> The <b>input</b> signals are <b>sampled</b> by the given sample period
     defined via parameter <b>samplePeriod</b>.
     The first sample instant is defined by parameter <b>startTime</b>.
<li> The <b>output</b> signals are computed from the sampled input signals.
</ol>

<p>
A <b>sampled data system</b> may consist of components of package <b>Discrete</b>
and of every other purely <b>algebraic</b> input/output block, such
as the components of packages <b>Modelica.Blocks.Math</b>,
<b>Modelica.Blocks.Nonlinear</b> or <b>Modelica.Blocks.Sources</b>.
</p>

<p>
This package contains the following components:
</p>

<pre>
   <b>Sampler</b>           Ideal sampling of continuous signals
   <b>ZeroOrderHold</b>     Zero order hold of a sampled-data system
   <b>FirstOrder</b>        Discrete-time approximation of first order system
   <b>UnitDelay</b>         Delay input signal by one sampling period
   <b>TransferFunction</b>  Discrete-time approximation of transfer function
   <b>StateSpace</b>        Discrete-time approximation of state space system
   <b>TriggeredSampler</b>  Triggered sampling of continuous signals
   <b>TriggeredMax</b>      Compute maximum, absolute value of continuous signal
                     at trigger instants
</pre>

<p>
This package is not part of the Modelica standard library, because it is
planned to realize an improved package with vectorized components (similiar
to the Modelica.Blocks.Continuous package) and
several different ways to define the sample period. Especially,
the sample period may optionally be defined via an outer parameter in a
higher level.
This features cannot be provided in a satisfactory way in Modelica version 1.3,
due to some missing properties of the replaceable attribute.
</p>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
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
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New components TriggeredSampler and TriggeredMax added.</li>
<li><i>June 18, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized based on a corresponding library of Dieter Moormann and
       Hilding Elmqvist.</li>
</ul>
<br>

<p><b>Copyright &copy; 2000-2002, DLR.</b></p>

<p><i>
The Discrete package is <b>free</b> software;
it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  package Interfaces "Interface definitions of sampled input/output blocks"

    extends Modelica.Icons.Library;

    partial block DiscreteBlockIcon
      "Graphical layout of discrete block component icon"
      annotation (Icon(Rectangle(extent=[-100, -100; 100, 100], style(color=3,
                fillColor=52)), Text(extent=[-150, 150; 150, 110], string=
                "%name")));
    end DiscreteBlockIcon;

    partial block DiscreteBlock "Base class of discrete control blocks"
      extends DiscreteBlockIcon;

      parameter SI.Time samplePeriod(min=100*Modelica.Constants.eps) = 0.1
        "Sample period of component";
      parameter SI.Time startTime=0 "First sample time instant";
      output Boolean sampleTrigger "True, if sample time instant";
      output Boolean firstTrigger "Rising edge signals first sample instant";
    equation
      sampleTrigger = sample(startTime, samplePeriod);
      when sampleTrigger then
        firstTrigger = time <= startTime + samplePeriod/2;
      end when;
    end DiscreteBlock;

    partial block DiscreteSISO
      "Single Input Single Output discrete control block"

      extends DiscreteBlock;
      output Real u "sampled input signal";
      output Real y "sampled output signal";

      Modelica.Blocks.Interfaces.InPort inPort(final n=1)
        "Connector with an input signal of type Real" annotation (extent=[-140
            , -20; -100, 20]);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=1)
        "Connector with an output signal of type Real" annotation (extent=[100
            , -10; 120, 10]);
    equation
      when sampleTrigger then
        u = inPort.signal[1];
      end when;
      y = outPort.signal[1];
    end DiscreteSISO;

    partial block DiscreteMIMO
      "Multiple Input Multiple Output discrete control block"

      extends DiscreteBlock;
      parameter Integer nin=1 "Number of inputs";
      parameter Integer nout=1 "Number of outputs";
      output Real u[nin] "Sampled input signals";
      output Real y[nout] "Sampled output signals";

      Modelica.Blocks.Interfaces.InPort inPort(final n=nin)
        "Connector with input signals of type Real" annotation (extent=[-140, -
            20; -100, 20]);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=nout)
        "Connector with output signals of type Real" annotation (extent=[100, -
            10; 120, 10]);
      annotation (Documentation(info="<html>
<p>
Block has a continuous input and a continuous output signal vector
which are sampled due to the defined <b>samplePeriod</b> parameter.
</p>
</HTML>
"));
    equation
      when sampleTrigger then
        u = inPort.signal;
      end when;
      y = outPort.signal;
    end DiscreteMIMO;

    partial block DiscreteMIMOs
      "Multiple Input Multiple Output discrete control block"
      parameter Integer n=1 "Number of inputs (= number of outputs)";
      extends DiscreteBlock;
      output Real u[n] "Sampled input signals";
      output Real y[n] "Sampled output signals";

      Modelica.Blocks.Interfaces.InPort inPort(final n=n)
        "Connector with input signals of type Real" annotation (extent=[-140, -
            20; -100, 20]);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=n)
        "Connector with output signals of type Real" annotation (extent=[100, -
            10; 120, 10]);
      annotation (Documentation(info="<html>
<p>
Block has a continuous input and a continuous output signal vector
where the signal sizes of the input and output vector are identical.
These signals are sampled due to the defined <b>samplePeriod</b> parameter.
</p>
</HTML>
"));
    equation
      when sampleTrigger then
        u = inPort.signal;
      end when;
      outPort.signal = y;
    end DiscreteMIMOs;

    partial block SVdiscrete "Discrete Single-Variable controller"
      extends DiscreteBlock;
      output Real u_s "Sampled, scalar setpoint input signal";
      output Real u_m "Sampled, scalar measurement input signal";
      output Real y "Scalar actuator output signal";

      Sampler sampler_s(
        final n=1,
        final samplePeriod=samplePeriod,
        final startTime=startTime) annotation (extent=[-100, -10; -80, 10]);
      Sampler sampler_m(
        final n=1,
        final samplePeriod=samplePeriod,
        final startTime=startTime) annotation (extent=[-10, -100; 10, -80],
          rotation=90);
      Modelica.Blocks.Interfaces.InPort inPort_s(final n=1)
        "Connector of setpoint input signal" annotation (extent=[-140, -20; -
            100, 20]);
      Modelica.Blocks.Interfaces.InPort inPort_m(final n=1)
        "Connector of measurement input signal" annotation (extent=[20, -100; -
            20, -140], rotation=-90);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=1)
        "Connector of actuator output signal" annotation (extent=[100, -10; 120
            , 10]);
      annotation (Diagram(
          Text(
            extent=[-100, 34; -140, 24],
            string="(setpoint)",
            style(color=0)),
          Text(
            extent=[100, 22; 130, 14],
            string="(actuator)",
            style(color=0)),
          Text(
            extent=[-70, -112; -20, -102],
            string=" (measurement)",
            style(color=0))));
    equation
      connect(inPort_s, sampler_s.inPort) annotation (points=[-120, 0; -102, 0]
        );
      connect(inPort_m, sampler_m.inPort) annotation (points=[0, -120; 0, -102]
        );
      u_s = sampler_s.u[1];
      u_m = sampler_m.u[1];
      y = outPort.signal[1];
    end SVdiscrete;

    partial block MVdiscrete "Discrete Multi-Variable controller"
      extends DiscreteBlock;
      parameter Integer nu_s=1 "Number of setpoint inputs";
      parameter Integer nu_m=1 "Number of measurement inputs";
      parameter Integer ny=1 "Number of actuator outputs";
      output Real u_s[nu_s] "Sampled setpoint input signals";
      output Real u_m[nu_m] "Sampled measurement input signals";
      output Real y[ny] "Actuator output signals";

      Sampler sampler_s(
        final n=nu_s,
        final samplePeriod=samplePeriod,
        final startTime=startTime) annotation (extent=[-90, -10; -70, 10]);
      Sampler sampler_m(
        final n=nu_m,
        final samplePeriod=samplePeriod,
        final startTime=startTime) annotation (extent=[-10, -90; 10, -70],
          rotation=90);
      Modelica.Blocks.Interfaces.InPort inPort_s(final n=nu_s)
        "Connector of setpoint input signals" annotation (extent=[-140, -20; -
            100, 20]);
      Modelica.Blocks.Interfaces.InPort inPort_m(final n=nu_m)
        "Connector of measurement input signals" annotation (extent=[20, -100;
            -20, -140], rotation=-90);
      Modelica.Blocks.Interfaces.OutPort outPort(final n=ny)
        "Connector of actuator output signals" annotation (extent=[100, -10;
            120, 10]);
      annotation (Diagram(
          Text(extent=[-100, -10; -80, -30], string="u_s"),
          Text(
            extent=[-98, 34; -138, 24],
            string="(setpoint)",
            style(color=0)),
          Text(
            extent=[98, 24; 138, 14],
            string="(actuator)",
            style(color=0)),
          Text(
            extent=[-62, -110; -12, -100],
            string=" (measurement)",
            style(color=0))));
    equation
      connect(inPort_s, sampler_s.inPort) annotation (points=[-120, 0; -92, 0])
        ;
      connect(inPort_m, sampler_m.inPort) annotation (points=[0, -120; 0, -92])
        ;
      u_s = sampler_s.u;
      u_m = sampler_m.u;
      y = outPort.signal;
    end MVdiscrete;
  end Interfaces;

  block Sampler "Ideal sampling of continuous signals"
    extends Interfaces.DiscreteMIMOs;

    annotation (
      Icon(
        Ellipse(extent=[-25, -10; -45, 10], style(color=3, fillColor=7)),
        Ellipse(extent=[45, -10; 25, 10], style(color=73, fillColor=7)),
        Line(points=[-100, 0; -45, 0], style(color=3)),
        Line(points=[45, 0; 100, 0], style(color=73)),
        Line(points=[-35, 0; 30, 35], style(color=3))),
      Diagram(
        Ellipse(extent=[-25, -10; -45, 10], style(color=3, fillColor=7)),
        Ellipse(extent=[45, -10; 25, 10], style(color=73, fillColor=7)),
        Line(points=[-100, 0; -45, 0], style(color=3)),
        Line(points=[45, 0; 100, 0], style(color=73)),
        Line(points=[-35, 0; 30, 35], style(color=3))),
      Documentation(info="<HTML>
<p>
Samples the continues input signals with a sampling rate defined
via parameter <b>samplePeriod</b>.
</p>
</HTML>
"));
  equation
    when sampleTrigger then
      y = u;
    end when;
  end Sampler;

  block ZeroOrderHold "Zero order hold of a sampled-data system"
    extends Interfaces.DiscreteMIMOs;
  protected
    Real ySample[n];
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.3,
        y=0.07,
        width=0.63,
        height=0.68),
      Icon(Line(points=[-78, -42; -52, -42; -52, 0; -26, 0; -26, 24; -6, 24; -6
              , 64; 18, 64; 18, 20; 38, 20; 38, 0; 44, 0; 44, 0; 62, 0])),
      Documentation(info="<HTML>
<p>
The output is identical to the sampled input signal at sample
time instants and holds the output at the value of the last
sample instant during the sample points.
</p>
</HTML>
"));
  equation
    when sampleTrigger then
      ySample = u;
    end when;
    /* Define y=ySample with an infinitesimal delay to break potential
       algebraic loops if both the continuous and the discrete part have
       direct feedthrough
    */
    y = pre(ySample);
  end ZeroOrderHold;

  block FirstOrderHold "First order hold of a sampled-data system"
    extends Interfaces.DiscreteMIMOs;
  protected
    Real ySample[n];
    Real tSample;
    Real c[n];
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.21,
        y=0.08,
        width=0.75,
        height=0.76),
      Icon(Line(points=[-79, -41; -59, -33; -40, 1; -20, 9; 0, 63; 21, 20; 41,
              10; 60, 20]), Line(points=[60, 19; 81, 10])),
      Documentation(info="<HTML>
<p>
The output signal is the extrapolation through the
values of the last two sampled input signals.
</p>
</HTML>
"));
  equation
    when sampleTrigger then
      ySample = u;
      tSample = time;
      c = if firstTrigger then zeros(n) else (ySample - pre(ySample))/
        samplePeriod;
    end when;
    /* Use pre(ySample) and pre(c) to break potential algebraic loops by an
       infinitesimal delay if both the continuous and the discrete part
       have direct feedthrough.
    */
    y = pre(ySample) + pre(c)*(time - tSample);
  end FirstOrderHold;

  block UnitDelay "Unit Delay Block"
    parameter Real yStart[:]={0} "Initial values of output signals";
    extends Interfaces.DiscreteMIMOs(
      final n=size(yStart, 1),
      y(final start=yStart),
      outPort(signal(start=yStart)));

  protected
    Real yTemp[n](start=yStart);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.24,
        y=0.09,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p>
This block describes a unit delay:
</p>

<pre>
          1
     y = --- * u
          z
</pre>

<p>
that is, the output signal y is the input signal u of the
previous sample instant. Before the second sample instant,
the output y is identical to parameter yStart.
</p>

<p><b>Release Notes:</b></p>
<ul>
<li><i>June 13, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized, based on a model of Dieter Moormann.
</li>
</ul>

</HTML>
"),
      Icon(
        Line(points=[-30, 0; 30, 0]),
        Text(extent=[-90, 10; 90, 90], string="1"),
        Text(extent=[-90, -10; 90, -90], string="z")),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60], style(color=73)),
        Text(extent=[-160, 10; -140, -10], string="u"),
        Text(extent=[115, 10; 135, -10], string="y"),
        Line(points=[-100, 0; -60, 0], style(color=73)),
        Line(points=[60, 0; 100, 0], style(color=73)),
        Line(points=[40, 0; -40, 0], style(color=0)),
        Text(
          extent=[-55, 55; 55, 5],
          string="1",
          style(color=0)),
        Text(
          extent=[-55, -5; 55, -55],
          string="z",
          style(color=0))));
  equation
    when sampleTrigger then
      yTemp = u;
    end when;
    when sampleTrigger then
      y = pre(yTemp);
    end when;
  end UnitDelay;

  block TransferFunction "Discrete Transfer Function block"
    parameter Real b[:]={1} "Numerator coefficients of transfer function.";
    parameter Real a[:]={1,1} "Denominator coefficients of transfer function.";
    extends Interfaces.DiscreteSISO;
    output Real x[size(a, 1) - 1]
      "State of transfer function from controller canonical form";
  protected
    parameter Integer nb=size(b, 1) "Size of Numerator of transfer function";
    parameter Integer na=size(a, 1) "Size of Denominator of transfer function";
    Real x1;
    Real xext[size(a, 1)];
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.25,
        y=0.08,
        width=0.65,
        height=0.69),
      Documentation(info="<html>
<p>The <b>discrete transfer function</b> block defines the
transfer function between the input signal u and the output
signal y. The numerator has the order nb-1, the denominator
has the order na-1.</p>

<pre>          b(1)*z^(nb-1) + b(2)*z^(nb-2) + ... + b(nb)
   y(z) = -------------------------------------------- * u(z)
          a(1)*z^(na-1) + a(2)*z^(na-2) + ... + a(na)
</pre>

<p>State variables <b>x</b> are defined according to
<b>controller canonical</b> form. Initial values of the
states can be set as start values of <b>x</b>.<p>

<p>Example:</p>

<pre>     Blocks.Discrete.TransferFunction g(b = {2,4}, a = {1,3});
</pre>

<p>results in the following transfer function:</p>

<pre>        2*z + 4
   y = --------- * u
         z + 3
</pre>

<p><b>Release Notes:</b></p>

<ul>
<li><i>November 15, 2000</i>
    by <a href=\"http://www.dynasim.se\">Hans Olsson</a>:<br>
    Converted to when-semantics of Modelica 1.4 with special
    care to avoid unnecessary algebraic loops.</li>
<li><i>June 18, 2000</i>
    by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
    Realized based on a corresponding model of Dieter Moormann
    and Hilding Elmqvist.</li>
</ul>
</HTML>
"),
      Icon(
        Line(points=[82, 0; -84, 0], style(color=73)),
        Text(
          extent=[-92, 92; 86, 12],
          string="b(z)",
          style(color=73)),
        Text(
          extent=[-90, -12; 90, -90],
          string="a(z)",
          style(color=73))),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60], style(fillPattern=0)),
        Line(points=[40, 0; -44, 0], style(color=0, thickness=2)),
        Text(
          extent=[-54, 54; 54, 4],
          string="b(z)",
          style(color=0)),
        Text(
          extent=[-54, -6; 56, -56],
          string="a(z)",
          style(color=0)),
        Line(points=[-100, 0; -60, 0]),
        Line(points=[60, 0; 100, 0])));
  equation
    when sampleTrigger then
      /* State variables x are defined according to
       controller canonical form. */
      x1 = (u - a[2:size(a, 1)]*pre(x))/a[1];
      xext = vector([x1; pre(x)]);
      x = xext[1:size(x, 1)];
      y = vector([zeros(na - nb, 1); b])*xext;
    end when;
    /* This is a non-sampled equation and above there are two separate
       when-clauses. This breaks feeback loops without direct terms,
       since in that case y will be independent of x1 (and only dependent
       on pre(x)).
    */
    /* Corresponding (simpler) version using when-semantics of Modelica 1.3:
   equation
     when sampleTrigger then
      [x; xn] = [x1; pre(x)];
      [u] = transpose([a])*[x1; pre(x)];
      [y] = transpose([zeros(na - nb, 1); b])*[x1; pre(x)];
     end when;
*/
  end TransferFunction;

  block StateSpace "Discrete State Space block"
    parameter Real A[:, size(A, 1)]=[1, 0; 0, 1]
      "Matrix A of state space model";
    parameter Real B[size(A, 1), :]=[1; 1] "Matrix B of state space model";
    parameter Real C[:, size(A, 1)]=[1, 1] "Matrix C of state space model";
    parameter Real D[size(C, 1), size(B, 2)]=zeros(size(C, 1), size(B, 2))
      "Matrix D of state space model";

    extends Interfaces.DiscreteMIMO(final nin=size(B, 2), final nout=size(C, 1)
      );
    output Real x[size(A, 1)] "State vector";

    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.25,
        y=0.18,
        width=0.6,
        height=0.65),
      Documentation(info="<html>
<p>
The <b>discrete state space</b> block defines the relation
between the input u=inPort.signal and the output
y=outPort.signal in state space form:
</p>

<pre>
    x = A * pre(x) + B * u
    y = C * pre(x) + D * u
</pre>

<p>
where pre(x) is the value of the discrete state x at
the previous sample time instant.
The input is a vector of length nu, the output is a vector
of length ny and nx is the number of states. Accordingly
</p>
<pre>
        A has the dimension: A(nx,nx),
        B has the dimension: B(nx,nu),
        C has the dimension: C(ny,nx),
        D has the dimension: D(ny,nu)
</pre>

<p>
Example:
</p>
<pre>
     parameter: A = [0.12, 2;3, 1.5]
     parameter: B = [2, 7;3, 1]
     parameter: C = [0.1, 2]
     parameter: D = zeros(ny,nu)
results in the following equations:

  [x[1]]   [0.12  2.00] [pre(x[1])]   [2.0  7.0] [u[1]]
  [    ] = [          ]*[         ] + [        ]*[    ]
  [x[2]]   [3.00  1.50] [pre(x[2])]   [0.1  2.0] [u[2]]

                             [pre(x[1])]            [u[1]]
       y[1]   = [0.1  2.0] * [         ] + [0  0] * [    ]
                             [pre(x[2])]            [u[2]]
</pre>
</HTML>
"),
      Icon(
        Text(extent=[-90, 15; -15, 90], string="A"),
        Text(extent=[15, 15; 90, 90], string="B"),
        Text(extent=[-52, 28; 54, -20], string="z"),
        Text(extent=[-90, -15; -15, -90], string="C"),
        Text(extent=[15, -15; 90, -90], string="D")),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60], style(fillPattern=0)),
        Text(
          extent=[-54, 50; 52, -10],
          string="zx=Ax+Bu",
          style(
            color=0,
            gradient=0,
            fillColor=10,
            fillPattern=0)),
        Text(
          extent=[-56, 14; 54, -50],
          string="  y=Cx+Du",
          style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Line(points=[-102, 0; -60, 0]),
        Line(points=[60, 0; 100, 0])));
  equation
    when sampleTrigger then
      x = A*pre(x) + B*u;
      y = C*pre(x) + D*u;
    end when;
  end StateSpace;

  block TriggeredSampler "Triggered sampling of continuous signals"
    extends Interfaces.DiscreteBlockIcon;
    parameter Integer n=1 "number of input signals (= number output signals)";
    replaceable type SignalType = Real "type of input and output signal";
    parameter SignalType y0[n]=zeros(n) "initial values of output signals";

    annotation (
      Icon(
        Ellipse(extent=[-25, -10; -45, 10], style(color=3, fillColor=7)),
        Ellipse(extent=[45, -10; 25, 10], style(color=73, fillColor=7)),
        Line(points=[-100, 0; -45, 0], style(color=3)),
        Line(points=[45, 0; 100, 0], style(color=73)),
        Line(points=[0, -100; 0, -26], style(color=5)),
        Line(points=[-35, 0; 28, -48], style(color=3))),
      Diagram(
        Ellipse(extent=[-25, -10; -45, 10], style(color=3, fillColor=7)),
        Ellipse(extent=[45, -10; 25, 10], style(color=73, fillColor=7)),
        Line(points=[-100, 0; -45, 0], style(color=3)),
        Line(points=[45, 0; 100, 0], style(color=73)),
        Line(points=[-35, 0; 28, -48], style(color=3)),
        Line(points=[0, -100; 0, -26], style(color=5))),
      Documentation(info="<HTML>
<p>
Samples the continuous input signals whenever the trigger input
signal is rising (i.e., trigger.signal[1] changes from <b>false</b> to
<b>true</b>) and provides the sampled input signals as outputs.
Before the first sampling, the output signals are equal to
their initial values defined via parameter <b>y0</b>.
</p>
</HTML>
"));
    Modelica.Blocks.Interfaces.InPort inPort(final n=n, redeclare type
        SignalType = SignalType)
      "Connector with an input signal of type SignalType" annotation (extent=[-
          140, -20; -100, 20]);
    Modelica.Blocks.Interfaces.OutPort outPort(
      final n=n,
      redeclare type SignalType = SignalType,
      signal(start=y0, fixed=fill(true, n)))
      "Connector with an output signal of type SignalType" annotation (extent=[
          100, -10; 120, 10]);
    Modelica.Blocks.Interfaces.BooleanInPort trigger(final n=1) annotation (
        extent=[-20, -138; 20, -98], rotation=90);
  equation
    when trigger.signal[1] then
      outPort.signal = inPort.signal;
    end when;
  end TriggeredSampler;

  block TriggeredMax
    "Compute maximum, absolute value of continuous signal at trigger instants"

    extends Interfaces.DiscreteBlockIcon;
    parameter Integer n=1 "number of input signals (= number output signals)";
    replaceable type SignalType = Real "type of input and output signal";
    annotation (
      Icon(
        Ellipse(extent=[-25, -10; -45, 10], style(color=3, fillColor=7)),
        Ellipse(extent=[45, -10; 25, 10], style(color=73, fillColor=7)),
        Line(points=[-100, 0; -45, 0], style(color=3)),
        Line(points=[45, 0; 100, 0], style(color=73)),
        Line(points=[0, -100; 0, -26], style(color=5)),
        Line(points=[-35, 0; 28, -48], style(color=3)),
        Text(
          extent=[-86, 82; 82, 24],
          string="max",
          style(color=0))),
      Diagram(
        Ellipse(extent=[-25, -10; -45, 10], style(color=3, fillColor=7)),
        Ellipse(extent=[45, -10; 25, 10], style(color=73, fillColor=7)),
        Line(points=[-100, 0; -45, 0], style(color=3)),
        Line(points=[45, 0; 100, 0], style(color=73)),
        Line(points=[-35, 0; 28, -48], style(color=3)),
        Line(points=[0, -100; 0, -26], style(color=5))),
      Documentation(info="<HTML>
<p>
Samples the continuous input signals whenever the trigger input
signal is rising (i.e., trigger.signal[1] changes from <b>false</b> to
<b>true</b>). The maximum, absolute values of the inputs signals
at the sampling point are provided as output signals.
</p>
</HTML>
"));
    Modelica.Blocks.Interfaces.InPort inPort(final n=n, redeclare type
        SignalType = SignalType)
      "Connector with an input signal of type SignalType" annotation (extent=[-
          140, -20; -100, 20]);
    Modelica.Blocks.Interfaces.OutPort outPort(
      final n=n,
      redeclare type SignalType = SignalType,
      signal(each start=0, each fixed=true))
      "Connector with an output signal of type SignalType" annotation (extent=[
          100, -10; 120, 10]);
    Modelica.Blocks.Interfaces.BooleanInPort trigger(final n=1) annotation (
        extent=[-20, -138; 20, -98], rotation=90);
  equation
    when trigger.signal[1] then
      for i in 1:n loop
        outPort.signal[i] = max(pre(outPort.signal[i]), abs(inPort.signal[i]));
      end for;
    end when;
  end TriggeredMax;
end Discrete;
