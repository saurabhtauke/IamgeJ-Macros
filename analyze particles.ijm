run("Clear Results");

run("Analyze Particles...", "size=25-Infinity pixel exclude clear include stack");

Rescount = getValue("results.count")

a1 = newArray();
a2 = newArray();
a3 = newArray();


for (i=0; i<Rescount; i++){
hmm = getResult("RawIntDen",i);
a1 = Array.concat(a1,hmm); 

bmm = getResult("Area",i);
a2 = Array.concat(a2,bmm);

cmm = hmm/bmm;
a3 = Array.concat(a3,cmm);

};

//Array.print(a3);

 Array.sort(a3);
mx = a3[Rescount-1];

//array.print(a3)

print(mx)
