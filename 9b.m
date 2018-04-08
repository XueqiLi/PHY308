cof := {{1, b1}, {a2, b2}, {a3, b3}, {a4, b4}, {a5, 0}}
v := {v1, v2, v3, v4, v5}
vb := 0.2
v0 := 0.3

v1 := 0
v2 := vb
v3 := - v0 / 2
v4 := - v0 / 2 + vb
v5 := - v0

eng:=0.1
densityFunction[f_] := f f\[Conjugate]

pot[x_]:= Piecewise[{{v1, x < 0}, {v2, 0 < x < 10}, {v3, 10 < x < 60}, {v4, 60 < x < 70}, {v5, 70 < x}}]

expform[zone_, x_] := 
                    Part[Part[cof, zone], 1] Exp[I k[zone] x] + 
                    Part[Part[cof, zone], 2] Exp[-I k[zone] x]

k[zone_] := Sqrt[(eng - Part[v, zone])/3.81]


result:= Solve[
    {expform[1 , 0] == expform[2, 0] ,
    expform[2, 10] == expform[3, 10] , 
    expform[3, 60] == expform[4, 60] , 
    expform[4, 70] == expform[5, 70] ,
    (D[expform[1, x],x] /. x->0) == (D[expform[2,  x],x] /. x->0) ,
    (D[expform[2, x],x] /. x->10) == (D[expform[3, x],x] /. x->10) , 
    (D[expform[3, x],x] /. x->60) == (D[expform[4, x],x] /. x->60) , 
    (D[expform[4, x],x] /. x->70) == (D[expform[5, x],x] /. x->70)}, 
    {a2, a3, a4, a5, b1, b2, b3, b4}]


pot[x_]:= Piecewise[{{v1, x < 0}, {v2, 0 < x < 10}, {v3, 10 < x < 60}, {v4, 60 < x < 70}, {v5, 70 < x}}]
phi[x_]:= Evaluate[
            Piecewise[{{expform[1, x], x < 0}, 
                     {expform[2, x], 0 < x < 10}, 
                     {expform[3, x], 10 < x < 60}, 
                     {expform[4, x], 60 < x < 70}, 
                     {expform[5, x], 70 < x}}]/. result[[1]]
            ]


Plot[{pot[x],Re[phi[x]],Im[phi[x]],Sqrt[densityFunction[phi[x]]]},{x,-50,100}, PlotRange->{-2,2}]


