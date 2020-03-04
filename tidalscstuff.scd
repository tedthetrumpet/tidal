SuperDirt.start
SuperDirt.start(path: "/Users/jsimon/Dropbox/SuperCollider/lcode09/../bfsamples/*")

SuperDirt.start(path:"/Users/jsimon/Dropbox/SuperCollider/sldiwaloops/")

"/Users/jsimon/Library/Application Support/SuperCollider/downloaded-quarks/Dirt-Samples/".openOS


"https://tidalcycles.org/index.php/Userbase".openOS

~dirt.freeAllSoundFiles
~dirt.postSampleInfo

~dirt.loadSoundFiles("/Users/jsimon/Dropbox/SuperCollider/lcode09/../bfsamples/*")
~dirt.loadSoundFiles("/Users/jsimon/Dropbox/SuperCollider/sldiwaloops/")

~dirt.loadSoundFiles("/Users/jsimon/Library/Application Support/SuperCollider/downloaded-quarks/Dirt-Samples/*")


().play

// 808 (6) 808bd (25) 808cy (25) 808hc (5) 808ht (5) 808lc (5) 808lt (5) 808mc (5) 808mt (5) 808oh (5) 808sd (25) 909 (1) ab (12) ade (10) ades2 (9) ades3 (7) ades4 (6) alex (2) alphabet (26) amencutup (32) armora (7) arp (2) arpy (11) auto (11) baa (7) baa2 (7) bass (4) bass0 (3) bass1 (30) bass2 (5) bass3 (11) bassdm (24) bassfoo (3) battles (2) bd (24) bend (4) bev (2) bin (2) birds (10) birds3 (19) bleep (13) blip (2) blue (2) bottle (13) breaks125 (2) breaks152 (1) breaks157 (1) breaks165 (1) breath (1) bubble (8) can (14) casio (3) cb (1) cc (6) chin (4) circus (3) clak (2) click (4) clubkick (5) co (4) coins (1) control (2) cosmicg (15) cp (2) cr (6) crow (4) d (4) db (13) diphone (38) diphone2 (12) dist (16) dork2 (4) dorkbot (2) dr (42) dr2 (6) dr55 (4) dr_few (8) drum (6) drumtraks (13) e (8) east (9) electro1 (13) em2 (6) erk (1) f (1) feel (7) feelfx (8) fest (1) fire (1) flick (17) fm (17) foo (27) future (17) gab (10) gabba (4) gabbaloud (4) gabbalouder (4) glasstap (3) glitch (8) glitch2 (8) gretsch (24) gtr (3) h (7) hand (17) hardcore (12) hardkick (6) haw (6) hc (6) hh (13) hh27 (13) hit (6) hmm (1) ho (6) hoover (6) house (8) ht (16) if (5) ifdrums (3) incoming (8) industrial (32) insect (3) invaders (18) jazz (8) jungbass (20) jungle (13) juno (12) jvbass (13) kicklinn (1) koy (2) kurt (7) latibro (8) led (1) less (4) lighter (33) linnhats (6) lt (16) made (7) made2 (1) mash (2) mash2 (4) metal (10) miniyeah (4) monsterb (6) moog (7) mouth (15) mp3 (4) msg (9) mt (16) mute (28) newnotes (15) noise (1) noise2 (8) notes (15) numbers (9) oc (4) odx (15) off (1) outdoor (6) pad (3) padlong (1) pebbles (1) perc (6) peri (15) pluck (17) popkick (10) print (11) proc (2) procshort (8) psr (30) rave (8) rave2 (4) ravemono (2) realclaps (4) reverbkick (1) rm (2) rs (1) sax (22) sd (2) seawolf (3) sequential (8) sf (18) sheffield (1) short (5) sid (12) sine (6) sitar (8) sn (52) space (18) speakspell (12) speech (7) speechless (10) speedupdown (9) stab (23) stomp (10) subroc3d (11) sugar (2) sundance (6) tabla (26) tabla2 (46) tablex (3) tacscan (22) tech (13) techno (7) tink (5) tok (4) toys (13) trump (11) ul (10) ulgab (5) uxay (3) v (6) voodoo (5) wind (10) wobble (1) world (3) xmas (1) yeah (31)


/////// question
Maybe I'm thinking about this wrong?

In SuperCollider I often do something like:

`Pbindef(\a, \note, Pseq((0..7).scramble, inf), \dur, 1/4).play`

Here the list of notes gets scrambled/shuffled *once* on execution, then loops.

I can't quite see how to do something like that in Tidal? Randomness in Tidal is sort of: continuous?

The closest thing I've found is repeatCycles:

`d1 $ repeatCycles 4 $ sound "arpy*8" # n (irand 8)`

which would get me there if I could make the number of repeats infinite? Or is there another way? This doesn't work at all of course, but in my head I'm looking for something like:

`d2 $ up (run 8).shuffle # sound "arpy"`
