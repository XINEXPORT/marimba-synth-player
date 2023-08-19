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










