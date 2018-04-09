allInOne[eng_,v0_,vb_]:=(

(* defined the constents and V *)
cof := {{1, b1}, {a2, b2}, {a3, b3}, {a4, b4}, {a5, 0}};
v := {0, vb, - (v0 / 2), - (v0 / 2) + vb, - v0};

(* defined a density function *)
densityFunction[f_] := f f\[Conjugate];

(* defined the potential function *)
pot[x_]:= Piecewise[{{v[[1]], x < 0}, {v[[2]], 0 < x < 10}, {v[[3]], 10 < x < 60}, {v[[4]], 60 < x < 70}, {v[[5]], 70 < x}}];

(* defined the form of the wave function in different zone *)
expform[zone_, x_] := 
                    Part[Part[cof, zone], 1] Exp[I k[zone] x] + 
                    Part[Part[cof, zone], 2] Exp[-I k[zone] x];

k[zone_] := Sqrt[(eng - Part[v, zone])/3.81];

(* solve the equations and save the result to result *)
result:= Solve[
    {expform[1 , 0] == expform[2, 0] ,
    expform[2, 10] == expform[3, 10] , 
    expform[3, 60] == expform[4, 60] , 
    expform[4, 70] == expform[5, 70] ,
    (D[expform[1, x],x] /. x->0) == (D[expform[2,  x],x] /. x->0) ,
    (D[expform[2, x],x] /. x->10) == (D[expform[3, x],x] /. x->10) , 
    (D[expform[3, x],x] /. x->60) == (D[expform[4, x],x] /. x->60) , 
    (D[expform[4, x],x] /. x->70) == (D[expform[5, x],x] /. x->70)}, 
    {a2, a3, a4, a5, b1, b2, b3, b4}];

(* defined the final wave function *)
phi[x_]:= Evaluate[
            Piecewise[{{expform[1, x], x < 0}, 
                     {expform[2, x], 0 < x < 10}, 
                     {expform[3, x], 10 < x < 60}, 
                     {expform[4, x], 60 < x < 70}, 
                     {expform[5, x], 70 < x}}]/. result[[1]]
            ];

(* if want to output the R and T, uncommon this line *)
(* refl:= Evaluate[Sqrt[densityFunction[b1]]/. result[[1]]];
trans:= Evaluate[Sqrt[densityFunction[a5]]/. result[[1]]];
Return[{refl, trans}] *)


(* if want to output the plot of wave function, uncommon this line *)
Plot[{pot[x],Re[phi[x]],Im[phi[x]],Sqrt[densityFunction[phi[x]]]},{x,-50,100},PlotRange -> {-2, 2}]
)

(* if want to output the plot of R and T... it takes a few sec *)
ListLinePlot[{Table[{v0, Part[allInOne[0.1, v0, 0.2], 1]}, {v0, 0.0111, 2, 0.001}], 
              Table[{v0, Part[allInOne[0.1, v0, 0.2], 2]}, {v0, 0.0111, 2, 0.001}],
              Table[{v0, 1-Part[allInOne[0.1, v0, 0.2], 1]}, {v0, 0.0111, 2, 0.001}]}, 
              PlotRange -> {0, 1}]

(* if want to output a animation of the wave function *)
Manipulate[allInOne[0.1, v0, 0.2], {v0, 0.0101, 2, 0.002}]

