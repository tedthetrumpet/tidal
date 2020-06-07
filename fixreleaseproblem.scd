// realisation!
// even if I get sustain right in the synth, sustain in dirt-gate or DirtEvent or wherever
// will *not get longer*. So I have to fix the problem there, add release tail in?
// now trying with his ~tail mod
// leaving it like that for now, should not actually break anything…


(
SynthDef(\jul, {|out, sustain=1.0, pan, freq = (60.midcps), tail = 0.8 |
	var gateLength, releaseTime, line, env, sig;
	releaseTime = tail - 0.01 - 0.3; // take of attack and decay time
	gateLength = (tail).max(sustain - tail).poll(1);
	// gateLength = (sustain + tail).max(sustain - tail).poll;
	line = Line.kr(1, 0, gateLength);
	env = EnvGen.ar(Env.adsr(attackTime: 0.01, decayTime: 0.3, sustainLevel: 0.5, releaseTime: releaseTime, curve: 0), gate: line, doneAction: Done.freeSelf);
	sig = Saw.ar(freq);
	OffsetOut.ar(out, DirtPan.ar(sig, ~dirt.numChannels, pan, env));
}).add
);

SuperDirt.default = ~dirt;
//
(instrument: \jul, dur: 4, sustain: 3).play
(instrument: \jul, dur: 4, legato: 1).play
(instrument: \jul, dur: 4, legato: 1, tail: 0.2).play // no, end up with negative releaseTime now!

(type: \dirt, sound: \jul, sustain: 4, freq: 60.midicps, amp: 1).play
// still wrong if sustain < tail
(type: \dirt, sound: \jul, sustain: 4, freq: 60.midicps, amp: 1, tail: 0.1).play
(type: \dirt, sound: \jul, sustain: 4, freq: 60.midicps, amp: 1, tail: 1).play
// much closer!!!!!!!!!!!
// sustain in dirt is correct, is adding ~tail from dirt event!
// sustain 2.999, tail 2
// gateLength is 2
// length of sound actually needed is 1 sustain plus 2 + 0.01 + 0.3 = 3.31
// so it is the attack and decay portions that are missing in the dirt event
(type: \dirt, sound: \jul, sustain: 1, freq: 60.midicps, amp: 1, tail: 2).play
// so use ~tail, but subtract attack and decay from release in the envelope?
// still doesn't work, why?


// post function
(
~dirt.addModule('post',
	{ |dirtEvent|
		"\n------------\n".post;
		dirtEvent.event.pairsDo { |key, val, i|
			"%: % ".format(key, val).post;
			if(i % 4 == 0) { "\n".post };

		};
		"\n------------\n".post;
});
)
// remove it again:
~dirt.removeModule(\post);


// hacking julian's own tutorial synth

(
SynthDef(\jul, {|out, sustain=1, pan, freq = (60.midcps) |
	var env = EnvGen.ar(Env.perc(0.001, 0.999, 1, -4), timeScale:sustain, doneAction:2);
	var sound = Saw.ar(freq);
	OffsetOut.ar(out, DirtPan.ar(sound, ~dirt.numChannels, pan, env));
}).add
);

// basically same
(instrument: \jul).play
(instrument: \jul, dur: 4, legato: 1).play
(type: \dirt, instrument: \jul, sustain: 4, freq: 60.midicps).play
(type: \dirt, instrument: \jul, dur: 4, freq: 60.midicps).play

// plays forever, no gate
// add gate 1 still plays forever
// timeScale:sustain is julian's thing, lengthens attack
(
SynthDef(\jul, {|out, sustain=1, pan, freq = (60.midcps), zort = 1.0 |
	var gateLength, line, env, sig;
	gateLength = (sustain + zort).max(sustain - zort).poll;
	line = Line.kr(1, 0, gateLength);
	env = EnvGen.ar(Env.adsr(attackTime: 0.01, decayTime: 0.3, sustainLevel: 0.5, releaseTime: zort, curve: 0), gate: line, doneAction: Done.freeSelf);
	sig = Saw.ar(freq);
	OffsetOut.ar(out, DirtPan.ar(sig, ~dirt.numChannels, pan, env));
}).add
);

// works here
(instrument: \jul).play
(instrument: \jul, dur: 4, legato: 1).play
// ah! intersting, sounds like dirt_gate cuts that off!
// so need to *lengthen* line?
//
(type: \dirt, instrument: \jul, sustain: 4, freq: 60.midicps, amp: 1).play
// correct, but wrong in tidal
(type: \dirt, instrument: \jul, sustain: 4, freq: 60.midicps, amp: 1, rel: 0.1).play
(type: \dirt, instrument: \jul, sustain: 4, freq: 60.midicps, amp: 1, zort: 0.1).play
(type: \dirt, instrument: \jul, sustain: 1, freq: 60.midicps, amp: 1, zort: 2).play





