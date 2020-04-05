#!/bin/bash
echo @A.sql | sqlplus -s C##test1/password1
echo @B.sql | sqlplus -s C##test1/password1
echo @C.sql | sqlplus -s C##test1/password1
