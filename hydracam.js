s0.initCam(0);
src(s0).out();

s1.initCam(1);
src(s1).out();

src(s0).diff(src(s1)).out();

src(s0).blend(src(s1))
//  .scale(2)
  //.colorama(0.1)
  .contrast(0.6)
  .modulate(noise(0.7))
  .out()

solid().out()
voronoi().out()