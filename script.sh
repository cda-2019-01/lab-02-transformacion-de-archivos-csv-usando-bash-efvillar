cd estaciones/
awk '{print FILENAME (NF?";":"") $0}' estacion1.csv > estacion1_1.csv
awk '{print FILENAME (NF?";":"") $0}' estacion2.csv > estacion2_1.csv
awk '{print FILENAME (NF?";":"") $0}' estacion3.csv > estacion3_1.csv
awk '{print FILENAME (NF?";":"") $0}' estacion4.csv > estacion4_1.csv
tail -n+2 estacion2_1.csv >estacion2_sc.csv
tail -n+2 estacion3_1.csv >estacion3_sc.csv
tail -n+2 estacion4_1.csv >estacion4_sc.csv
cat estacion1_1.csv estacion2_sc.csv estacion3_sc.csv estacion4_sc.csv > estaciones.csv
rm estacion2_sc.csv
rm estacion3_sc.csv
rm estacion4_sc.csv
rm estacion1_1.csv
rm estacion2_1.csv
rm estacion3_1.csv
rm estacion4_1.csv
sed '1s/estacion1.csv/ESTACION/' estaciones.csv > estaciones_temp_A.csv
sed 's/.csv//' estaciones_temp_A.csv > estaciones_temp_B.csv
tr ',' '.' < estaciones_temp_B.csv> estaciones_temp_1.csv
tr ';' ',' < estaciones_temp_1.csv > estaciones_temp_2.csv
rm estaciones_temp_A.csv
rm estaciones_temp_B.csv
rm estaciones_temp_1.csv
rm estaciones.csv
sed 's/\([0-9][0-9]\)\/\([0-9][0-9]\),/\1\/\2,\1,/' estaciones_temp_2.csv > estaciones_temp_3.csv
sed '1s/FECHA,/FECHA,MES,/' estaciones_temp_3.csv > estaciones_temp_4.csv
sed 's/\([0-9][0-9]\),/\1,\1,/' estaciones_temp_4.csv > estaciones_temp_5.csv
sed '1s/FECHA,/FECHA,ANNO,/' estaciones_temp_5.csv > estaciones_temp_6.csv
sed 's/\([0-9][0-9]\)\:\([0-9][0-9]\),/\1\:\2,\1,/' estaciones_temp_6.csv > estaciones_temp_7.csv
sed '1s/HHMMSS,/HHMMSS,HORA,/' estaciones_temp_7.csv > estaciones_temp_8.csv
rm estaciones_temp_2.csv
rm estaciones_temp_3.csv
rm estaciones_temp_4.csv
rm estaciones_temp_5.csv
rm estaciones_temp_6.csv
rm estaciones_temp_7.csv
cp estaciones_temp_8.csv estaciones.csv
rm estaciones_temp_8.csv
csvsql --query 'select ESTACION, ANNO, avg(VEL) from estaciones GROUP BY ESTACION, ANNO' estaciones.csv > velocidad-por-ano.csv
csvsql --query 'select ESTACION, MES, avg(VEL) from estaciones GROUP BY ESTACION, MES' estaciones.csv > velocidad-por-mes.csv
csvsql --query 'select ESTACION, HORA, avg(VEL) from estaciones GROUP BY ESTACION, HORA' estaciones.csv > velocidad-por-hora.csv
