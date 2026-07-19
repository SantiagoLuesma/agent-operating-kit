---
name: define-product-scope
description: >
  Define un alcance de producto explícito, coherente, priorizado y verificable
  antes de diseñar o implementar. Convierte descubrimiento, auditoría y
  validación de supuestos en una decisión concreta sobre qué se construye, para
  quién, con qué resultado, qué queda fuera, qué se entrega primero y bajo qué
  condiciones se puede ampliar. Congela temporalmente el próximo incremento
  (no el producto entero) para evitar ambigüedad, sobreconstrucción y scope
  creep. Úsala cuando el problema y los actores ya están suficientemente
  descubiertos, hay que acotar una v1 o un incremento, reordenar prioridades o
  resolver contradicciones de requisitos. Produce docs/product/scope.md con
  resultado objetivo, actores, core loop, capacidades MUST/SHOULD/COULD/WON'T,
  no objetivos, incrementos, métricas, control de cambios y un gate
  (SCOPE READY / CONDITIONAL READY / REFINEMENT REQUIRED / MORE EVIDENCE
  REQUIRED / BLOCKED). No implementa código, no diseña arquitectura ni UI
  detallada, no inventa evidencia y no trata toda solicitud como obligatoria.
---

# define-product-scope

## Propósito

Definir un alcance de producto explícito, coherente, priorizado y verificable antes de diseñar o implementar.

Esta skill convierte los resultados de descubrimiento, auditoría y validación en una decisión concreta sobre:

* qué se construirá;
* para quién;
* para qué resultado;
* qué no se construirá;
* qué se entregará primero;
* qué condiciones permitirán ampliar el alcance.

No intenta congelar permanentemente el producto. Congela temporalmente el alcance del próximo incremento para evitar ambigüedad, sobreconstrucción y scope creep.

---

## Cuándo utilizarla

Utilizar esta skill cuando:

* exista una idea de producto suficientemente descubierta;
* se hayan identificado usuarios, problemas y resultados esperados;
* haya supuestos validados, refutados o aceptados como riesgo;
* sea necesario definir una primera versión o próximo incremento;
* un proyecto existente necesite reorganizar prioridades;
* diferentes documentos presenten requisitos contradictorios;
* el equipo no pueda explicar claramente qué queda dentro y fuera.

No utilizarla para diseñar interfaces detalladas, elegir arquitectura, modelar tablas definitivas ni crear un plan técnico de implementación.

---

## Entradas esperadas

Revisar, cuando existan:

* `AGENTS.md`;
* `docs/project-status.md`;
* documentación de descubrimiento;
* registro de supuestos;
* resultados de experimentos;
* auditoría del proyecto existente;
* requisitos proporcionados por stakeholders;
* restricciones comerciales, legales, técnicas u operativas;
* métricas o evidencia de uso;
* decisiones previas relevantes.

No asumir que todos los requisitos solicitados pertenecen automáticamente al alcance.

---

## Procedimiento

### 1. Establecer el contexto de decisión

Identificar:

* producto o área afectada;
* horizonte de planificación;
* incremento que se desea definir;
* responsables de aprobarlo;
* fecha o condición de revisión;
* restricciones conocidas.

Distinguir entre:

* alcance general del producto;
* alcance de una versión;
* alcance del próximo incremento;
* alcance de una única feature.

### 2. Consolidar la evidencia

Resumir únicamente lo respaldado por evidencia disponible:

* usuarios o actores prioritarios;
* problemas relevantes;
* resultados esperados;
* comportamientos observados;
* supuestos respaldados;
* supuestos refutados;
* incertidumbres todavía abiertas;
* riesgos aceptados.

Separar claramente:

* hechos;
* evidencia indirecta;
* decisiones;
* hipótesis;
* preferencias;
* solicitudes sin validar.

No presentar opiniones como hechos.

### 3. Definir el resultado objetivo

Redactar un resultado concreto que el incremento debe habilitar.

Debe indicar:

* quién obtiene valor;
* qué podrá lograr;
* qué cambio observable se espera;
* por qué ese resultado es prioritario.

Evitar objetivos como:

* “crear el módulo”;
* “implementar la plataforma”;
* “agregar funcionalidades”;
* “mejorar la experiencia”.

Preferir resultados observables, por ejemplo:

> Permitir que un comerciante publique y mantenga actualizado su primer perfil sin asistencia manual.

### 4. Definir los actores prioritarios

Clasificar los actores en:

* primarios: reciben el valor central;
* secundarios: participan o reciben valor indirecto;
* operadores: administran, moderan o brindan soporte;
* sistemas externos: integraciones necesarias.

Indicar qué actores no serán atendidos en este incremento.

No intentar satisfacer simultáneamente a todos los segmentos.

### 5. Identificar el core loop

Describir la secuencia mínima de acciones que genera valor repetible.

Para cada paso indicar:

* actor;
* acción;
* precondición;
* resultado;
* posible fallo.

El alcance principal debe proteger este loop antes de agregar capacidades periféricas.

### 6. Definir capacidades dentro del alcance

Incluir solamente capacidades necesarias para completar el resultado objetivo.

Cada capacidad debe contener:

* nombre;
* actor beneficiado;
* problema que resuelve;
* comportamiento esperado;
* evidencia o razón de inclusión;
* prioridad;
* dependencias;
* criterios generales de aceptación.

Clasificar cada capacidad como:

* `MUST`: necesaria para que el incremento tenga sentido;
* `SHOULD`: valiosa, pero puede aplazarse sin invalidarlo;
* `COULD`: opcional si existe capacidad disponible;
* `WON'T NOW`: explícitamente excluida.

