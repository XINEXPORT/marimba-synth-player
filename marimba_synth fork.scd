//SC Tutorial 15, Composing a Piece Part 1

(
SynthDef(\bpfsaw,{
	arg atk=1, sus=3, rel=4, c1=1, c2=(-1),
	freq=500, cf=1500, rq=0.2, amp=1, out=0, detune=0.2, pan=0,
	cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk, sus, rel], [c1,0,c2]),doneAction:2);
	sig = Saw.ar (freq * LFNoise1.kr (0.5,detune).midiratio);
	sig = BPF.ar (
		sig,
		LFNoise1.kr(0.2). exprange(cfmin, cfmax),
		LFNoise1.kr(0.1). exprange(rqmin, rqmax),
	);
	sig = Pan2.ar(sig, pan);
	sig = sig * env *amp;
	Out.ar(out, sig);
}). add;
)


(1..10).choose.do {Synth(\bpfsaw, [\amp,0.5, \detune, 3])};


(
10.do{
	Synth(
		\bpfsaw,
		[
			\freq, 50,
			\amp, 1,
			\cfmin,50*4,
			\cfmax,50*50,
			\rqmin, 0.005*3,
			\rqmax,0.03,
			\pan,1,
		],
	);
};
)

// multichannel expansion - 8 channels

s.options.numOutputBusChannels_(8)
s.reboot;


(
[55,41,20,65,62,72,45,65].midicps.do{
	arg f;
	Synth(\bpfsaw,
	[
			\freq, (Scale.hexDorian.degrees+60).midicps.choose,
			\amp, 0.5,
			\cf, exprand (300, 5000),
			\rq, exprand (0.003, 0.09),
			\atk,exprand (1,3),
			\sus,exprand (0.1,0.2),
	]
);
};
)


(
(1..8).choose.do{
	Synth(\bpfsaw,
	[
			\freq, (Scale.dorian.degrees+60).midicps.choose,
			\amp, 1,
			\cf, exprand (100, 5000),
			\rq, exprand (0.03, 0.9),
			\atk,exprand (1,3),
			\sus,exprand (0.1,0.3),
	]
);
};
)

// BPFSAW PBIND

(
Pbind(
	TempoClock(60/60);
	\instrument,\bpfsaw,
    \dur,Pwhite(4.5,1,inf),
	\midinote, Pxrand([
		[23,35,54,66],
		[45,66,78,96,61,64],
		[28,40,47,56,59,63],
		[42,53,58,61,63],
		[31,33,35,39,41],
	], inf),
	\detune, Pexprand(0.05, 0.7, inf),
	\cfmin, 100,
	\cfmax, 1500,
	\rqmin, Pexprand(0.001,0.015,inf),
	\atk, Pwhite(2,4,2.5,inf) * Pwhite (0.01,3,2, inf),
	\rel,Pwhite(6.5,10.0,inf),
	\ldb,6,
	\amp,0.8,
	\out, 0,
).trace.play;
)

// MARIMBA + SYNTH

(
{a = Pbind(
	TempoClock(60/60);
	\instrument, \bpfsaw,
	\dur, Prand ([1,0.3],inf),
	\freq, Prand([1/2,2/3,4/3,5/2,3,4,6,8],inf),
	\detune, Pwhite(1,0.1,inf),
	\rqmin, 0.05,
	\rqmax, 0.1,
	\cfmin, Prand ((Scale.major.degrees+64).midicps,inf) * Prand ([0.5,1,2.4],inf),
	\cfmax, Pkey (\cfmin) * Pwhite(1.007, 1.025, inf),
	\atk,3,
	\sus,1,
	\rel,5,
	\amp,1.5,
	\out,0,
).play;
6.wait;

b = Pbind(
	TempoClock(60/60);
	\instrument,\bpfsaw,
    \dur,Pwhite(4.5,1,inf),
	\midinote, Pxrand([
		[84,86,88,62],
		[75,73,70,69,68,67],
		[32,41,43,45,47,49],
		[40,46,44,48],
		[24,26,38,82,37],
		[31,33,35,39,41],
		],inf),
    \detune, Pexprand(0.2, 0.5, inf),
	\cfmin, 100,
	\cfmax, 1500,
	\rqmin, Pexprand(0.01,0.15,inf),
	\atk, Pwhite(1,2,inf),
	\rel,Pwhite(1,2.0,inf),
	\ldb,6,
	\amp,0.4,
	\out, 0,
).trace.play;
}.fork;
)

a.stop;
b.stop;










