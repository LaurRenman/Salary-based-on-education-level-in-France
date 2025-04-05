/* 1. Import the data to create a SAS table */
LIBNAME lib "/home/u64135292/sasuser.v94";

Proc import DATAFILE="~sasuser.v94/Panel95light.csv"
    OUT=panel
    DBMS=CSV
    REPLACE;
GUESSINGROWS=MAX;
run;

/* 2. Graphically represent the distribution of the variables lw (logarithm of hourly wage), etudes (education level), sexe (gender), exper (potential experience, in months), mois (number of months since the beginning of the panel, in January 95). Hint: appropriately adapt the type of graph to each variable. Your graphs should be prettier and more informative than those given in Applied Econometrics II. */
PROC UNIVARIATE DATA = panel;
  VAR lw;
  HISTOGRAM lw / NORMAL;
  TITLE "Distribution du log-salaire";
  
PROC sgplot data = panel;
  vbar etudes;
  TITLE "Distribution de etudes";
run;

PROC UNIVARIATE DATA = panel;
  VAR exper;
  HISTOGRAM exper / NORMAL;
  TITLE "Distribution de l’expérience";
  
PROC sgplot data = panel;
  vbar mois;
  title "Distribution du mois";
run;

PROC FREQ data=panel;
  tables sexe / out=sex_freq outpct;
run;

proc gchart data=panel;
    pie sexe / type=percent value=inside;
    title "Distribution du sexe";
run;
quit;
