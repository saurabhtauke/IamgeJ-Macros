// somehow go to  a window

fname = getInfo("image.filename");

run("Set Measurements...", "area center integrated nan redirect=None decimal=3");
setAutoThreshold("Default dark no-reset");
run("Analyze Particles...", "  circularity=0.01-1.00 show=Overlay display exclude clear include add");

trash = nResults

for (pindex = 0; pindex < trash; pindex++) {
particle = pindex+1;

//particle = 11

cx = getResult("XM", particle-1);
cy = getResult("YM", particle-1);

rsq = newArray(3);
fwhm = newArray(3);

selectWindow(fname);

makeLine(cx-10, cy, cx+10, cy);
profile = getProfile();

//Plot.create("Profile", "X", "Value", profile);
//Array.print(profile)

linx = newArray(lengthOf(profile));

for (i = 0; i < lengthOf(profile); i++) 
 linx[i] = i;

Fit.doFit("Gaussian", linx, profile); 
//Fit.plot; 
fwhm[0] = 2.355 * Fit.p(3);
rsq[0] = Fit.rSquared;

// vertical

selectWindow(fname);
makeLine(cx, cy-10, cx, cy+10);
profile = getProfile();

linx = newArray(lengthOf(profile));

for (i = 0; i < lengthOf(profile); i++) 
 linx[i] = i;

Fit.doFit("Gaussian", linx, profile); 
//Fit.plot; 
fwhm[1] = 2.355 * Fit.p(3);
rsq[1] = Fit.rSquared;

// Diagonal
selectWindow(fname);

makeLine(cx-7, cy-7, cx+7, cy+7);
profile = getProfile();

linx = newArray(lengthOf(profile));

for (i = 0; i < lengthOf(profile); i++) 
 linx[i] = i;

Fit.doFit("Gaussian", linx, profile); 
//Fit.plot; 
fwhm[2] = 2.355 * Fit.p(3);
rsq[2] = Fit.rSquared;

print("Full Width Half Maximum");
Array.print(fwhm);
print("R-Squared");
Array.print(rsq);
}