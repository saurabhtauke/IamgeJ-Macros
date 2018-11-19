// somehow go to  a window

plen = 10; // LineProfile length
fname = getInfo("image.filename");

run("Set Measurements...", "area center integrated nan redirect=None decimal=3");
setAutoThreshold("Default dark no-reset");
run("Analyze Particles...", "  circularity=0.01-1.00 show=Overlay display exclude clear include add");

trash = nResults

index = newArray(trash);

fwhm_h = newArray(trash);
fwhm_v = newArray(trash);
fwhm_d = newArray(trash);

rsq_h = newArray(trash);
rsq_v = newArray(trash);
rsq_d = newArray(trash);

for (pindex = 0; pindex < trash; pindex++) {
particle = pindex+1;
index[pindex] = particle;
//particle = 11

cx = getResult("XM", particle-1);
cy = getResult("YM", particle-1);

selectWindow(fname);

makeLine(cx-plen, cy, cx+plen, cy);
profile = getProfile();

//Plot.create("Profile", "X", "Value", profile);
//Array.print(profile)

linx = newArray(lengthOf(profile));

for (i = 0; i < lengthOf(profile); i++) 
 linx[i] = i;

Fit.doFit("Gaussian", linx, profile); 
//Fit.plot; 
fwhm_h[pindex] = 2.355 * Fit.p(3); // p(3) represents the sigma parameter (d in the formula)
rsq_h[pindex] = Fit.rSquared;

// vertical

selectWindow(fname);
makeLine(cx, cy-plen, cx, cy+plen);
profile = getProfile();

linx = newArray(lengthOf(profile));

for (i = 0; i < lengthOf(profile); i++) 
 linx[i] = i;

Fit.doFit("Gaussian", linx, profile); 
//Fit.plot; 
fwhm_v[pindex] = 2.355 * Fit.p(3);
rsq_v[pindex] = Fit.rSquared;

// Diagonal
selectWindow(fname);

makeLine(cx-(plen/sqrt(2)), cy-(plen/sqrt(2)), cx+(plen/sqrt(2)), cy+(plen/sqrt(2)));
profile = getProfile();

linx = newArray(lengthOf(profile));

for (i = 0; i < lengthOf(profile); i++) 
 linx[i] = i;

Fit.doFit("Gaussian", linx, profile); 
//Fit.plot; 
fwhm_d[pindex] = 2.355 * Fit.p(3);
rsq_d[pindex] = Fit.rSquared;
}

// Display results
Array.show(index, fwhm_h,rsq_h,fwhm_v,rsq_v,fwhm_d,rsq_d)

