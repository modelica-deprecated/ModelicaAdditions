package PetriNets
  "Library to model Petri nets and state transition diagrams"

  extends Modelica.Icons.Library;

  annotation (Documentation(info="<html>
<p>
The <b>PetriNets</b> library allows to model <b>discrete</b> components by
a special kind of <b>Petri nets</b> with at most one token on a place,
as well as by <b>state transition diagrams</b>
(which are special kinds of Petri nets). Petri nets
and state transition diagrams are \"higher level\" constructs for the description of
switching elements, parallel activities or syncronization. For several kinds
of applications it is much easier and clearer to use these components instead
of modeling the discrete behaviour directly with the basic language constructs
of Modelica (\"if\" or \"when\" statements). A typical Petri net is shown
in the following figure:
</p>

<IMG SRC=\"../Images/PetriNet1.gif\" ALT=\"Petri net\">

<p>
A <b>Petri net</b> is defined in the following way:
</p>

<ol>
<li>It consists of a set of <b>places</b> and of a set of <b>transitions</b>.
    The places are split into start places which are \"active\" at the start
    of the simulation and of \"normal\" places which are \"non-active\" at the
    beginning. </li>

<li>Places are connected by <b>transitions</b>, whereby no places and no
    transitions are directly connected (i.e., a place is connected to a
    transition which in turn is connected to another place).
    Any number of start places can be present. </li>

<li>An \"<b>active</b>\" place is characterized by a \"<b>token</b>\"
    placed on the place. In the ModelicaAdditions.PetriNets libray a place
    is \"active\" when the public variable \"<b>state</b>\" of the place
    is <b>true</b>.</li>

<li>There are <b>several transition</b> elements in the library. Whenever the
    <b>states</b> of <b>all inputs</b> to the transition elements are <b>active</b>
    and when the <b>condition</b> of the transition is <b>true</b> then the
    following actions are performed:
    <ul>
    <li>all <b>input states</b> are marked as \"<b>inactive</b>\", i.e.,
        the token is removed.</li>
    <li>all <b>output states</b> are marked as \"<b>active</b>\", i.e.,
        they are marked by new tokens.</li>
    </ul>
    The <b>conditionPort</b> connector of a transition element is used
    to signal via a Boolean signal whether the condition of a transition is
    true or false. Alternatively, the condition can be provided as an
    equation to set the public variable <b>condition</b> of the
    corresponding transition element.</li>

<li>There are several <b>place</b> components in this library
    (such as Place01, Place10, Place11) which have
    different number of input and output transition connectors.
    This is due to the current limitations of the annotations of
    Modelica, which do not allow to define the graphical location of
    the elements of a vector of (transition) connectors with unknown length.
    </li>

<li>If two or more transitions of a place would fire at the same time
    instant, <b>priorities</b> are used in order that exactly one of them fires.
    The highest priority has a transition connector of a place with the
    lowest index (e.g. outTransition1 has a higher priority as
    outTransition2).
</ol>

<p>
The method used in this library to realize Petri nets in Modelica
is described in detail in:
</p>

<dl>
<dt>Mosterman P.J., Otter M. and Elmqvist H. (1998):
<dd><b>Modeling Petri-Nets as Local Constraint Equations
    for Hybrid Systems using Modelica.</b>
    1998 Summer Computer Simulation Conference (SCSC'98),
    Reno, U.S.A., 19.-20. Juli (download from
    <a href=\"http://www.Modelica.org/papers/scsc98fp.pdf\">here</a>).
</dl>

<p>
This package is not part of the Modelica standard library, because it is
planned to realize a package with only <b>one</b> place and <b>one</b>
transition component, once vector connectors with unknown length have better
support in Modelica.
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
<li><i>June 12, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
<br>

<p><b>Copyright &copy; 2000-2002, DLR.</b></p>

<p><i>
The ModelicaAdditions.PetriNets package is <b>free</b> software;
it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"), Window(
      x=0.05,
      y=0.06,
      width=0.29,
      height=0.59,
      library=1,
      autolayout=1));
  package Interfaces
    extends Modelica.Icons.Library;

    connector FirePort
      Boolean state "State of connected place";
      Boolean fire "True, if transition fires";
    end FirePort;

    connector SetPort
      Boolean state "State of connected place";
      Boolean set "True, if transition fires";
    end SetPort;

    connector FirePortIn "FirePort with input icon"
      extends FirePort;
      annotation (Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100
                ], style(color=41, fillColor=41))), Diagram(Polygon(points=[-
                100, 100; 100, 0; -100, -100; -100, 100], style(color=41,
                fillColor=41)), Text(
            extent=[-100, -120; 100, -220],
            string="%name",
            style(color=0))));
    end FirePortIn;

    connector SetPortIn "SetPort with input icon"
      extends SetPort;
      annotation (Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100
                ], style(color=45, fillColor=41))), Diagram(Polygon(points=[-
                100, 100; 100, 0; -100, -100; -100, 100], style(color=41,
                fillColor=41)), Text(
            extent=[-100, -120; 100, -220],
            string="%name",
            style(color=0))));
    end SetPortIn;

    connector FirePortOut "FirePort with output icon"
      extends FirePort;
      annotation (Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100
                ], style(color=41, fillColor=7))), Diagram(Polygon(points=[-100
                , 100; 100, 0; -100, -100; -100, 100], style(color=41,
                fillColor=7)), Text(
            extent=[-100, -120; 100, -220],
            string="%name",
            style(color=0))));
    end FirePortOut;

    connector SetPortOut "SetPort with output icon"
      extends SetPort;
      annotation (Icon(Polygon(points=[-100, 100; 100, 0; -100, -100; -100, 100
                ], style(color=41, fillColor=7))), Diagram(Polygon(points=[-100
                , 100; 100, 0; -100, -100; -100, 100], style(color=41,
                fillColor=7)), Text(
            extent=[-100, -120; 100, -220],
            string="%name",
            style(color=0))));
    end SetPortOut;
  end Interfaces;

  package Examples
    extends Modelica.Icons.Library;

    encapsulated model Parallel
      "Example to demonstrate parallel activities described by a petri net  "
      import Modelica.Icons;
      import ModelicaAdditions.PetriNets;

      extends Icons.Example;
      output Boolean S1state;
      output Boolean P1state;
      output Boolean P2state;
      output Boolean P3state;
      output Boolean P4state;
      output Boolean P5state;
      output Boolean P6state;
      annotation (Documentation(info="<HTML>
<p>
This is an example to demonstrate in which way <b>parallel</b> activities
can be modelled by a Petri net. When transition \"Par1\" fires
(after 1 second), two branches are executed in parallel.
After 6 seconds the two branches are synchronized in order to arrive
at place \"P6\".
</p>

<p>
Before simulating the model, try to figure out whether branch
P2-P3-P5 or branch P2-P4-P5 is executed.
</p>

<p>Simulate for 7 seconds and plot the following variables:
</p>

<pre>
  S1state, P1state, P2state, ..., P6state
</pre>

</HTML>
"));
      PetriNets.Place01 S1(initialState=true) annotation (extent=[-60, 80; -40
            , 100], rotation=-90);
      PetriNets.Place11 P1 annotation (extent=[-60, -10; -40, 10], rotation=-90
        );
      PetriNets.Parallel Par1(condLabel="time>1") annotation (extent=[-60, 50;
            -40, 70], rotation=-90);
      PetriNets.Place12 P2 annotation (extent=[20, 50; 40, 70], rotation=-90);
      PetriNets.Transition T1(condLabel="time>2") annotation (extent=[-20, 20;
            0, 40], rotation=-90);
      PetriNets.Transition T2(condLabel="time>3") annotation (extent=[60, 20;
            80, 40], rotation=-90);
      PetriNets.Place11 P3 annotation (extent=[-20, -10; 0, 10], rotation=-90);
      PetriNets.Transition T3(condLabel="time>4") annotation (extent=[-20, -36
            ; 0, -16], rotation=-90);
      PetriNets.Place11 P4 annotation (extent=[60, -10; 80, 10], rotation=-90);
      PetriNets.Transition T4(condLabel="time>5") annotation (extent=[60, -36;
            80, -16], rotation=-90);
      PetriNets.Place21 P5 annotation (extent=[20, -70; 40, -50], rotation=-90)
        ;
      PetriNets.Synchronize Sync1(condLabel="time>6") annotation (extent=[-60,
            -76; -40, -56], rotation=-90);
      PetriNets.Place10 P6 annotation (extent=[-60, -100; -40, -80], rotation=
            270);
    equation
      connect(Par1.outTransition1, P1.inTransition) annotation (points=[-50, 55
            ; -50, 12], style(color=41));
      connect(T1.outTransition, P3.inTransition) annotation (points=[-10, 25; -
            10, 12], style(color=41));
      connect(P3.outTransition, T3.inTransition) annotation (points=[-10, -11;
            -10.05, -19.95], style(color=41));
      connect(P1.outTransition, Sync1.inTransition1) annotation (points=[-50, -
            11; -50, -60], style(color=41));
      connect(Sync1.outTransition, P6.inTransition) annotation (points=[-50, -
            71; -50, -78], style(color=41));
      connect(T2.outTransition, P4.inTransition) annotation (points=[70, 25; 70
            , 12], style(color=41));
      connect(P4.outTransition, T4.inTransition) annotation (points=[70, -11;
            69.95, -19.95], style(color=41));
      connect(S1.outTransition, Par1.inTransition) annotation (points=[-50.2,
            79; -50.05, 66.05], style(color=41));
      connect(T3.outTransition, P5.inTransition1) annotation (points=[-10, -31
            ; -10, -37; 24, -37; 24, -48], style(color=41));
      connect(T4.outTransition, P5.inTransition2) annotation (points=[70, -31;
            70, -37; 36, -37; 36, -48], style(color=41));
      connect(P2.outTransition2, T2.inTransition) annotation (points=[36, 48.9
            ; 36, 45; 69.95, 45; 69.95, 36.05], style(color=41));
      connect(Par1.outTransition2, P2.inTransition) annotation (points=[-44, 55
            ; -44, 50; -25, 50; -25, 90; 30, 90; 30, 72], style(color=41));
      connect(P5.outTransition, Sync1.inTransition2) annotation (points=[30, -
            71; 30, -90; 0, -90; 0, -51; -44, -51; -44, -60], style(color=41));
      connect(P2.outTransition1, T1.inTransition) annotation (points=[24, 49;
            24, 44; -10.05, 44; -10.05, 36.05], style(color=41));
      Par1.condition = time > 1;
      T1.condition = time > 2;
      T2.condition = time > 3;
      T3.condition = time > 4;
      T4.condition = time > 5;
      Sync1.condition = time > 6;

      /*output variables*/
      S1state = S1.state;
      P1state = P1.state;
      P2state = P2.state;
      P3state = P3.state;
      P4state = P4.state;
      P5state = P5.state;
      P6state = P6.state;
    end Parallel;
  end Examples;

  model Place01 "Place with one output transition"
    parameter Boolean initialState=false "Initial value of state";
    Boolean state(final start=initialState) "State of place";
  protected
    Boolean newState(final start=initialState);
  public
    Interfaces.FirePortOut outTransition annotation (extent=[100, -12; 120, 8])
      ;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.25,
        y=0,
        width=0.49,
        height=0.65),
      Icon(Ellipse(extent=[-100, -100; 100, 100], style(color=41, fillColor=7))
          , Text(extent=[0, 99; 0, 159], string="%name")),
      Diagram(Ellipse(extent=[-100, -100; 100, 100], style(color=41, fillColor=
                7))));
  equation
    // Set new state for next iteration
    state = pre(newState);
    newState = state and not outTransition.fire;

    // Report state to output transition
    outTransition.state = state;
  end Place01;

  model Place10 "Place with one input transition"
    parameter Boolean initialState=false "Initial value of state";
    Boolean state(final start=initialState) "State of place";
  protected
    Boolean newState(final start=initialState);
  public
    Interfaces.SetPortIn inTransition annotation (extent=[-140, -20; -100, 20])
      ;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.16,
        y=0.03,
        width=0.49,
        height=0.61),
      Icon(Ellipse(extent=[-100, -100; 100, 100], style(color=41, fillColor=7))
          , Text(extent=[0, 99; 0, 159], string="%name")),
      Diagram(Ellipse(extent=[-100, -100; 100, 100], style(color=41))));
  equation
    // Set new state for next iteration
    state = pre(newState);
    newState = inTransition.set or state;

    // Report state to input transition
    inTransition.state = state;
  end Place10;

  model Place11 "Place with one input and one output transition"
    parameter Boolean initialState=false "Initial value of state";
    Boolean state(final start=initialState) "State of place";
  protected
    Boolean newState(final start=initialState);
  public
    Interfaces.SetPortIn inTransition annotation (extent=[-140, -20; -100, 20])
      ;
    Interfaces.FirePortOut outTransition annotation (extent=[100, -10; 120, 10]
      );
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.16,
        y=0.05,
        width=0.5,
        height=0.7),
      Icon(Ellipse(extent=[-100, -100; 100, 100], style(color=41, fillColor=7))
          , Text(extent=[0, 99; 0, 159], string="%name")),
      Diagram(Ellipse(extent=[-100, -100; 100, 100], style(color=41))));
  equation
    // Set new state for next iteration
    state = pre(newState);
    newState = inTransition.set or state and not outTransition.fire;

    // Report state to input and output transitions
    inTransition.state = state;
    outTransition.state = state;
  end Place11;

  model Place21 "Place with two input and one output transition"
    parameter Boolean initialState=false "Initial value of state";
    Boolean state(final start=initialState) "State of place";
  protected
    Boolean newState(final start=initialState);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.11,
        y=0,
        width=0.49,
        height=0.71),
      Icon(
        Ellipse(extent=[-100, -100; 100, 100], style(color=41, fillColor=7)),
        Line(points=[-100, 60; -80, 60], style(color=41)),
        Line(points=[-100, -60; -80, -60], style(color=41)),
        Text(extent=[0, 99; 0, 159], string="%name")),
      Diagram(
        Ellipse(extent=[-100, -100; 100, 100], style(color=41)),
        Line(points=[-100, 60; -80, 60], style(color=41)),
        Line(points=[-100, -60; -80, -60], style(color=41))));
  public
    Interfaces.FirePortOut outTransition annotation (extent=[100, -10; 120, 10]
      );
    Interfaces.SetPortIn inTransition1 annotation (extent=[-140, -80; -100, -40
          ]);
    Interfaces.SetPortIn inTransition2 annotation (extent=[-140, 80; -100, 40])
      ;
  equation
    // Set new state for next iteration
    state = pre(newState);
    newState = inTransition1.set or inTransition2.set or state and not
      outTransition.fire;

    // Report state to input and output transitions
    inTransition1.state = state;
    inTransition2.state = inTransition1.state or inTransition1.set;
    outTransition.state = state;
  end Place21;

  model Place12 "Place with one input and two output transitions"
    parameter Boolean initialState=false "Initial value of state";
    Boolean state(final start=initialState) "State of place";
  protected
    Boolean newState(final start=initialState);
  public
    Interfaces.SetPortIn inTransition annotation (extent=[-140, -20; -100, 20])
      ;
    Interfaces.FirePortOut outTransition1 annotation (extent=[100, -70; 120, -
          50]);
    Interfaces.FirePortOut outTransition2 annotation (extent=[100, 70; 122, 50]
      );
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.16,
        y=0.03,
        width=0.44,
        height=0.64),
      Icon(
        Ellipse(extent=[-100, -100; 100, 100], style(color=41, fillColor=7)),
        Line(points=[100, 60; 80, 60], style(color=41)),
        Line(points=[102, -60; 82, -60], style(color=41)),
        Text(extent=[0, 99; 0, 159], string="%name")),
      Diagram(
        Ellipse(extent=[-100, -100; 100, 100], style(color=41)),
        Line(points=[100, 60; 80, 60], style(color=41)),
        Line(points=[100, -60; 80, -60], style(color=41))));
  equation
    // Set new state for next iteration
    state = pre(newState);
    newState = inTransition.set or state and not (outTransition1.fire or
      outTransition2.fire);

    // Report state to input and output transitions
    inTransition.state = state;
    outTransition1.state = state;
    outTransition2.state = outTransition1.state and not outTransition1.fire;
  end Place12;

  model Place22 "Place with two input and two output transitions"
    parameter Boolean initialState=false "Initial value of state";
    Boolean state(final start=initialState) "State of place";
  protected
    Boolean newState(final start=initialState);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.21,
        y=0.03,
        width=0.52,
        height=0.7),
      Icon(
        Ellipse(extent=[-100, -100; 100, 100], style(color=41, fillColor=7)),
        Line(points=[-100, 60; -80, 60], style(color=41)),
        Line(points=[-100, -60; -80, -60], style(color=41)),
        Line(points=[80, -60; 100, -60], style(color=41)),
        Line(points=[82, 60; 102, 60], style(color=41)),
        Text(extent=[0, 99; 0, 159], string="%name")),
      Diagram(
        Ellipse(extent=[-100, -100; 100, 100], style(color=41)),
        Line(points=[-100, 60; -80, 60], style(color=41)),
        Line(points=[-100, -60; -80, -60], style(color=41)),
        Line(points=[80, 60; 100, 60], style(color=41)),
        Line(points=[80, -60; 100, -60], style(color=41))));
  public
    Interfaces.FirePortOut outTransition1 annotation (extent=[100, -70; 120, -
          50]);
    Interfaces.FirePortOut outTransition2 annotation (extent=[100, 70; 120, 50]
      );
    Interfaces.SetPortIn inTransition1 annotation (extent=[-140, -80; -100, -40
          ]);
    Interfaces.SetPortIn inTransition2 annotation (extent=[-140, 80; -100, 40])
      ;
  equation
    // Set new state for next iteration
    state = pre(newState);
    newState = inTransition1.set or inTransition2.set or state and not (
      outTransition1.fire or outTransition2.fire);

    // Report state to input and output transitions
    inTransition1.state = state;
    inTransition2.state = inTransition1.state or inTransition1.set;
    outTransition1.state = state;
    outTransition2.state = outTransition1.state and not outTransition1.fire;
  end Place22;

  model Transition "Transition with one input and one output connection"
    parameter String condLabel=" " "Condition as string (e.g. \"x > 0\")";
    Boolean condition;
    Boolean fire;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.26,
        y=0.01,
        width=0.42,
        height=0.78),
      Icon(
        Rectangle(extent=[-5, 80; 5, -80], style(
            color=41,
            fillColor=41,
            fillPattern=1)),
        Line(points=[-40, 0; -5, 0], style(color=41)),
        Line(points=[40, 0; 5, 0], style(color=41)),
        Text(
          extent=[0, -120; 0, -170],
          string="%condLabel",
          style(color=0)),
        Text(extent=[0, 90; 0, 150], string="%name")),
      Diagram(
        Rectangle(extent=[-5, 80; 5, -80], style(
            color=41,
            fillColor=41,
            fillPattern=1)),
        Line(points=[-38, 0; -5, 0], style(color=41)),
        Line(points=[40, 0; 5, 0], style(color=41)),
        Text(extent=[-112, -120; 128, -100], string="%condLabel")));
    Interfaces.FirePortIn inTransition annotation (extent=[-81, -21; -40, 20]);
    Interfaces.SetPortOut outTransition annotation (extent=[40, -10; 60, 10]);
    Modelica.Blocks.Interfaces.BooleanInPort conditionPort(final n=1) annotation (extent=[-20, -120; 20, -
          80], rotation=90);
  equation
    condition = conditionPort.signal[1];
    fire = condition and inTransition.state and not outTransition.state;
    inTransition.fire = fire;
    outTransition.set = fire;
  end Transition;

  model Parallel "Transition with one input and two output connections"
    parameter String condLabel=" " "Condition as string (e.g. \"x > 0\")";
    Boolean fire;
    Boolean condition;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.1,
        y=0.02,
        width=0.61,
        height=0.73),
      Icon(
        Rectangle(extent=[-5, 80; 5, -80], style(
            color=41,
            fillColor=41,
            fillPattern=1)),
        Line(points=[-40, 0; -5, 0], style(color=41)),
        Line(points=[40, 60; 5, 60], style(color=41)),
        Text(extent=[0, 89; 0, 149], string="%name"),
        Text(
          extent=[0, -120; 0, -170],
          string="%condLabel",
          style(color=0)),
        Line(points=[40, 0; 5, 0], style(color=41))),
      Diagram(
        Rectangle(extent=[-5, 80; 5, -80], style(
            color=41,
            fillColor=41,
            fillPattern=1)),
        Line(points=[-38, 0; -5, 0], style(color=41)),
        Line(points=[40, 0; 5, 0], style(color=41)),
        Text(extent=[-112, -120; 128, -100], string="%condLabel"),
        Line(points=[40, 60; 5, 60], style(color=41))));
    Interfaces.FirePortIn inTransition annotation (extent=[-81, -21; -40, 20]);
    Interfaces.SetPortOut outTransition1 annotation (extent=[40, -10; 60, 10]);
    Interfaces.SetPortOut outTransition2 annotation (extent=[40, 50; 60, 70]);
    Modelica.Blocks.Interfaces.BooleanInPort conditionPort(final n=1) annotation (extent=[-20, -120; 20, -
          80], rotation=90);
  equation
    condition = conditionPort.signal[1];
    fire = condition and inTransition.state and not (outTransition1.state or
      outTransition2.state);
    inTransition.fire = fire;
    outTransition1.set = fire;
    outTransition2.set = fire;
  end Parallel;

  model Synchronize "Transition with two input and one output connections"
    parameter String condLabel=" " "Condition as string (e.g. \"x > 0\")";
    Boolean condition;
    Boolean fire;
    annotation (Icon(
        Rectangle(extent=[-5, 80; 5, -80], style(
            color=41,
            fillColor=41,
            fillPattern=1)),
        Line(points=[-40, 0; -5, 0], style(color=41)),
        Line(points=[40, 0; 5, 0], style(color=41)),
        Text(
          extent=[0, -120; 0, -170],
          string="%condLabel",
          style(color=0)),
        Line(points=[-40, 60; -5, 60], style(color=41)),
        Text(extent=[0, 89; 0, 149], string="%name")), Diagram(
        Rectangle(extent=[-5, 80; 5, -80], style(
            color=41,
            fillColor=41,
            fillPattern=1)),
        Line(points=[-38, 0; -1, 0], style(color=41)),
        Line(points=[40, 0; 5, 0], style(color=41)),
        Text(extent=[-112, -120; 128, -100], string="%condLabel"),
        Line(points=[-40, 60; -3, 60], style(color=41))));
    Interfaces.FirePortIn inTransition1 annotation (extent=[-80, -20; -40, 20])
      ;
    Interfaces.FirePortIn inTransition2 annotation (extent=[-80, 80; -40, 40]);
    Interfaces.SetPortOut outTransition annotation (extent=[40, -10; 60, 10]);
    Modelica.Blocks.Interfaces.BooleanInPort conditionPort(final n=1) annotation (extent=[-20, -120; 20, -
          80], rotation=90);
  equation
    condition = conditionPort.signal[1];
    fire = condition and inTransition1.state and inTransition2.state and not
      outTransition.state;
    inTransition1.fire = fire;
    inTransition2.fire = fire;
    outTransition.set = fire;
  end Synchronize;
end PetriNets;
