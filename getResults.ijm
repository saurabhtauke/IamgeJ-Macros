setSlice(1)

run("Clear Results");

for (i=0; i<nSlices; i++){
run("Measure");
run("Next Slice [>]");
}
//////////////////////////////////////////

a1 = newArray();

for (i=0; i<nSlices; i++){
hmm = getResult("RawIntDen",i);
a1 = Array.concat(a1,hmm); 
};

//Array.print(a1);

Plot.create("hmmmmmmm","X", "RawIntDen", a1);