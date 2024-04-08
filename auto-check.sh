#!/bin/bash
SUM=0;
for i in {0..3}; do 
RTR=$(echo "RTR_$i" | tr '[0-3]' '[A-D]');
echo "------------------------------------------RTR_$i--------------------------------------------" | tr '[0-3]' '[A-D]';
echo "Task 1 - $RTR"
qm guest exec 10$i -- bash -c "ip -br l" | grep out-data | sed -e 's/\\n/\n/g' | grep ens | awk '{print $1,$3}' > RTR"$i"_net; 
case $i in
	0)
	if grep "ens18 bc:24:11:a7:bf:01" RTR"$i"_net && grep "ens19 bc:24:11:6f:0e:19" RTR"$i"_net ; then
		SUM=$(echo "$SUM + 1.25" | bc);
		echo "Решено верно";
	else
		echo "Решено неверно";
	fi
	echo " Текущий балл - $SUM"
	;;
	1)
	if grep "ens18 bc:24:11:da:2f:cf" RTR"$i"_net && grep "ens19 bc:24:11:f9:39:e0" RTR"$i"_net ; then
                SUM=$(echo "$SUM + 1.25" | bc);
                echo "Решено верно";
        else
                echo "Решено неверно";
        fi
	echo " Текущий балл - $SUM"
	;;
	2)
	if grep "ens18 bc:24:11:08:88:95" RTR"$i"_net && grep "ens19 bc:24:11:c3:89:79" RTR"$i"_net ; then
                SUM=$(echo "$SUM + 1.25" | bc);
		echo "Решено верно";
        else
                echo "Решено неверно";
        fi
	echo " Текущий балл - $SUM"
	;;
	3)
	if grep "ens18 bc:24:11:31:50:36" RTR"$i"_net && grep "ens19 bc:24:11:77:7f:7f" RTR"$i"_net ; then
                SUM=$(echo "$SUM + 1.25" | bc);
                echo "Решено верно";
        else
                echo "Решено неверно";
        fi
	echo " Текущий балл - $SUM"
	;;
esac
echo "--------------------------------------------------------------------------------------------"
sleep 3
echo "Task 2 - $RTR"
qm guest exec 10$i -- bash -c "ip -br a" | grep out-data | sed -e 's/\\n/\n/g' | grep ens | awk '{print $1,$3}' > RTR"$i"_net ; 
IP_LINE_ENS18=`grep "ens18" RTR"$i"_net | awk '{print $2}'`;
IP_LINE_ENS19=`grep "ens19" RTR"$i"_net | awk '{print $2}'`
echo "Проверка для интерфейса ens18"
echo "Адрес - $IP_LINE_ENS18"
echo "-----------------"
echo "Необходимо проверить класс сети (последняя строка), последний октет должен совпадать с параметром HostMin/HostMax, префикс в параметре Netmask";
echo "Правильные параметры сети";
ipcalc -n -b $IP_LINE_ENS18
echo "Возможно следующее использование масок:"
echo "RTR_A - 27 и меньше;";
echo "RTR_B - 27 и меньше;";
echo "RTR_C - 22 и меньше;";
echo "RTR_D - 22 и меньше;";
sleep 1;
while true; do
    read -p "Правильно ли решено задание? (y/n): " yn
    case $yn in
        [Yy]* ) 
	SUM=$(echo "$SUM + 2.5" | bc); 
	break;
	;;
        [Nn]* ) 
	break;
	;;
        * ) echo "Please answer yes or no."
	;;
    esac
done
echo "Проверка для интерфейса ens19"
echo "Адрес - $IP_LINE_ENS19"
echo "-----------------"
echo "Необходимо проверить класс сети (последняя строка), последний октет должен совпадать с параметром HostMin/HostMax, префикс в параметре Netmask";
echo "Правильные параметры сети"
ipcalc -n -b $IP_LINE_ENS19
echo "Возможно следующее использование масок:"
echo "RTR_A - 29 и меньше;";
echo "RTR_B - 24 и меньше;";
echo "RTR_C - 24 и меньше;";
echo "RTR_D - 29 и меньше;" 
sleep 1;
while true; do
    read -p "Правильно ли решено задание? (y/n): " yn
    case $yn in
        [Yy]* ) 
        SUM=$(echo "$SUM + 2.5" | bc); 
        break;
        ;;
        [Nn]* ) 
        break;
        ;;
        * ) echo "Please answer yes or no."
        ;;
    esac
done
echo " Текущий балл - $SUM"
echo "--------------------------------------------------------------------------------------------"
sleep 3
echo "Task 3 - $RTR"
#qm guest exec 10$i -- bash -c "vtysh -c 'show interface brief'" | grep out-data | sed -e 's/\\n/\n/g' | grep lo | awk '{print $1,$4}' > RTR"$i"_net ; 
qm guest exec 10$i -- bash -c "vtysh -c 'show run'" | grep out-data | sed -e 's/\\n/\n/g'  > RTR"$i"_net ; 
case $i in
	0)
	if grep "1.1.1.1" RTR"$i"_net ; then
		SUM=$(echo "$SUM + 2.5" | bc);
		echo "Решено верно";
	else
		echo "Решено неверно";
	fi
		;;
	1)
	if grep "2.2.2.2" RTR"$i"_net ; then
                SUM=$(echo "$SUM + 2.5" | bc);
                echo "Решено верно";
        else
                echo "Решено неверно";
        fi
		;;
	2)
	if grep "3.3.3.3" RTR"$i"_net ; then
                SUM=$(echo "$SUM + 2.5" | bc);
		echo "Решено верно";
        else
                echo "Решено неверно";
        fi
		;;
	3)
	if grep "4.4.4.4" RTR"$i"_net ; then
                SUM=$(echo "$SUM + 2.5" | bc);
                echo "Решено верно";
        else
                echo "Решено неверно";
        fi
	;;
