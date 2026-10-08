# 🏢 BALSASUD - Sistema Integral de Gestión Empresarial

## 📋 Descripción General

Sistema integral de gestión empresarial que combina:
- **Sistema Documental**: Gestión de documentos con clasificación automática
- **Sistema de Riesgos**: Matriz de riesgos con evaluación y planes de acción

## 🚀 Acceso Rápido

### Página Principal
- **index.html** → Hub principal para acceder a ambos sistemas

### Sistemas
- **documentos.html** → Sistema Documental (gestión de documentos)
- **riesgos.html** → Sistema de Gestión de Riesgos

## 📁 Estructura del Proyecto

```
sistema-documental/
├── index.html              # Hub principal
├── documentos.html         # Sistema Documental
├── riesgos.html            # Sistema de Riesgos
├── css/
│   ├── styles.css          # Estilos del sistema documental
│   └── riesgos.css         # Estilos del sistema de riesgos
├── js/
│   ├── app.js              # Lógica del sistema documental
│   ├── riesgos.js          # Lógica del sistema de riesgos
│   ├── sync-sheets.js      # Sincronización con Google Sheets
│   ├── storage.js          # Almacenamiento IndexedDB
│   └── diagnostico.js      # Sistema de diagnóstico
└── README.md               # Este archivo
```

## ⚙️ Configuración de Google Sheets

### Paso 1: Crear el Google Apps Script

1. Ve a [script.google.com](https://script.google.com)
2. Crea un nuevo proyecto
3. Pega el siguiente código:

```javascript
function doPost(e) {
  const sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  const data = JSON.parse(e.postData.contents);

  if (data.action === 'backup') {
    sheet.clear();
    sheet.appendRow(['ID', 'Descripción', 'Área', 'Actividad', 'Tipo', 'Probabilidad', 'Impacto', 'Total', 'Nivel', 'Responsable', 'Respuesta', 'Estado Plan', 'Fecha Inicio', 'Fecha Término', 'Efectividad', 'Observaciones', 'Fecha Respaldo']);
    data.riesgos.forEach(r => {
      const total = r.probabilidad * r.impacto;
      const nivel = total >= 25 ? 'Extremo' : total >= 12 ? 'Muy Alto' : total >= 6 ? 'Alto' : total >= 4 ? 'Moderado' : 'Leve';
      sheet.appendRow([
        r.id, r.descripcion, r.area, r.actividad, r.tipo,
        r.probabilidad, r.impacto, total, nivel, r.responsable, r.respuesta,
        r.plan ? r.plan.estado : '', r.plan ? r.plan.fechaInicio : '',
        r.plan ? r.plan.fechaTermino : '', r.evaluacion ? r.evaluacion.efectividad + '%' : '',
        r.plan ? r.plan.observaciones : '', new Date().toISOString()
      ]);
    });
    return ContentService.createTextOutput(JSON.stringify({status: 'ok', count: data.riesgos.length}));
  }
  
  if (data.action === 'test') {
    return ContentService.createTextOutput(JSON.stringify({status: 'ok', message: 'Conexión exitosa'}));
  }
}
```

### Paso 2: Implementar como Aplicación Web

1. Haz clic en **Implementar** → **Nueva implementación**
2. Selecciona tipo: **Aplicación web**
3. Configura:
   - **Ejecutar como**: Yo
   - **Acceso**: Cualquier persona
4. Haz clic en **Implementar**
5. Copia la URL generada (debe empezar con `https://script.google.com/macros/s/...`)

### Paso 3: Configurar en el Sistema

1. Abre `riesgos.html`
2. Haz clic en **☁️ Sincronizar con Sheets**
3. Pega la URL en el campo correspondiente
4. Haz clic en **💾 Guardar Configuración**
5. Haz clic en **🔌 Probar Conexión** para verificar

## 🎯 Funcionalidades

### Sistema Documental
- ✅ Dashboard con estadísticas
- ✅ Gestión de documentos por área
- ✅ Clasificación automática con IA
- ✅ Detección de vencimientos
- ✅ Búsqueda global
- ✅ Asistente IA integrado
- ✅ Subida de archivos (IndexedDB)
- ✅ Exportación de datos

### Sistema de Riesgos
- ✅ Dashboard con métricas
- ✅ Matriz de riesgos completa
- ✅ Evaluación de riesgos residuales
- ✅ Planes de acción con seguimiento
- ✅ Reportes y gráficos
- ✅ Asistente IA especializado
- ✅ Sincronización con Google Sheets
- ✅ Exportar/Importar CSV
- ✅ Cálculos automáticos de nivel de riesgo

## 🔧 Requisitos

- Navegador web moderno (Chrome, Firefox, Edge, Safari)
- Conexión a internet (para sincronización con Google Sheets)
- Google Sheets configurado (opcional, para respaldo en la nube)

## 📝 Notas

- Los datos se guardan automáticamente en el navegador (localStorage)
- La sincronización con Google Sheets es opcional pero recomendada
- El sistema funciona completamente sin conexión (excepto sincronización)
- Se recomienda hacer respaldos periódicos exportando CSV

## 🛠️ Solución de Problemas

### La sincronización no funciona
1. Verifica que la URL sea la de EJECUCIÓN (no la de edición)
2. Asegúrate de que el acceso sea "Cualquier persona"
3. Revisa la consola del navegador (F12) para ver errores

### Los datos no se guardan
- Verifica que el navegador permita localStorage
- Limpia la cachía y recarga la página

### Los gráficos no se muestran
- Verifica que Chart.js se cargue correctamente
- Revisa la consola para errores de JavaScript

## 📄 Licencia

© 2026 BALSASUD - Todos los derechos reservados
