package Examples "Examples for the 3D mechanical systems library"
extends Modelica.Icons.Library;

annotation (
  Coordsys(
    extent=[0, 0; 210, 323],
    grid=[1, 1],
    component=[20, 20]),
  Window(
    x=0.07,
    y=0.1,
    width=0.17,
    height=0.36,
    library=1,
    autolayout=1),
  Documentation(info="
<HTML>
<p>
This package contains example models to demonstrate the usage of the
ModelicaAdditions.MultiBody package. Open the models and
simulate them according to the provided description in the models.
</p>
</HTML>
"));
end Examples;
