print("\\Clear")

// somehow go to  a window

// 1. Savename
// 2. Export results 
// 3. Plen


fname = getInfo("image.filename");
//print(fname)
original = getImageID()
//print(original)

dirname = getInfo("image.directory");
savename = "D:\\imagej_dont_delete\\test.csv";

selectImage(original)
run("Set Scale...", "distance=0");
run("Set Measurements...", "area center integrated nan redirect=None decimal=3");
run("Camera setup", "offset=0.0 isemgain=false photons2adu=3.6 pixelsize=1.0");
run("Run analysis", "filter=[Wavelet filter (B-Spline)] scale=2.0 order=3 detector=[Local maximum] connectivity=8-neighbourhood threshold=std(Wave.F1) estimator=[PSF: Integrated Gaussian] sigma=1.6 fitradius=3 method=[Weighted Least squares] full_image_fitting=false mfaenabled=false renderer=[No Renderer]");

run("Export results", "filepath=[D:\\imagej_dont_delete\\test.csv] fileformat=[CSV (comma separated)] sigma=true intensity=true chi2=true offset=true saveprotocol=true x=true y=true bkgstd=true id=true uncertainty=true frame=false");


// saved file, now somehow load it

// Import Results Table

// watch *********SAVENAME***********


run("Table... ", "open=D:/imagej_dont_delete/test.csv");

// import x and y in arrays



 plen = 10; // LineProfile length
ex = 1.3;

 trash = Table.size;

index = newArray(trash);

fwhm_h = newArray(trash);
fwhm_v = newArray(trash);
fwhm_d = newArray(trash);

rsq_h = newArray(trash);
rsq_v = newArray(trash);
rsq_d = newArray(trash);

fw = newArray(trash);
npix = newArray(trash);

calc_int = newArray(trash);

profile_len = (2*plen)+1;


for (pindex = 0; pindex < trash; pindex++) {
particle = pindex+1;
index[pindex] = particle;
//particle = 11

cx = Table.get("x [nm]", particle-1);
cy = Table.get("y [nm]", particle-1);
cf = Table.get("sigma [nm]", particle-1);

fw[pindex] = cf*2.355;
Table.set("FWHM_Avg", pindex, fw[pindex]);

fwt = ex*cf*2.355;
radt = fwt*2;

fwt = floor(fwt) +1;
radt = floor(radt) +1;
makeRectangle(cx-fwt, cy-fwt, radt , radt);
 run("Measure");
run("Add Selection...");

area = getResult("Area", pindex);
//npix[pindex] = area;
Table.set("N_pix", pindex, area,"test.csv");
Table.update;
// Horizontal
selectImage(original);

makeLine(cx-plen, cy, cx+plen, cy);
profile = getProfile();
//run("Add Selection...");

//Plot.create("Profile", "X", "Value", profile);
//Array.print(profile)

linx = newArray(lengthOf(profile));

for (i = 0; i < lengthOf(profile); i++) 
 linx[i] = i;

Fit.doFit("Gaussian", linx, profile); 
//Fit.plot; 
fwhm_h[pindex] = 2.355 * Fit.p(3); // p(3) represents the sigma parameter (d in the formula)
rsq_h[pindex] = Fit.rSquared;

//Table.set("fwhm_h", pindex, fwhm_h[pindex]);
//Table.set("rsq_h", pindex, rsq_h[pindex]);

// vertical

selectImage(original);
makeLine(cx, cy-plen, cx, cy+plen);
profile = getProfile();
//run("Add Selection...");
linx = newArray(lengthOf(profile));

for (i = 0; i < lengthOf(profile); i++) 
 linx[i] = i;

Fit.doFit("Gaussian", linx, profile); 
//Fit.plot; 
fwhm_v[pindex] = 2.355 * Fit.p(3);
rsq_v[pindex] = Fit.rSquared;

//Table.set("fwhm_v", pindex, fwhm_v[pindex]);
//Table.set("rsq_v", pindex, rsq_v[pindex]);

// Diagonal
selectImage(original);

makeLine(cx-(plen/sqrt(2)), cy-(plen/sqrt(2)), cx+(plen/sqrt(2)), cy+(plen/sqrt(2)));
profile = getProfile();
//run("Add Selection...");
linx = newArray(lengthOf(profile));

for (i = 0; i < lengthOf(profile); i++) 
 linx[i] = i;

Fit.doFit("Gaussian", linx, profile); 
//Fit.plot; 
fwhm_d[pindex] = 2.355 * Fit.p(3);
rsq_d[pindex] = Fit.rSquared;

//Table.set("fwhm_d", pindex, fwhm_d[pindex]);
//Table.set("rsq_d", pindex, rsq_d[pindex]);

//Fit.logResults

}

// Display results
//Array.show(index, fwhm_h,rsq_h,fwhm_v,rsq_v,fwhm_d,rsq_d)


