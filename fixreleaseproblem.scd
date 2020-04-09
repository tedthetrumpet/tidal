(
SynthDef(\blip, { |out= 0, freq = (60.midicps), nharm = 10, gate = 1, amp = 0.1, pan = 0.0, release = 0.01|
	var sig = Blip.ar(freq * ((-2..2)/500 + 1), nharm); // five channels, detuned
	var env = EnvGen.kr(Env.adsr(releaseTime: release), gate, doneAction:2);
	sig = sig * env;
	Out.ar(out, Splay.ar(sig, center:pan) * amp)
}).add;
)

// sound lasts for two beats
(instrument: \blip, sustain: 2, dur: 2, release: 0).play
// sound lasts for for beats
(instrument: \blip, sustain: 2, dur: 2, release: 2).play



//////////// Tidal cuts the release envelope off
// testing synth with long release
(
SynthDef(\dtest, {|out, sustain=1, freq = 0, amp = 1, pan = 0, width = 0.3 |
	var env = EnvGen.ar(Env.linen(
		attackTime:0.01,
		sustainTime:sustain,
		releaseTime: 1, // desired release *after* event finishes
		level:  1,
		curve: -3
	), doneAction:2);
	var sound = SinOsc.ar(440.0);
	OffsetOut.ar(out, DirtPan.ar(sound, ~dirt.numChannels, pan, env));
}).add
);


// using defailt event, works as intended
(instrument: \dtest, dur: 1).play

P(\a, \i, \dtest, \legato, 0.4).play.stop

"/Users/jsimon/Library/Application Support/SuperCollider/downloaded-quarks/SuperDirt/".openOS

SuperDirt.start;
EventShortcuts.off; // otherwise interferes!
SuperDirt.default = ~dirt;

// using DirtEvent, envelope is different, synth params overridden
(type:\dirt, s: \dtest, release: 1, tail: 1).play

P(\b, \type, \dirt, \s, \dtest).play.stop

// Julian Rohrhuber suggestion

~fadeInTime = ~fadeInTime ?? { if(~begin != 0) { ~fadeTime } { 0.0 } };
~sustain = sustain - (~fadeTime + ~fadeInTime) + (~tail ? 0);

// Then you can then send a tail from tidal that matches fadeTime, and also a fadeInTime seperately.


// ?(obj) – If the receiver is nil then answer anObject, otherwise answer the receiver.

// ??(obj) – If the receiver is nil, evaluate the Function and return the result.


