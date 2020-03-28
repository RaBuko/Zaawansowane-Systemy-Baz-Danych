
echo START > timings.txt
date /t >> timings.txt
echo @Etap_1B\ZESTAW_A.sql | sqlplus -s C##test1/password1 >> timings.txt
echo @Etap_1B\ZESTAW_B.sql | sqlplus -s C##test1/password1 >> timings.txt
echo @Etap_1B\ZESTAW_C.sql | sqlplus -s C##test1/password1 >> timings.txt
echo END >> timings.txt
