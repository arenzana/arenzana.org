---
author: iarenzana
blogger_author:
- Ismael Arenzana
blogger_blog:
- micarreta.blogspot.com
blogger_internal:
- /feeds/11302648/posts/default/3348474201950245145
blogger_permalink:
- /2013/06/bittorrent-y-la-nueva-nube.html
categories:
- tecnologia
date: "2013-06-01T16:03:00Z"
#publishDate: "2097-01-23T19:09:00Z"
id: 25
title: Bittorrent y la nueva nube
url: /2013/06/bittorrent-y-la-nueva-nube/
---
Hoy toca una pequeña historieta sobre tecnología, que hace mucho que no escribo sobre ello.

Hace unas semanas recibí mi Raspberry Pi y la he cargado con Fedora Linux y la estoy usando como servidor. De momento la Pi sólo está sirviendo SSH, DNS, VPN y SMTP, servicios que no requieren una gran cantidad de recursos para correr aceptablemente. Una magnífica experiencia.

Llevo varias semanas experimentando diferentes combinaciones para conseguir un servicio en la nube tipo Dropbox o iCloud.

Probé OwnCloud y, aunque conseguí instalarlo con éxito y corría correctamente, iba demasiado lento y la sincronización tardaba la vida.

Hace unas semanas descubrí Bittorrent Sync. Es un sistema que te permite sincronizar carpetas enteras utilizando el protocolo Bittorrent.

Este protocolo, al no ser centralizado, te obliga a tener un servidor siempre corriendo para poder realizar las transferencias de forma fiable, esto no es un problema ya que la Raspberry Pi consume unos $3 al año en electricidad. Un precio que estoy dispuesto a pagar.

Rápido, utiliza todo el ancho de banda que le permitas.

Bajo consumo, teniendo la aplicación a pleno rendimiento, usa una media de 74% de CPU y unos 12MB de memoria.

Pros

El tráfico está encriptado.

Realmente multiplataforma.

He mencionado que es gratis?

Cons

  Siempre debe haber un host corriendo el programa para sincronizar, al no ser un sistema centralizado sino distribuido, esto es de esperar.

De momento la aplicación no tiene una barra de estado. Al transferir un archivo es difícil saber cuánto queda.

Actualmente sólo mis archivos de trabajo están siendo sincronizados con este método. En un futuro espero poder hacer lo mismo con las fotografías y demás documentos.

Si te interesa saber cómo hacer esto, aquí van las instrucciones.

Bittorrent Sync + Raspberry Pi

&#8211; Descarga el tar desde la web oficial para Linux ARM:&nbsp;http://labs.bittorrent.com/experiments/sync.html.

&#8211; Descomprime con &#8216;tar xfvz btsync_arm.tar.gz&#8217; (quizá te haga falta instalar tar con `yum install tar`). Pon el binario &#8216;btsync&#8217; en tu directorio personal `/home/user/bin`.

&#8211; Abre el puerto 8888 en iptables con `iptables -A INPUT -s 192.168.1.0/24 -p tcp -m conntrack;ctstate NEW -m tcp;dport 8888 -j ACCEPT`;. En este caso sólo limito este puerto a mi red local; si quiero acceder a este servicio desde fuera, debo utilizar VPN.

&#8211; Inicia el demonio de btsync &#8216;/home/user/bin/btsync&#8217;.

&#8211; Para que se inicie con el servidor edita el archivo /etc/rc.d/rc.local y añadiendo la siguiente línea &#8216;su &nbsp; &nbsp; &nbsp;user -c &#8220;/home/user/bin/btsync > /home/user/.out/btsync.out&#8221;&#8216;.

&#8211; Ahora entra en el GUI para configurarlo en localhost:8888.

Esta es una explicación muy breve, pero debería servir para habilitar el servicio.

Namasté.
