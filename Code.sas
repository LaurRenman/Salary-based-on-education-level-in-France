/* 1. Importer le fichier Panel95light.csu pour en faire une table SAS.*/
LIBNAME lib "/home/u64135292/sasuser.v94";

Proc import DATAFILE="~sasuser.v94/Panel95light.csv"
    OUT=panel
    DBMS=CSV
    REPLACE;
GUESSINGROWS=MAX;
run;

/* 2. Représenter graphiquement la distribution des variables lu (logarithme du salaire horaire), etudes, sexe, exper (ex- périence potentielle, en mois), mois (nombre de mois depuis le début du panel, en janvier 95). Indication : bien adapter le type de graphique à chaque variable. Vos graphiques devraient être plus jolis et plus parlants que ceux donés en Econométrie appliquée II.*/
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
