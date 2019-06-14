Engine_InputTutorial : CroneEngine {
  var amp=0;
  var <synth;

  *new { arg context, doneCallback;
    ^super.new(context, doneCallback);
  }

  alloc {
    SynthDef(\passThru, {|inL, inR, out, amp=0 |
      var sound = [In.ar(inL), In.ar(inR)];
      Out.ar(out, sound*amp);
    }).add;
    context.server.sync;
    synth = Synth.new(\passThru, [
      \inL, context.in_b[0].index,      
      \inR, context.in_b[1].index,
      \out, context.out_b.index,
      \amp, 0],
    context.xg);
    this.addCommand("test", "ifs", {|msg|
      msg.postln;
    });
    this.addCommand("amp", "f", {|msg|
      synth.set(\amp, msg[1]);
    });
  }

  free {
    synth.free;
  }
} 