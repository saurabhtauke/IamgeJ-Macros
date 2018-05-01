setSlice(1)

run("Clear Results");

for (i=0; i<nSlices; i++){
run("Measure");
run("Next Slice [>]");
}

//hmm = getResult("RawIntDen",i);

//Plot.create("hmmmmmmm","X", "RawIntDen", hmm);