// bpm120, once "909"
// sustain is length of sample
length: 1.0
speed: 1.0 amp: 0.4 sustain: 0.28367120181406 pan: 0.0
cut: 0.0 synthGroup: 1062 fadeInTime: 0.0 s: 909
cycle: 55.554222106934 fadeTime: 0.001 cps: 0.5 delta: 2.0
freq: 261.6255653006 endSpeed: 1.0 delayAmp: 0.0 latency: 0.099008379711563

// once $ n "c" # s "supersaw"
length: 1.0
speed: 1.0 amp: 0.4 sustain: 1.999 pan: 0.0
cut: 0.0 synthGroup: 1067 n: 0.0 fadeInTime: 0.0
s: supersaw cycle: 177.79342651367 fadeTime: 0.001 cps: 0.5
delta: 2.0 freq: 261.6255653006 endSpeed: 1.0 delayAmp: 0.0
latency: 0.092425011490718
// once $ n "c" # s "supersaw" # sustain 1
length: 1.0
speed: 1.0 amp: 0.4 sustain: 0.999 pan: 0.0
cut: 0.0 synthGroup: 1070 n: 0.0 fadeInTime: 0.0
s: supersaw cycle: 221.90423583984 fadeTime: 0.001 cps: 0.5
delta: 2.0 freq: 261.6255653006 endSpeed: 1.0 delayAmp: 0.0
latency: 0.099660861440498
// once $ n "c" # s "supersaw" # legato 0.5 -- weird, sustain is same?!?
length: 1.0
speed: 1.0 amp: 0.4 sustain: 0.999 pan: 0.0
cut: 0.0 synthGroup: 1074 legato: 0.5 n: 0.0
fadeInTime: 0.0 s: supersaw cycle: 301.54278564453 fadeTime: 0.001
cps: 0.5 delta: 2.0 freq: 261.6255653006 endSpeed: 1.0
delayAmp: 0.0 latency: 0.099352082097084
// once $ n "c" # s "supersaw" # legato 0.2 -- now sustain is shorter
length: 1.0
speed: 1.0 amp: 0.4 sustain: 0.39900000596046 pan: 0.0
cut: 0.0 synthGroup: 1075 legato: 0.20000000298023 n: 0.0
fadeInTime: 0.0 s: supersaw cycle: 449.06845092773 fadeTime: 0.001
cps: 0.5 delta: 2.0 freq: 261.6255653006 endSpeed: 1.0
delayAmp: 0.0 latency: 0.096794229979423
// once $ n "c" # s "supersaw" # sustain 4
length: 1.0
speed: 1.0 amp: 0.4 sustain: 3.999 pan: 0.0
cut: 0.0 synthGroup: 1076 n: 0.0 fadeInTime: 0.0
s: supersaw cycle: 486.84753417969 fadeTime: 0.001 cps: 0.5
delta: 2.0 freq: 261.6255653006 endSpeed: 1.0 delayAmp: 0.0
latency: 0.098796860467246










// dirt_gate is in core-synths.scd

// thinking again, to get adsr
// dirt gives us 'sustain', need to derive 'gateTime'
// gateTime = sustain - release?
// check plain sc synth adsr works as expected
// dur = inter-onset time
// sc sustain = dur * legato, so set sustain directly
// sc sustain = 'gateTime'?
// using linear curve for plot clarity

(
SynthDef(\sc, { |out = 0, freq = (60.midicps), gate = 1, amp = 0.1, attack = 0.01, decay = 0.3, level = 0.5, release = 1, pan = 0|
	var sig, env;
	env = EnvGen.kr(Env.adsr(attackTime: attack, decayTime: decay, sustainLevel: level, releaseTime: release, curve: \linear), gate, doneAction: Done.freeSelf);
	sig = Saw.ar(freq);
	Out.ar(out, Splay.ar(sig, center:pan) * amp * env)
}).add;
)

// make attack a bit longer for testing
// attack phase 0 to 0.1, decay phase 0.1 to 0.4, sustain phase afer 0.4
// note off during sustain phase, decay phase, and attack phase
s.record
P(\a, \i, \sc, \legato, 1, \dur, 3, \attack, 0.1, \sustain, [1,0.2,0.05].pseq(3), \amp, 0.9).play
s.stopRecording; P(\a).stop;
"/Users/jsimon/Dropbox/SuperCollider Recordings/".openOS
// yes! confirmed adsr behaviour is correct here

