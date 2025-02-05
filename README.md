Esta herramienta es un script en Bash que utiliza la utilidad impacket-getTGT para enumerar usuarios en un entorno Kerberos. Aprovecha las respuestas del Key Distribution Center (KDC) ante solicitudes de Ticket-Granting Ticket (TGT) sin contraseña para identificar si un usuario existe o no en el dominio.

El script recorre una lista de usuarios (proporcionada en un archivo de texto) e intenta obtener un TGT para cada usuario utilizando la opción -no-pass. Según la respuesta del KDC, el script determina:

Usuario existente:
Se identifica cuando la salida contiene mensajes como KRB5KDC_ERR_PREAUTH_REQUIRED o SessionKeyDecryptionError. Estos mensajes indican que el usuario existe, pero se requiere preautenticación.

Usuario inexistente:
La ausencia de esos mensajes o la aparición de errores como KRB5KDC_ERR_C_PRINCIPAL_UNKNOWN indican que el usuario no se encuentra en la base de datos de Kerberos.

Una vez que se identifica un usuario válido (con PREAUTH_REQUIRED), se abre la posibilidad de realizar ataques adicionales.

# Algunas de las técnicas que podrían explorarse son:

**Ataque de Fuerza Bruta o Dictionary Attack**
Al confirmar la existencia del usuario, se puede intentar un ataque de fuerza bruta o basado en diccionarios para descubrir su contraseña. La respuesta del KDC confirma que la cuenta es válida y, por lo tanto, es un blanco potencial.

**Kerberoasting**
Si el usuario identificado corresponde a una cuenta de servicio, se puede solicitar un ticket de servicio para dicho usuario. El hash contenido en el ticket puede extraerse y luego someterse a ataques offline para intentar romper la contraseña.

![image](https://github.com/user-attachments/assets/a473472b-4850-4cad-9781-42eeffb896bb)
