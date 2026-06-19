# Deep Search Manager - Versión real

Aplicación Next.js + Supabase para gestión interna de Deep Search.

## Incluye
- Login real con Supabase Auth
- Roles y permisos configurables
- Usuarios internos y clientes
- Clientes con correo/clave de acceso
- Tareas personalizadas por responsable
- Cronopost separado por cliente
- Varias plataformas por publicación
- Envío/reenvío a aprobación del cliente
- Comentarios del cliente por post
- Conversión de comentarios en tareas
- Dashboard Super Admin con tareas atrasadas
- Tráfico Diseño

## Instalación local
1. Instalar dependencias:
```bash
npm install
```
2. Crear proyecto en Supabase.
3. Ejecutar el SQL de `supabase/schema.sql` en Supabase SQL Editor.
4. Copiar `.env.example` a `.env.local` y pegar claves de Supabase.
5. Ejecutar:
```bash
npm run dev
```

## Publicación recomendada
- Hosting: Vercel
- Base de datos/Auth: Supabase
- Dominio recomendado: app.deepsearch.info
