Engine_Output : CroneEngine {
  var <synth;

  *new { arg context, doneCallback;
    ^super.new(context, doneCallback);
  }

  alloc {
    synth = { |outbus|
      var exciterFunction, numberOfExciters, numberOfCombs, numberOfAllpass;
      var in, predelayed, out;
      numberOfExciters = 10;
      numberOfCombs = 7;
      numberOfAllpass = 4;
      exciterFunction = { Resonz.ar(Dust.ar(0.2, 50), 200 + rand(3000.0), 0.003) };
      in = Mix.arFill(numberOfExciters, exciterFunction);
      predelayed = DelayN.ar(in, 0.048);
      out = Mix.arFill(numberOfCombs, {
        CombL.ar(predelayed, 0.1, LFNoise1.kr(rand(0.1), 0.04, 0.05), 15);
      });
      numberOfAllpass.do({
        out = AllpassN.ar(out, 0.050, [rand(0.050), rand(0.050)], 1);
      });
      Out.ar(outbus, in + (0.2 * out));
    }.play(context.xg, args: [\outbus, context.out_b]);
  }

  free {
    synth.free;
  }
}
