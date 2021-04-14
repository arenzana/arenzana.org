---
author: iarenzana
blogger_author:
- Ismael Arenzana
blogger_blog:
- micarreta.blogspot.com
blogger_internal:
- /feeds/11302648/posts/default/2782866510724803594
blogger_permalink:
- /2007/10/un-poco-de-informtica-y-consejos-para_25.html
categories:
- Uncategorized
date: "2007-10-25T17:41:00Z"
guid: https://arenzana.org/?p=139
id: 139
title: Un poco de informática y consejos para todos
url: /2007/10/un-poco-de-informatica-y-consejos-para-todos/
---
<p style="text-align:justify;">
  Algunos pueden pensar que soy un poco exagerado o un neurótico. Pero el otro día por la noche bajé a cerrar la puerta de la oficina y me di cuenta de lo vulnerable que era todo el sistema. Desde un robo hasta un incendio. Hay gran cantidad de datos en los ordenadores que debo mantener y cuya pérdida supondría cierta cantidad de lágrimas (en el sentido figurado y literal).
</p>

<p style="text-align:justify;">
  Hace tiempo que soy consciente de la necesidad de las copias de seguridad y llevo un par de años haciendo copias incrementales nocturnas de los datos básicos de trabajo y copias semanales de los datos básicos, música y fotos. De mi ordenador principal al Windows. Y esto está muy bien en el caso de que un disco duro falle (que no sería la primera vez&#8230; ni la última) pero no está a prueba de incendios o robos; la solución?: &#8220;<em><a href="http://en.wikipedia.org/wiki/Off-site_Data_Protection">off-site data protection</a></em>&#8220;
</p>

<p style="text-align:justify;">
  Off-site data protection es, básicamente, crear copias de seguridad remotas (es decir, alejadas del ordenador principal) como parte de un plan de recuperación frente a desastres. Estos desastres pueden ser desde un tornado hasta una bomba atómica. No estoy diciendo que vaya a suceder; pero por muy bajo coste (especialmente teniendo en cuenta de que yo mismo escribo el software) puedo asegurarme de que mi negocio/empleo podrá continuar intacto en caso de desastres de ese tipo.
</p>

<p style="text-align:justify;">
  Como parte de este plan he incluido (o incluiré mañana para ser más exactos) mis fotografías, que son uno de mis grandes tesoros materiales. Algunos tienen un baúl con cosas importantes. Para mí las fotos son las cosas que más me preocuparía perder. De modo que formarán parte de este plan.
</p>

<p style="text-align:justify;">
  Para llevar esta operación a cabo necesito:
</p>

<p style="text-align:justify;">
  &#8211; Conexión a internet.<br /> &#8211; Servicio de almacenamiento remoto.<br /> &#8211; Software de transporte de datos.
</p>

<p style="text-align:justify;">
  El primer punto me lo salto. Ya que todos sabemos cómo conseguir una conexión a internet; si no&#8230;. no sé cómo estás leyendo esto.
</p>

<p style="text-align:justify;">
  El servicio de almacenamiento remoto de elección es <a href="http://www.amazon.com/s3">Amazon S3</a>. La decisión la tomé por varios motivos: es barato, es muy ampliable, personalizable y es bastante rápido. Desventajas? Tú mismo debes desarrollar el software para acceder al servicio; lo cual es un punto malo para algunos&#8230; aunque para mí esto no supone demasiado problema.
</p>

<p style="text-align:justify;">
  Software de transporte de datos. Es básicamente el método que vas a usar para crear la copia de seguridad automáticamente y con la regularidad que deseamos. En mi caso; descargué la librería Java <a href="http://jets3t.s3.amazonaws.com/index.html">jets3t</a>. Estas librerías proveen una interfaz comprensible en java para conectar a Amazon S3. Incluye la aplicación Synchronize que es un ejemplo de aplicación de backup. Con las librerías he conseguido conectar a S3 sin problemas y mostrar contenidos; pero no he tenido tiempo de investigar cómo mandar o recibir archivos; pero&#8230; para qué re-inventar la rueda. Investigué un poco cómo utilizar synchronize y parece fácil: justo lo que necesito. Sólo tuve que crear un script contenedor (casero) que básicamente llamase a esa aplicación las veces necesarias y decidí crear un archivo de configuración con los directorios a copiar. Finalmente con &#8216;cron&#8217; he hecho que esta copia de seguridad remota sea semanal y sin yo enterarme; en caso de fallo o errores recibiré un email.
</p>

<p style="text-align:justify;">
  Mañana debo ejecutar el primer backup remoto de las fotos; ya que con 14Gb puedo pasarlo un poco mal, de modo que lo dejaré corriendo durante el fin de semana. En cuestiones de seguridad no habrá problema; he configurado el programa para que los datos se manden comprimidos y encriptados en 128-bit.
</p>

<p style="text-align:justify;">
  Creo que todo irá bien; en caso contrario&#8230;. me quedaré sin fotos. Supongo.
</p>