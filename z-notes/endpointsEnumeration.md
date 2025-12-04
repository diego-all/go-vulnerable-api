# Endpoint enumeration


## sqlmap no se puede se deben conocer


## Burpsuite


1. Interceptar Tráfico: Asegúrate de que Intercept is off (en la pestaña Proxy > Intercept) para que puedas navegar fluido.

Navegación Pasiva (Passive Crawl):

Abre el navegador (conectado al proxy).

Entra a la URL objetivo.

2. Navega manualmente por los menús y links. Burp irá registrando todo automáticamente en el Site Map.

3. Escaneo Activo (Active Crawl) - Solo Burp Professional:

Ve al Dashboard (Pestaña principal).

Haz clic en New Scan > Crawl.

Ingresa la URL y Burp navegará solo.

4. Si usas Community Edition (Gratis):

No tienes el crawler automático del Dashboard.

Tu mejor opción es navegar manualmente por la web o hacer clic derecho en la URL dentro de la pestaña Target y buscar opciones como "Discover Content" (si está disponible en tu versión) para intentar forzar la enumeración.

Paso 4: Revisar el Mapa (Site Map)
Una vez hayas navegado (o corrido el escáner):

Ve a la pestaña Target.

A la izquierda verás la estructura de carpetas (Site Map).

Ahí aparecerán todos los endpoints enumerados (GET, POST, carpetas, archivos js, etc.).