No utilizar `MUST` como sinónimo de “importante”. Un elemento es `MUST` únicamente cuando su ausencia impide alcanzar el resultado definido.

### 7. Definir límites funcionales

Para cada capacidad incluida, especificar:

* comienzo y final del flujo;
* datos mínimos necesarios;
* roles autorizados;
* estados soportados;
* reglas esenciales;
* errores que deben manejarse;
* canales o plataformas contemplados;
* volumen o escala esperada;
* comportamiento manual permitido.

Esto debe impedir interpretaciones silenciosamente más amplias.

### 8. Definir no objetivos

Crear una sección explícita de `Non-Goals`.

Incluir:

* funcionalidades postergadas;
* actores no cubiertos;
* automatizaciones que seguirán siendo manuales;
* integraciones excluidas;
* casos extremos no soportados;
* optimizaciones prematuras;
* características deseables sin evidencia suficiente.

Cada no objetivo debe explicar brevemente por qué queda fuera:

* baja prioridad;
* falta de evidencia;
* alto riesgo;
* dependencia pendiente;
* coste desproporcionado;
* no necesario para el resultado actual.

### 9. Dividir en incrementos

Organizar el alcance como una secuencia de incrementos verticales.

Cada incremento debe:

* producir valor demostrable;
* ser integrable;
* ser revisable;
* incluir comportamiento, datos, permisos, interfaz y verificación necesarios;
* reducir una incertidumbre relevante;
* evitar depender de una gran entrega final.

Para cada incremento definir:

* resultado;
* capacidades incluidas;
* capacidades excluidas;
* dependencias;
* riesgos;
* señal de éxito;
* condición de finalización.

### 10. Revisar dependencias y orden

Identificar dependencias:

* de producto;
* de datos;
* técnicas;
* legales;
* comerciales;
* operativas;
* de terceros;
* de conocimiento.

Distinguir entre dependencias reales y preferencias de implementación.

No adelantar infraestructura compleja únicamente porque podría ser útil en el futuro.

### 11. Definir restricciones

Documentar restricciones confirmadas, por ejemplo:

* presupuesto;
* fechas externas;
* regulaciones;
* privacidad;
* accesibilidad;
* compatibilidad;
* proveedores obligatorios;
* sistemas existentes;
* capacidad operativa;
* límites de soporte.

No inventar restricciones para justificar decisiones.

### 12. Establecer métricas y señales

Definir cómo se evaluará el incremento.

Incluir:

* resultado esperado;
* indicador principal;
* indicadores secundarios;
* señales cualitativas;
* guardrails;
* método de medición;
* periodo de evaluación.

Evitar métricas decorativas que no cambien decisiones.

### 13. Establecer control de cambios

Todo cambio posterior debe registrar:

* descripción;
* razón;
* evidencia nueva;
* impacto;
* coste;
* riesgo;
* elementos desplazados;
* decisión;
* aprobador.

No ampliar el alcance silenciosamente durante diseño o implementación.

Los defectos necesarios para cumplir el comportamiento acordado no son scope creep. Las nuevas capacidades sí lo son.

### 14. Ejecutar revisión adversarial

Cuestionar:

* ¿El alcance resuelve un problema real o solo reproduce una lista de deseos?
* ¿Existe algún `MUST` que no sea realmente indispensable?
* ¿El core loop funciona de punta a punta?
* ¿Se intenta cubrir demasiados usuarios?
* ¿Hay capacidades incluidas solo “para el futuro”?
* ¿Se omitieron operaciones, soporte, permisos o estados de error?
* ¿El incremento puede demostrar valor sin completar todo el producto?
* ¿Los no objetivos son suficientemente explícitos?
* ¿El éxito puede medirse?
* ¿Las incertidumbres críticas tienen tratamiento?

---

## Entregables

Crear o actualizar `docs/product/scope.md` con:

1. contexto;
2. evidencia utilizada;
3. resultado objetivo;
4. actores prioritarios;
5. core loop;
6. capacidades priorizadas;
7. límites funcionales;
8. no objetivos;
9. incrementos;
10. dependencias;
11. restricciones;
12. métricas;
13. riesgos y unknowns;
14. política de cambios;
15. gate final.

Actualizar `docs/project-status.md` con el estado, bloqueantes y próxima skill recomendada.

---

## Gate final

Asignar uno de estos resultados:

### SCOPE READY

El resultado, los límites, los no objetivos y el próximo incremento están suficientemente claros para continuar.

### CONDITIONAL READY

Puede continuarse con condiciones explícitas, riesgos aceptados o decisiones pendientes no bloqueantes.

### REFINEMENT REQUIRED

Existen ambigüedades, contradicciones o exceso de alcance que deben resolverse antes de diseñar.

### MORE EVIDENCE REQUIRED

Una decisión crítica de alcance depende de supuestos todavía no validados.

### BLOCKED

Faltan autoridad, información, restricciones o decisiones indispensables.

---

## Reglas

Esta skill no debe:

* implementar código;
* diseñar arquitectura definitiva;
* producir wireframes detallados;
* inventar evidencia;
* tratar todas las solicitudes como obligatorias;
* convertir posibilidades futuras en requisitos actuales;
* ocultar contradicciones;
* ampliar el alcance sin registrarlo;
* declarar listo un alcance imposible de verificar.

El informe final debe indicar:

* gate obtenido;
* resultado objetivo;
* incremento recomendado;
* principales exclusiones;
* riesgos aceptados;
* preguntas bloqueantes;
* siguiente skill sugerida.
