package Nonlinear
  extends Modelica.Icons.Library;

  annotation (Documentation(info="<html>
<p>
This package contains delay components.
</p>

<p>
This package is not part of the Modelica standard library.
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
<li><i>February 13, 2001</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
</ul>
<br>


<p><b>Copyright &copy; 2001-2002, DLR.</b></p>

<p><i>
The ModelicaAdditions.Blocks.Nonlinear package is <b>free</b> software;
it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  block FixedDelay "Delay block with fixed DelayTime"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter SI.Time delayTime=1
      "Delay time of output with respect to input signal";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.27,
        y=0.09,
        width=0.65,
        height=0.78),
      Documentation(info="
The Input signal is delayed by a given time instant, or more precisely:

   y = u(time - delayTime) for time  > time.start + delayTime
     = u(time.start)       for time <= time.start + delayTime
"),
      Icon(
        Text(
          extent=[8, -102; 8, -142],
          string="delayTime=%delayTime",
          style(color=0)),
        Line(points=[-92, 0; -80.7, 34.2; -73.5, 53.1; -67.1, 66.4; -61.4, 74.6
              ; -55.8, 79.1; -50.2, 79.8; -44.6, 76.6; -38.9, 69.7; -33.3, 59.4
              ; -26.9, 44.1; -18.83, 21.2; -1.9, -30.8; 5.3, -50.2; 11.7, -64.2
              ; 17.3, -73.1; 23, -78.4; 28.6, -80; 34.2, -77.6; 39.9, -71.5;
              45.5, -61.9; 51.9, -47.2; 60, -24.8; 68, 0], style(color=73)),
        Line(points=[-62, 0; -50.7, 34.2; -43.5, 53.1; -37.1, 66.4; -31.4, 74.6
              ; -25.8, 79.1; -20.2, 79.8; -14.6, 76.6; -8.9, 69.7; -3.3, 59.4;
              3.1, 44.1; 11.17, 21.2; 28.1, -30.8; 35.3, -50.2; 41.7, -64.2;
              47.3, -73.1; 53, -78.4; 58.6, -80; 64.2, -77.6; 69.9, -71.5; 75.5
              , -61.9; 81.9, -47.2; 90, -24.8; 98, 0], style(color=9))),
      Diagram(
        Line(points=[-80, 80; -88, 80], style(color=8)),
        Line(points=[-80, -80; -88, -80], style(color=8)),
        Line(points=[-80, -88; -80, 86], style(color=8)),
        Text(
          extent=[-75, 98; -46, 78],
          string="outPort",
          style(color=73)),
        Polygon(points=[-80, 96; -86, 80; -74, 80; -80, 96], style(color=8,
              fillColor=8)),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Line(points=[-80, 0; -68.7, 34.2; -61.5, 53.1; -55.1, 66.4; -49.4, 74.6
              ; -43.8, 79.1; -38.2, 79.8; -32.6, 76.6; -26.9, 69.7; -21.3, 59.4
              ; -14.9, 44.1; -6.83, 21.2; 10.1, -30.8; 17.3, -50.2; 23.7, -64.2
              ; 29.3, -73.1; 35, -78.4; 40.6, -80; 46.2, -77.6; 51.9, -71.5;
              57.5, -61.9; 63.9, -47.2; 72, -24.8; 80, 0], style(color=73)),
        Text(
          extent=[-24, 98; -2, 78],
          string="inPort",
          style(color=0)),
        Line(points=[-64, 0; -52.7, 34.2; -45.5, 53.1; -39.1, 66.4; -33.4, 74.6
              ; -27.8, 79.1; -22.2, 79.8; -16.6, 76.6; -10.9, 69.7; -5.3, 59.4
              ; 1.1, 44.1; 9.17, 21.2; 26.1, -30.8; 33.3, -50.2; 39.7, -64.2;
              45.3, -73.1; 51, -78.4; 56.6, -80; 62.2, -77.6; 67.9, -71.5; 73.5
              , -61.9; 79.9, -47.2; 88, -24.8; 96, 0], style(color=0)),
        Text(
          extent=[67, 22; 96, 6],
          string="time",
          style(color=9)),
        Line(points=[-64, -30; -64, 0], style(color=8)),
        Text(extent=[-58, -42; -58, -32], string="delayTime"),
        Line(points=[-94, -26; -80, -26], style(color=8)),
        Line(points=[-64, -26; -50, -26], style(color=8)),
        Polygon(points=[-80, -26; -88, -24; -88, -28; -80, -26], style(color=8
              , fillColor=8)),
        Polygon(points=[-56, -24; -64, -26; -56, -28; -56, -24], style(color=8
              , fillColor=8))));
  equation
    y = delay(u, delayTime);
  end FixedDelay;

  block PadeDelay "Pade approximation of delay block with fixed DelayTime "
    extends Modelica.Blocks.Interfaces.SISO;
    parameter SI.Time delayTime=1
      "Delay time of output with respect to input signal";
    parameter Integer n(min=1) = 1 "Order of pade approximation";
    parameter Integer m(
      min=1,
      max=n) = n "Order of numerator";

  protected
    Real x1dot "Derivative of first state of TransferFcn";
    Real xn "Highest order state of TransferFcn";
    Real a[n + 1];
    Real b[m + 1];

  public
    final output Real x[n]
      "State of transfer function from controller canonical form";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.27,
        y=0.09,
        width=0.65,
        height=0.78),
      Documentation(info="
The Input signal is delayed by a given time instant, or more precisely:

   y = u(time - delayTime) for time  > time.start + delayTime
     = u(time.start)       for time <= time.start + delayTime

The delay is approximated by a Pade approximation, i.e., by
a transfer function

           b[1]*s^m + b[2]*s^[m-1] + ... + b[m+1]
   y(s) = --------------------------------------------- * u(s)
           a[1]*s^n + a[2]*s^[n-1] + ... + a[n+1]

where the coefficients b[:] and a[:] are calculated such that the
coefficients of the Taylor expansion of the delay exp(-T*s) around s=0
are identical upto order n+m.

The main advantage of this approach is that the delay is
approximated by a linear differential equation system, which
is continuous and continuously differentiable. For example, it
is uncritical to linearize a system containing a Pade-approximated
delay.

The standard text book version uses order \"m=n\", which is
also the default setting of this block. The setting
\"m=n-1\" may yield a better approximation in certain cases.

Literature:
   Otto Foellinger: Regelungstechnik, 8. Auflage,
   chapter 11.9, page 412-414, Huethig Verlag Heidelberg, 1994
"),
      Icon(
        Text(
          extent=[8, -102; 8, -142],
          string="delayTime=%delayTime",
          style(color=0)),
        Line(points=[-94, 0; -82.7, 34.2; -75.5, 53.1; -69.1, 66.4; -63.4, 74.6
              ; -57.8, 79.1; -52.2, 79.8; -46.6, 76.6; -40.9, 69.7; -35.3, 59.4
              ; -28.9, 44.1; -20.83, 21.2; -3.9, -30.8; 3.3, -50.2; 9.7, -64.2
              ; 15.3, -73.1; 21, -78.4; 26.6, -80; 32.2, -77.6; 37.9, -71.5;
              43.5, -61.9; 49.9, -47.2; 58, -24.8; 66, 0], style(color=73)),
        Line(points=[-72, 0; -60.7, 34.2; -53.5, 53.1; -47.1, 66.4; -41.4, 74.6
              ; -35.8, 79.1; -30.2, 79.8; -24.6, 76.6; -18.9, 69.7; -13.3, 59.4
              ; -6.9, 44.1; 1.17, 21.2; 18.1, -30.8; 25.3, -50.2; 31.7, -64.2;
              37.3, -73.1; 43, -78.4; 48.6, -80; 54.2, -77.6; 59.9, -71.5; 65.5
              , -61.9; 71.9, -47.2; 80, -24.8; 88, 0], style(color=9)),
        Text(
          extent=[-10, 100; 100, 38],
          string="m=%m",
          style(color=9)),
        Text(
          extent=[-98, -34; 6, -96],
          string="n=%n",
          style(color=9))),
      Diagram(
        Line(points=[-80, 80; -88, 80], style(color=8)),
        Line(points=[-80, -80; -88, -80], style(color=8)),
        Line(points=[-80, -88; -80, 86], style(color=8)),
        Text(
          extent=[-75, 98; -46, 78],
          string="outPort",
          style(color=73)),
        Polygon(points=[-80, 96; -86, 80; -74, 80; -80, 96], style(color=8,
              fillColor=8)),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Line(points=[-80, 0; -68.7, 34.2; -61.5, 53.1; -55.1, 66.4; -49.4, 74.6
              ; -43.8, 79.1; -38.2, 79.8; -32.6, 76.6; -26.9, 69.7; -21.3, 59.4
              ; -14.9, 44.1; -6.83, 21.2; 10.1, -30.8; 17.3, -50.2; 23.7, -64.2
              ; 29.3, -73.1; 35, -78.4; 40.6, -80; 46.2, -77.6; 51.9, -71.5;
              57.5, -61.9; 63.9, -47.2; 72, -24.8; 80, 0], style(color=73)),
        Text(
          extent=[-24, 98; -2, 78],
          string="inPort",
          style(color=0)),
        Line(points=[-64, 0; -52.7, 34.2; -45.5, 53.1; -39.1, 66.4; -33.4, 74.6
              ; -27.8, 79.1; -22.2, 79.8; -16.6, 76.6; -10.9, 69.7; -5.3, 59.4
              ; 1.1, 44.1; 9.17, 21.2; 26.1, -30.8; 33.3, -50.2; 39.7, -64.2;
              45.3, -73.1; 51, -78.4; 56.6, -80; 62.2, -77.6; 67.9, -71.5; 73.5
              , -61.9; 79.9, -47.2; 88, -24.8; 96, 0], style(color=0)),
        Text(
          extent=[67, 22; 96, 6],
          string="time",
          style(color=9)),
        Line(points=[-64, -30; -64, 0], style(color=8)),
        Text(extent=[-58, -42; -58, -32], string="delayTime"),
        Line(points=[-94, -26; -80, -26], style(color=8)),
        Line(points=[-64, -26; -50, -26], style(color=8)),
        Polygon(points=[-80, -26; -88, -24; -88, -28; -80, -26], style(color=8
              , fillColor=8)),
        Polygon(points=[-56, -24; -64, -26; -56, -28; -56, -24], style(color=8
              , fillColor=8))));
  protected
    function padeCoefficients
      input Real T "delay time";
      input Integer n "order of denominator";
      input Integer m "order of numerator";
      output Real b[m + 1] "numerator coefficients of transfer function";
      output Real a[n + 1] "denominator coefficients of transfer function";
    protected
      Real nm;
    algorithm
      a[1] := 1;
      b[1] := 1;
      nm := n + m;

      for i in 1:n loop
        a[i + 1] := a[i]*(T*((n - i + 1)/(nm - i + 1))/i);
        if i <= m then
          b[i + 1] := -b[i]*(T*((m - i + 1)/(nm - i + 1))/i);
        end if;
      end for;

      b := b[m + 1:-1:1];
      a := a[n + 1:-1:1];
    end padeCoefficients;
  equation

    (b,a) = padeCoefficients(delayTime, n, m);

    [der(x); xn] = [x1dot; x];
    [u] = transpose([a])*[x1dot; x];
    [y] = transpose([zeros(n - m, 1); b])*[x1dot; x];

  initial equation
    x[n] = inPort.signal[1];
  end PadeDelay;

  block VarDelay "Delay block with variable DelayTime"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter Real delayMax(min=0) = 1 "maximum delay time";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.26,
        y=0.04,
        width=0.62,
        height=0.78),
      Documentation(info="
The Input signal is delayed by a given time instant, or more precisely:

   y = u(time - delayTime) for time  > time.start + delayTime
     = u(time.start)       for time <= time.start + delayTime

where delayTime is an additional input signal which must follow
the following relationship:

  0 <= delayTime <= delayMax.
"),
      Icon(
        Text(
          extent=[-100, -108; 100, -148],
          string="delayMax=%delayMax",
          style(color=0)),
        Line(points=[-92, 0; -80.7, 34.2; -73.5, 53.1; -67.1, 66.4; -61.4, 74.6
              ; -55.8, 79.1; -50.2, 79.8; -44.6, 76.6; -38.9, 69.7; -33.3, 59.4
              ; -26.9, 44.1; -18.83, 21.2; -1.9, -30.8; 5.3, -50.2; 11.7, -64.2
              ; 17.3, -73.1; 23, -78.4; 28.6, -80; 34.2, -77.6; 39.9, -71.5;
              45.5, -61.9; 51.9, -47.2; 60, -24.8; 68, 0], style(color=73)),
        Line(points=[-64, 0; -52.7, 34.2; -45.5, 53.1; -39.1, 66.4; -33.4, 74.6
              ; -27.8, 79.1; -22.2, 79.8; -16.6, 76.6; -10.9, 69.7; -5.3, 59.4
              ; 1.1, 44.1; 9.17, 21.2; 26.1, -30.8; 33.3, -50.2; 39.7, -64.2;
              45.3, -73.1; 51, -78.4; 56.6, -80; 62.2, -77.6; 67.9, -71.5; 73.5
              , -61.9; 79.9, -47.2; 88, -24.8; 96, 0], style(color=0)),
        Polygon(points=[6, 4; -14, -2; -6, -12; 6, 4], style(color=0, fillColor
              =0)),
        Line(points=[-100, -60; -76, -60; -8, -6], style(color=0))),
      Diagram(
        Rectangle(extent=[-100, -100; 100, 100], style(color=3, fillColor=7)),
        Polygon(points=[-80, 96; -86, 80; -74, 80; -80, 96], style(color=8,
              fillColor=8)),
        Text(
          extent=[-69, 98; -40, 78],
          string="outPort",
          style(color=73)),
        Line(points=[-64, 0; -52.7, 34.2; -45.5, 53.1; -39.1, 66.4; -33.4, 74.6
              ; -27.8, 79.1; -22.2, 79.8; -16.6, 76.6; -10.9, 69.7; -5.3, 59.4
              ; 1.1, 44.1; 9.17, 21.2; 26.1, -30.8; 33.3, -50.2; 39.7, -64.2;
              45.3, -73.1; 51, -78.4; 56.6, -80; 62.2, -77.6; 67.9, -71.5; 73.5
              , -61.9; 79.9, -47.2; 88, -24.8; 96, 0], style(color=0)),
        Line(points=[-80, 0; -68.7, 34.2; -61.5, 53.1; -55.1, 66.4; -49.4, 74.6
              ; -43.8, 79.1; -38.2, 79.8; -32.6, 76.6; -26.9, 69.7; -21.3, 59.4
              ; -14.9, 44.1; -6.83, 21.2; 10.1, -30.8; 17.3, -50.2; 23.7, -64.2
              ; 29.3, -73.1; 35, -78.4; 40.6, -80; 46.2, -77.6; 51.9, -71.5;
              57.5, -61.9; 63.9, -47.2; 72, -24.8; 80, 0], style(color=73)),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Text(
          extent=[67, 22; 96, 6],
          string="time",
          style(color=9)),
        Text(extent=[-58, -42; -58, -32], string="delayTime"),
        Line(points=[-80, -88; -80, 86], style(color=8)),
        Text(
          extent=[-24, 98; -2, 78],
          string="inPort",
          style(color=0)),
        Text(
          extent=[-24, 98; -2, 78],
          string="inPort",
          style(color=0)),
        Polygon(points=[-80, -26; -88, -24; -88, -28; -80, -26], style(color=8
              , fillColor=8)),
        Polygon(points=[-56, -24; -64, -26; -56, -28; -56, -24], style(color=8
              , fillColor=8)),
        Line(points=[-64, -26; -50, -26], style(color=8)),
        Line(points=[-94, -26; -80, -26], style(color=8)),
        Text(extent=[-58, -42; -58, -32], string="delayTime"),
        Line(points=[-100, -60; -70, -60; -64, -44], style(arrow=1)),
        Line(points=[-80, -88; -80, 86], style(color=8)),
        Line(points=[-100, 0; 84, 0], style(color=8)),
        Line(points=[-64, 0; -52.7, 34.2; -45.5, 53.1; -39.1, 66.4; -33.4, 74.6
              ; -27.8, 79.1; -22.2, 79.8; -16.6, 76.6; -10.9, 69.7; -5.3, 59.4
              ; 1.1, 44.1; 9.17, 21.2; 26.1, -30.8; 33.3, -50.2; 39.7, -64.2;
              45.3, -73.1; 51, -78.4; 56.6, -80; 62.2, -77.6; 67.9, -71.5; 73.5
              , -61.9; 79.9, -47.2; 88, -24.8; 96, 0], style(color=0)),
        Polygon(points=[-80, 96; -86, 80; -74, 80; -80, 96], style(color=8,
              fillColor=8)),
        Line(points=[-80, 0; -68.7, 34.2; -61.5, 53.1; -55.1, 66.4; -49.4, 74.6
              ; -43.8, 79.1; -38.2, 79.8; -32.6, 76.6; -26.9, 69.7; -21.3, 59.4
              ; -14.9, 44.1; -6.83, 21.2; 10.1, -30.8; 17.3, -50.2; 23.7, -64.2
              ; 29.3, -73.1; 35, -78.4; 40.6, -80; 46.2, -77.6; 51.9, -71.5;
              57.5, -61.9; 63.9, -47.2; 72, -24.8; 80, 0], style(color=73)),
        Text(
          extent=[-69, 98; -40, 78],
          string="outPort",
          style(color=73)),
        Text(
          extent=[-24, 98; -2, 78],
          string="inPort",
          style(color=0)),
        Text(
          extent=[67, 22; 96, 6],
          string="time",
          style(color=9)),
        Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8,
              fillColor=8)),
        Line(points=[-64, -30; -64, 0], style(color=8))));
    Modelica.Blocks.Interfaces.InPort delayTime(final n=1) annotation (extent=[
          -140, -80; -100, -40]);
  equation
    y = delay(u, delayTime.signal[1], delayMax);
  end VarDelay;
end Nonlinear;
