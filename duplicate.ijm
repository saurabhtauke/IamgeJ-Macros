run("Duplicate...", "duplicate");
setAutoThreshold("Default dark");
run("Threshold...");
setThreshold(50, 255);


run("Clear Results");

run("Analyze Particles...", "size=6-Infinity pixel exclude clear include stack");

Rescount = getValue("results.count")

a1 = newArray();
a2 = newArray();
a3 = newArray();
at = newArray();

for (i=0; i<Rescount; i++){
hmm = getResult("RawIntDen",i);
a1 = Array.concat(a1,hmm); 

bmm = getResult("Area",i);
a2 = Array.concat(a2,bmm);

cmm = hmm/bmm;
a3 = Array.concat(a3,cmm);
at = Array.concat(at,cmm);
};

//Array.print(a3);

 Array.sort(a3);
mx = a3[Rescount-1];

//Array.print(a3)

//Array.print(a1)

Plot.create("hmmmmmmm","X", "RawIntDen", at);
