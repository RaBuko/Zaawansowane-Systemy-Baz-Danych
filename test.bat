
echo START > timings.txt
date /t >> timings.txt
echo @Etap1\A.sql | sqlplus -s C##test1/password1 >> timings.txt
echo @Etap1\B.sql | sqlplus -s C##test1/password1 >> timings.txt
echo @Etap1\C.sql | sqlplus -s C##test1/password1 >> timings.txt
echo END >> timings.txt