// no gate, use 'sustain' in the tidal meaning
(
SynthDef(\tidal, { |out = 0, freq = (60.midicps), amp = 0.1, attack = 0.01, decay = 0.3, level = 0.5, release = 1, pan = 0, sustain = 1|
	var sig, env, line, gateTime;
	gateTime = sustain - release;
	line = Line.kr(1, 0, gateTime);
	env = EnvGen.kr(Env.adsr(attackTime: attack, decayTime: decay, sustainLevel: level, releaseTime: release, curve: \linear), gate: line, doneAction: Done.freeSelf);
	sig = Saw.ar(freq);
	Out.ar(out, Splay.ar(sig, center:pan) * amp * env)
}).add;
)

s.record
P(\a, \i, \tidal, \legato, 1, \dur, 3, \attack, 0.1, \sustain, [2,1.2,1.05].pseq(3), \amp, 0.9).play
P(\a).stop;
s.stopRecording;
"/Users/jsimon/Dropbox/SuperCollider Recordings/".openOS








// try again using eris stuff
// no amp value?
(
SynthDef(\js2, {
	|out, sustain = 1, freq = (60.midicps), pan, attack = 0.01, decay = 0.1, level = 0.5 release = 0.89|
	var sig, line, env, theEnv, length;
	length = sustain.max(release + attack + decay);
	line = Line.kr(1, 0, length);
	theEnv = Env.adsr(attackTime: attack, decayTime: decay, sustainLevel: level, releaseTime: release);
	env = EnvGen.kr(envelope: theEnv, gate: line, doneAction: Done.freeSelf);
	sig = Saw.ar(freq * [1,1.001, 0.999]).sum;
	OffsetOut.ar(out, DirtPan.ar(sig, ~dirt.numChannels, pan, env));
}).add;
)

// complex
// if sustain > envelope length, sustain then release
// if sustain < envelope lenth, then scale it?
// length is either release or sustain-release, whichever is longer

// ok, but: what if we have a long decay and a short release?

// still not right. we should always get the full release
// but not always the full decay or attack

sustain.min(release + attack + decay)



s.record
s.stopRecording

4.max(3)


// this very close, does not quite go into release phase as desired
(instrument: \jseris2, sustain:3 , attack: 0.01, decay:0.3, release:2).play //
(instrument: \jseris2, sustain:0.1 , attack: 0.01, decay:2, release:0.1).play //
(instrument: \jseris2).play //
(instrument: \default).play

Env.adsr.plot

// so, would need a sort of internal gate?
// Pulse? Line? Impulse
// Line from 1 to zero as gate?

EnvGen


"/Users/jsimon/Dropbox/SuperCollider Recordings/".openOS


// attack + decay + release must be scaled to 1 second!

[0.1, 0.5, 1].normalizeSum


Env(levels: [0,1,0.5,0], times: [0.1,0.2,1], curve: -3).plot // correct 1.3 secs


Env(levels: [0,1,0.5,0],times: [0.1,0.3,1], curve:-3).plot


----------

(
SynthDef(\jseris, {
	|out, sustain = 1, freq = 440, begin=0, end=1, pan, attack = 0.1, decay = 0.2, release = 0.7|
	var sig, line, env, theEnv;
	line = Line.kr(begin, end, sustain, doneAction: Done.freeSelf);
	theEnv = Env(levels: [0,1,0.5,0], times: [attack, decay, release].normalizeSum, curve: -3);
	env = IEnvGen.kr(theEnv, line);
	sig = Saw.ar(freq);
	OffsetOut.ar(out, DirtPan.ar(sig, ~dirt.numChannels, pan, env));
}).add;
)






SynthDef(\sawpluck, {
	|out, sustain = 1, freq = 440, speed = 1, begin=0, end=1, pan, accelerate, offset|
	var line = Line.ar(begin, end, sustain, doneAction:2);
	var env = Env([0, 1, 0.333, 0],[5, 70, 300]);
	var envGen = IEnvGen.ar(env, line*env.times.sum*abs(speed));
	var speedFreq = freq*abs(speed);
	var sound = Saw.ar(speedFreq);
	Out.ar(out, DirtPan.ar(sound, ~dirt.numChannels, pan, envGen));
}).add;

(instrument: \sawpluck, end: 0.5).play






///////////////

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


