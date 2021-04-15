within NHES.Electrolysis.ElectricHeaters.Examples.CathodeGasCarried;
model ElectricHeaterModuleLoadVessel_test

  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T wCathodeFeed(
    use_m_flow_in=true,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    X=Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM
        *1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM*1000}),
    nPorts=1,
    m_flow=4.540415,
    T=899.734)
    annotation (Placement(transformation(extent={{-56,-10},{-36,10}})));
  Modelica.Fluid.Sources.Boundary_pT wCathodeTubeSink(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    nPorts=1,
    p=1964000,
    T=1123.15)
    annotation (Placement(transformation(extent={{78,-10},{58,10}})));
  Modelica.Blocks.Sources.Ramp wCathodeTubeSignal(
    duration=10,
    height=-2.7236,
    startTime=500,
    offset=4.540415)
                    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-84,8})));
  Electrolysis.ElectricHeaters.ToppingHeater_cathodeGasVessel_elecPort
    toppingHeater_cathodeGas(
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    isCircular=true,
    initType=Modelica.Blocks.Types.Init.InitialState,
    TC_set=1123.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Electrolysis.Sensors.TempSensorWithThermowell TCtopping_out(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    y_start=850 + 273.15,
    tau=13) annotation (Placement(transformation(extent={{16,12},{36,32}})));

  Electrolysis.Sensors.TempSensorWithThermowell TCtopping_in(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    tau=13,
    redeclare package Medium =
        Electrolysis.Media.Electrolysis.CathodeGas,
    y_start=626.584 + 273.15)
    annotation (Placement(transformation(extent={{-32,12},{-12,32}})));

  Electrolysis.Sources.LoadSink elec_sink annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-30})));
equation
  connect(wCathodeTubeSignal.y,wCathodeFeed. m_flow_in)
    annotation (Line(points={{-73,8},{-56,8}},     color={0,0,127}));
  connect(wCathodeFeed.ports[1], toppingHeater_cathodeGas.port_a)
    annotation (Line(points={{-36,0},{-36,0},{-10,0}}, color={0,127,255}));
  connect(toppingHeater_cathodeGas.port_b, wCathodeTubeSink.ports[1])
    annotation (Line(points={{10,0},{58,0}}, color={0,127,255}));
  connect(toppingHeater_cathodeGas.port_b, TCtopping_out.port)
    annotation (Line(points={{10,0},{26,0},{26,12}}, color={0,127,255}));
  connect(TCtopping_out.y, toppingHeater_cathodeGas.s_TC_in)
    annotation (Line(points={{26,31},{26,38},{0,38},{0,11}}, color={0,0,
          127}));
  connect(TCtopping_in.port, toppingHeater_cathodeGas.port_a)
    annotation (Line(points={{-22,12},{-22,0},{-10,0}}, color={0,127,
          255}));
  connect(elec_sink.port_a, toppingHeater_cathodeGas.loadElecHeater)
    annotation (Line(points={{0,-20},{0,-15},{0,-10}}, color={255,0,0}));
  annotation (Documentation(info="<HTML>
<P>

</P>
</html>"),    experiment(StopTime=1200, Interval=1),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    __Dymola_experimentSetupOutput);
end ElectricHeaterModuleLoadVessel_test;