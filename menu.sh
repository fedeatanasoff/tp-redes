#!/bin/bash
#autor: fd_atanasoff
#fecha: 09/04/2018
#descripcion: menu en bash
#email: fede@fede.com

clear
while :
do
echo 
echo "  --------------------------------------"
echo "  ----------- Monitor de Redes ---------"
echo "  --------------------------------------"
echo
echo "a. Mi direccion IP y de mascara"
echo "b. Direccion de mi router"
echo "c. Dispositivos disponibles en mi red"
echo "d. Comprobar conectividad con dispositivo en mi red"
echo "e. Logearse con ssh a dispositivo remoto"
echo "f. Copiar archivo a servidor remoto con scp"
echo "g. salir"
echo "- seleccione una opcion -"
read opcion
echo

# --- funciones auxiliares --
decidir () {
	echo $1;
	while true; do
		echo "desea ejecutar? (s/n)";
    		read respuesta;
    		case $respuesta in
        		[Nn]* ) break;;
       			[Ss]* ) eval $1
				break;;
        		* ) echo "Por favor tipear S/s ó N/n.";;
    		esac
	done
}

# --- funciones del menu --- #

a_function () {
    echo "----- Direccion de Ip y de mascara -----"
    ifconfig | grep inet | grep netmask | grep broadcast
}

b_function () {
    echo "----- Puerta de enlace ------";
    ip route show | grep "default"
}

c_function () {
    echo "----- Dispositivos conectados a mi Red ------"
    echo -e "ingrese la direccion Ip de su Router"
    read gateway
    sudo nmap -sP $gateway/24
}

d_function () {
    echo "----- comprobar conectividad con dispotivo de mi Red"
    echo -e "ingrese la direccion IP a chequear"
    read host
    ping -c 5 $host | grep -A 3 "statistics"
}

e_function () {
    echo "ingrese el usuario remoto al que quiere conectarse"
    read usuario
    echo "ingrese la ip remota a la que desea conectarse"
    read ip
    echo "conectando a $usuario@$ip"
    ssh -X $usuario@$ip
}

f_function() {
    echo "ingrese el usuario remoto al que quiere conectarse"
    read usuario
    echo "ingrese el dominio al que desea conectarse"
    read ip
    echo "ingrese la ruta del archivo a copiar"
    read archivo
    echo "ingrese la ruta donde quiere copiar el archivo"
    echo "(se recomienda /home/$usuario)"    
    read destino
    echo 
    scp $archivo $usuario@$ip:$destino
}


case $opcion in 
a|A) a_function;;
b|B) b_function;;
c|C) c_function;;
d|D) d_function;;
e|E) e_function;;
f|F) f_function;;
g|G) exit;;
*) echo "$opcion no es una opcion valida, intente nuevamente"
echo "presione una tecla para continuar"
read tecla;;
esac
done 