esac
echo " Текущий балл - $SUM "
echo "--------------------------------------------------------------------------------------------"
sleep 3
echo "Task 4 - $RTR"
qm guest exec 10$i -- bash -c "ip -br -6 a" | grep out-data | sed -e 's/\\n/\n/g' | grep ens | awk '{print $1,$3}' > RTR"$i"_net ;
case $i in
	0)
	if grep "ens18 2001:db8:acad:a:be24:11ff:fea7:bf01/64" RTR"$i"_net && grep "ens19 2001:db8:acad:d:be24:11ff:fe6f:e19/64" RTR"$i"_net ; then
		SUM=$(echo "$SUM + 2.5" | bc);
		echo "Решено верно";
	else
		echo "Решено неверно";
	fi
	
	;;
	1)
	if grep "ens18 2001:db8:acad:a:be24:11ff:feda:2fcf/64" RTR"$i"_net && grep "ens19 2001:db8:acad:b:be24:11ff:fef9:39e0/64" RTR"$i"_net ; then
                SUM=$(echo "$SUM + 2.5" | bc);
                echo "Решено верно";
        else
                echo "Решено неверно";
        fi
	
	;;
	2)
	if grep "ens18 2001:db8:acad:c:be24:11ff:fe08:8895/64" RTR"$i"_net && grep "ens19 2001:db8:acad:b:be24:11ff:fec3:8979/64" RTR"$i"_net ; then
                SUM=$(echo "$SUM + 2.5" | bc);
		echo "Решено верно";
        else
                echo "Решено неверно";
        fi
	
	;;
	3)
	if grep "ens18 2001:db8:acad:c:be24:11ff:fe31:5036/64" RTR"$i"_net && grep "ens19 2001:db8:acad:d:be24:11ff:fe77:7f7f/64" RTR"$i"_net ; then
                SUM=$(echo "$SUM + 2.5" | bc);
                echo "Решено верно";
        else
                echo "Решено неверно";
        fi
		;;
esac
echo " Текущий балл - $SUM"
echo "--------------------------------------------------------------------------------------------"
sleep 3
echo "Task 5 - $RTR"
qm guest exec 10$i -- bash -c "vtysh -c 'show ip ospf neighbor'" | grep out-data | sed -e 's/\\n/\n/g'  > RTR"$i"_net ; 
cat RTR"$i"_net;
echo "Проверка выполняется вручную. На RTR_A должно быть два соседа в состоянии Full/-." 
echo "На RTR_B и RTR_D два соседа, один в состоянии Full/-, другой - Full/DR."
echo "На RTR_C должно быть два соседа в состоянии Full/Backup."
sleep 1;
while true; do
    read -p "Правильно ли решено задание? (y/n): " yn
    case $yn in
        [Yy]* ) 
        SUM=$(echo "$SUM + 5" | bc); 
        break;
        ;;
        [Nn]* ) 
        break;
        ;;
        * ) echo "Please answer yes or no."
        ;;
    esac
done
echo "Текущий балл - $SUM";
echo "--------------------------------------------------------------------------------------------"
sleep 3
echo "Task 6 - $RTR"
qm guest exec 10$i -- bash -c "vtysh -c 'show ipv6 route'" | grep out-data | sed -e 's/\\n/\n/g' | grep -E "R>" > RTR"$i"_net ;
cat RTR"$i"_net
echo "Проверка выполняется вручную. На всех маршрутизаторах  должно быть две записи."
sleep 1;
while true; do
    read -p "Правильно ли решено задание? (y/n): " yn
    case $yn in
        [Yy]* ) 
        SUM=$(echo "$SUM + 3.75" | bc); 
        break;
        ;;
        [Nn]* ) 
        break;
        ;;
        * ) echo "Please answer yes or no."
        ;;
    esac
done
echo "Текущий балл - $SUM";
echo "--------------------------------------------------------------------------------------------"
sleep 2
if [ $i -le 1 ]; then
	echo "Task 7 - $RTR"
	qm guest exec 10$i -- bash -c "(sleep 3;echo teluser;sleep 3;echo P@ssRTR0rd;sleep 3;) | telnet 127.0.0.1" | grep out-data | sed -e 's/\\n/\n/g' ;
	echo "Проверка выполняется вручную. Если есть строка Last login:..., значит все верно." 
sleep 1;
while true; do
    read -p "Правильно ли решено задание? (y/n): " yn
    case $yn in
        [Yy]* ) 
        SUM=$(echo "$SUM + 5" | bc); 
        break;
        ;;
        [Nn]* ) 
        break;
        ;;
        * ) echo "Please answer yes or no."
        ;;
    esac
done
echo "Текущий балл - $SUM";
else
	echo "Task 8 - $RTR"
	qm guest exec 10$i -- bash -c "sshpass -p 'P@ssRTR0rd' ssh -o StrictHostKeyChecking=no sshuser@127.0.0.1 'id'" | grep out-data | sed -e 's/\\n/\n/g' 
        echo "Проверка выполняется вручную. Если есть строка 'uid=501(sshuser) gid=501(sshuser) groups=501(sshuser)', значит все верно." 
sleep 1;
while true; do
    read -p "Правильно ли решено задание? (y/n): " yn
    case $yn in
        [Yy]* ) 
        SUM=$(echo "$SUM + 5" | bc); 
        break;
        ;;
        [Nn]* ) 
        break;
        ;;
        * ) echo "Please answer yes or no."
        ;;
    esac
done
echo "Текущий балл - $SUM";
fi
echo "--------------------------------------------------------------------------------------------"
rm -rf RTR"$i"_net;
done
echo "Суммарный балл - $SUM"

