
#!/bin/bash

fichero=agenda.txt
salida=0

while (test $salida -eq 0);
do
	echo agenda: Introduzca una opcion. Pulse h para ayuda
	read opcion
	case $opcion in
	 h)
	   echo -h: Mostrara la ayuda de las opciones.
	   echo -q: Salir de la agenda
	   echo -l: Lista el fichero de la agenda.
	   echo -on: Ordenara la agenda ascendente.
	   echo -a: Añadira una linea.
	   echo -b: Borrar*
	   echo -a*: Encontrar un numero a partir  de un numero de telefono 
	   echo -t*: Encontrarun nombre a partir de un numero de telefono
	   echo -p: Mostrar solo los nombres que empiecen por A
	   echo -m: Modificar un contacto 
	  ;;
	 q)
	   echo Gracias por usar nuestra agenda
	   salida=1
	   ;;
	 l)
           if [ -s $fichero ]; 
	   then
		echo ------------AGENDA-------------
			echo Nombre Telefono
			echo ------ --------

	     	for linea in $(cat $fichero)
	     	do
			echo -e "${linea//:/ }"
	     	done
   	       else
	     	echo El fichero esta vacio
	     	echo Se procedera a su creacion
	     	touch agenda.txt
	     	chmod 755 agenda.txt
               fi
               ;;
	 on)
	   sort -o $fichero $fichero 
	   echo Se ha ordenado por nombre ascendente
           ;;
	 a)
	   echo -e Nombre del contacto:
	   read nombre
	   echo -e Telefono de contacto:
	   read telefono
	   if [ -z $nombre ]|| [ -z $telefono ];
	   then
		echo Todos los espacios son obligatorios
	   fi

	   comprobacion=`cut -f1 -d ":" agenda.txt | grep $nombre | wc -l`
	   if ( test $comprobacion -gt 0 );
	   then
		echo El nombre existe
	   else 
		echo $nombre:$telefono>>$fichero
	   fi
	   ;;
	 b)
		read  borrar_contacto
		grep -v $borrar_contacto $fichero >> copia_borrado.txt
		rm $fichero 
		mv copia_borrado.txt agenda.txt
	   ;;

	 a*)
		read  numero 
		grep $numero agenda.txt | cut -d" " -f1
 		echo "Has encontrado ${numero}"
	  ;;
	 t*)
		read nombre
		grep $nombre agenda.txt | cut -d" " -f1
		echo "Has encontrado a ${nombre}"
	  ;;
	 p)
		read letra
		grep $letra agenda.txt | grep  "A"
	  ;;
	 m)
		read borrar
		grep -v $borrar $fichero >> modificar.txt
		rm $fichero
		mv modificar.txt $fichero
		
		echo -e Nombre del contacto:
		read nombres
		echo -e Telefono de contacto:
		read telefonos
		if [ -z $nombres ] || [ -z $telefonos ]
		then
			echo Todos los campos son obligatorios
		fi

		comprobacio=`cut -f1 -d ":" agenda.txt | grep $nombres | wc -l`
		if (test $comprobacio -gt 0)
		then
			echo El nombre existe
		else
			echo $nombres:$telefonos >> $fichero
		fi
		;;
	 *)
		echo "Desconozco esa opcion"
	  ;;
	esac
done

