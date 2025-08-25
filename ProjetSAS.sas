LIBNAME PRSAS "/home/u63758325/Stat avec SAS/donnees";

LIBNAME PRSAS list;


/* Exercice 1 */

Data PRSAS.COULEUR;
input SEXE $ CHEVEUX$ EFFECTIF;
cards;
GARCON BLOND 592
GARCON ROUX 119
GARCON CHATAIN 849
GARCON BRUN 504
GARCON NOIR_DE_JAIS 36
FILLE BLOND 544
FILLE ROUX 97
FILLE CHATAIN 677
FILLE BRUN 451
FILLE NOIR_DE_JAIS 14
;
Run;

Proc freq data = prsas.couleur order = data;
tables sexe*cheveux /expected;
weight effectif;
title1 "Tableau de contingence observé";
title2 "------------------------------------------------";
run;

Proc freq data = prsas.couleur order = data;
tables sexe*cheveux/expected nofreq nopercent nocol norow;
weight effectif;
title1 "Tableau dees effectifs";
title2 "------------------------------------------------";

run;

Proc freq data = prsas.couleur order = data;
tables sexe*cheveux /chisq noprint  ;
weight effectif;
title1 "Test de chi2";
title2 "------------------------------------------------";
run;



/* Exercice 2 */

PROC IMPORT OUT = PRSAS.molecule
DATAFILE="/home/u63758325/Stat avec SAS/donnees/molecule.csv"
DBMS= csv ;
GETNAMES=YES ;
RUN;

proc means data=prsas.molecule ;
    class traitement;
    var mesure;
    output out=StatistiquesDescriptives mean= Moyenne std= EcartType min= Minimum max= Maximum n= Effectif;
    title1 "Statistique descriptive par traitement";
title2 "------------------------------------------------";
run;


PROC UNIVARIATE DATA=prsas.molecule ;
class traitement;
VAR mesure ;
QQPLOT mesure ;
RUN ;



proc univariate data=prsas.molecule normal;
class traitement;
    var mesure;
    histogram / normal;
    qqplot / normal;

run;

proc sgplot data=prsas.molecule;
    vbox mesure / category=traitement;
    title "Boxplot par Traitement";
run;



proc ttest data=prsas.molecule;
    class traitement;
    var mesure;
run;


/* Exercice 3 */


PROC IMPORT OUT = PRSAS.ozone
DATAFILE="/home/u63758325/Stat avec SAS/donnees/ozone.xls"
DBMS= xls ;
GETNAMES=YES ;
RUN;


proc means data=prsas.ozone ;
    output out=StatistiquesDescriptives mean= Moyenne std= EcartType min= Minimum max= Maximum n= Effectif;
    title1 "Statistique descriptive pour ozone";
title2 "------------------------------------------------";
run;




proc reg data=prsas.ozone plots=(qqplot Residuals(smooth) cooksd(label) residualbypredicted(label) );
model maxO3 = T9  T12  T15  Ne9  Ne12  Ne15 Vx9  Vx12  Vx15 / VIF ;
run;



PROC REG DATA=prsas.ozone plots=diagnostics(unpack) ;
model maxO3 = T9  T12  T15  Ne9  Ne12  Ne15 Vx9  Vx12  Vx15;
run ;

proc reg data=prsas.ozone;
    model maxO3 = T9 T12 T15 Ne9 Ne12 Ne15 Vx9 Vx12 Vx15;
    plot residual.*predicted.;
run;

proc reg data=prsas.ozone plots=(qqplot Residuals(smooth) 
cooksd(label) residualbypredicted(label));
model maxO3 = T9   T15  Ne9  Ne12  Ne15 Vx9  Vx12  Vx15/VIF ;
run;

proc reg data=prsas.ozone plots=(qqplot Residuals(smooth) 
cooksd(label) residualbypredicted(label));
model maxO3 = T9   T15  Ne9  Ne12  Ne15 Vx9  Vx12  Vx15/selection = backward;
run;

proc reg data=prsas.ozone plots=(qqplot Residuals(smooth) 
cooksd(label) residualbypredicted(label));
model maxO3 = T9   T15   Ne12  Vx9 ;
run;
